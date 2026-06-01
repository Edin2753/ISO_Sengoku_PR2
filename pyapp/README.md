# Sengoku App — AWS Update Changelog

This document explains every change made to the app compared to the
original local Docker Compose version, and the reasoning behind each one.

---

## What changed and why

### 1. `docker-compose.yml` — removed the `db` service

**Before:**
```yaml
services:
  frontend:
  backend:
  db:          # local postgres container
volumes:
  pgdata:
```

**After:**
```yaml
services:
  frontend:
  backend:
  # db removed — using Amazon RDS instead
```

**Why:** On AWS the database is Amazon RDS (a managed PostgreSQL service).
We no longer need or want a local postgres container — RDS handles backups,
availability, and maintenance for us. The `pgdata` volume is also gone since
there is no local data to persist.

Both services now use `network_mode: host` so that nginx (frontend) can
reach Flask (backend) via `localhost:5000` on the same EC2 machine.

**The dev branch still has the original 3-service version** for local development.

---

### 2. `docker-compose.yml` — DB credentials now use environment variables

**Before:**
```yaml
environment:
  DB_HOST: db
  DB_NAME: sengoku
  DB_USER: postgres
  DB_PASSWORD: postgres
```

**After:**
```yaml
environment:
  DB_HOST: ${DB_HOST}
  DB_NAME: ${DB_NAME}
  DB_USER: ${DB_USER}
  DB_PASSWORD: ${DB_PASSWORD}
```

**Why:** The values are no longer hardcoded. Instead docker-compose reads them
from environment variables set in the shell before running. On AWS these come
from the Terraform deploy script which captures the RDS endpoint automatically:

```bash
export DB_HOST=$(terraform output -raw rds_endpoint)
export DB_NAME="sengoku"
export DB_USER="postgres"
export DB_PASSWORD="yourpassword"
docker-compose up -d --build
```

`app.py` did not need any changes — it already used `os.getenv()` to read
these values. The change is only in how the values are supplied.

---

### 3. `frontend/nginx.conf` — proxy target changed to localhost

**Before:**
```nginx
location /clan/ {
    proxy_pass http://backend:5000/clan/;
}
```

**After:**
```nginx
location /clan/ {
    proxy_pass http://localhost:5000/clan/;
}
```

**Why:** `backend` was a Docker Compose network hostname — it only existed
because docker-compose created a virtual network between containers.
On AWS both containers run on the same EC2 instance with `network_mode: host`,
so Flask is reachable at `localhost:5000` directly.

---

### 4. `db/init.sql` — wrapped inserts in an idempotency guard

**Before:** Plain `CREATE TABLE` + bare `INSERT INTO` statements.
Running the script twice would fail on CREATE and insert duplicate rows.

**After:**
```sql
CREATE TABLE IF NOT EXISTS clans (...);

DO $$
BEGIN
    IF (SELECT COUNT(*) FROM clans) = 0 THEN
        INSERT INTO clans (...) VALUES (...);
        -- all other inserts...
    END IF;
END $$;
```

**Why:** Both EC2 instances run this script on first boot (via Terraform
user_data). Without this guard, whichever EC2 runs second would insert
all 10 clans again, giving you duplicates in the database.

With the guard:
- First EC2 runs → table is empty → inserts all 10 clans ✅
- Second EC2 runs → table has 10 rows → skips entirely ✅
- Either EC2 reboots and reruns → still skips ✅

---

### 5. Files that did NOT change

| File | Reason |
|------|--------|
| `backend/app.py` | Already reads all config from `os.getenv()` — nothing to change |
| `backend/Dockerfile` | Works as-is |
| `backend/requirements.txt` | Works as-is |
| `frontend/Dockerfile` | Works as-is |
| `frontend/index.html` | Image paths will be updated separately when S3 URL is known after `terraform apply` |
| `frontend/about.html` | Same as above |

---

## How to run on AWS (manual deploy)

After Terraform has created your infrastructure:

```bash
# 1. SSH into each EC2 instance
ssh -i your-key.pem ec2-user@<EC2_IP>

# 2. Clone your repo
git clone https://github.com/yourusername/pyapp.git
cd pyapp

# 3. Set environment variables (use your real RDS endpoint and password)
export DB_HOST="sengoku-db.xxxxxx.us-east-1.rds.amazonaws.com"
export DB_NAME="sengoku"
export DB_USER="postgres"
export DB_PASSWORD="yourpassword"

# 4. Run the deploy script
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```

Repeat steps 1-4 for the second EC2 instance.
The `init.sql` guard means it's safe to run on both — whichever runs first seeds the DB.

---

## Branch structure

| Branch | Purpose |
|--------|---------|
| `main` | AWS version — 2 services, RDS, this README |
| `dev` | Local version — 3 services including local postgres container |

When merging features from `dev` to `main`, do not merge `docker-compose.yml`.
