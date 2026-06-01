CREATE TABLE IF NOT EXISTS clans (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    leader VARCHAR(100),
    region VARCHAR(100),
    description TEXT,
    str1 TEXT,
    str2 TEXT,
    str3 TEXT,
    legacy TEXT,
    image VARCHAR(100)
);

DO $$
BEGIN
    IF (SELECT COUNT(*) FROM clans) = 0 THEN

        INSERT INTO clans (name, leader, region, description, str1, str2, str3, legacy, image)
        VALUES
        (
            'Oda Clan',
            'Oda Nobunaga',
            'Owari Province',
            'The Oda clan rose to prominence during the turbulent Sengoku period as one of the first major forces to pursue national unification. Under Oda Nobunaga, the clan transformed warfare in Japan through bold reforms and ruthless military campaigns that reshaped the political landscape of the country.',
            'Early adoption of firearms (arquebus)',
            'Aggressive expansion strategy',
            'Strong centralized command structure',
            'The Oda clan laid the foundation for Japan''s unification by breaking the power of regional warlords and introducing modernized warfare. Their influence directly enabled the rise of later rulers who completed the unification process.',
            'Oda.webp'
        ),
        (
            'Tokugawa Clan',
            'Tokugawa Ieyasu',
            'Mikawa Province',
            'The Tokugawa clan emerged as one of the most politically stable and strategic families of the Sengoku period. Tokugawa Ieyasu carefully built alliances and waited for the right moment to seize power, eventually bringing long-lasting peace to Japan.',
            'Strategic patience and planning',
            'Strong alliance networks',
            'Highly disciplined governance',
            'The Tokugawa clan established the Tokugawa Shogunate, which ruled Japan for over 250 years. Their system of governance created one of the longest periods of peace in Japanese history.',
            'Tokugawa.webp'
        ),
        (
            'Takeda Clan',
            'Takeda Shingen',
            'Kai Province',
            'The Takeda clan became legendary for their military excellence during the Sengoku period. Known especially for their powerful cavalry units, they were feared across Japan and engaged in some of the most famous battles of the era.',
            'Elite cavalry warfare',
            'Superior battlefield tactics',
            'Highly trained military structure',
            'The Takeda clan significantly influenced Japanese military strategy, especially through their battlefield innovations. Even after their decline, their tactics were studied by future generations of warlords.',
            'Takeda.webp'
        ),
        (
            'Uesugi Clan',
            'Uesugi Kenshin',
            'Echigo Province',
            'The Uesugi clan was one of the most powerful and respected clans of the Sengoku period. Led by Uesugi Kenshin, often called the Dragon of Echigo, they were known for their strict code of honor and exceptional military skill.',
            'Exceptional battlefield leadership',
            'Strong code of honor and discipline',
            'Powerful regional alliances',
            'The Uesugi clan left a lasting legacy of military honor and strategic brilliance. Kenshin''s rivalry with Takeda Shingen remains one of the most celebrated conflicts in Japanese history.',
            'Uesugi.webp'
        ),
        (
            'Date Clan',
            'Date Masamune',
            'Mutsu Province',
            'The Date clan, led by the fearsome Date Masamune known as the One-Eyed Dragon, was a dominant force in northeastern Japan. Masamune''s aggressive expansion and modernization efforts made the clan one of the most formidable powers of the era.',
            'Rapid territorial expansion',
            'Early adoption of Western technology',
            'Fierce and unpredictable warfare',
            'The Date clan''s influence shaped the development of northeastern Japan for generations. Date Masamune''s vision and ambition left a cultural and political legacy that endured well beyond the Sengoku period.',
            'Date.webp'
        ),
        (
            'Hojo Clan',
            'Hojo Ujiyasu',
            'Sagami Province',
            'The Later Hojo clan was a major power in the Kanto region during the Sengoku period. Under leaders like Hojo Ujiyasu, they built a highly efficient administrative system and defended their territory against numerous powerful rivals.',
            'Strong defensive fortifications',
            'Efficient administrative governance',
            'Effective use of diplomacy alongside warfare',
            'The Hojo clan demonstrated that strong governance and administration were just as important as military power. Their fall to Toyotomi Hideyoshi marked the end of an era for the Kanto region.',
            'Hojo.webp'
        ),
        (
            'Mori Clan',
            'Mori Motonari',
            'Aki Province',
            'The Mori clan rose from a minor family to one of the most powerful forces in western Japan under the leadership of Mori Motonari. Known for his cunning strategy and the famous Three Arrow parable, Motonari built a vast domain through diplomacy and warfare.',
            'Strategic use of diplomacy and deception',
            'Strong naval capabilities',
            'Rapid territorial growth through alliances',
            'The Mori clan dominated western Japan for decades and played a major role in the power struggles of the Sengoku period. Their naval strength and political cunning made them a force that even Oda Nobunaga had to contend with carefully.',
            'Mori.webp'
        ),
        (
            'Chosokabe Clan',
            'Chosokabe Motochika',
            'Tosa Province',
            'The Chosokabe clan rose to unify the island of Shikoku under the ambitious leadership of Chosokabe Motochika. Starting from a small domain, they expanded aggressively until they controlled the entire island, demonstrating remarkable military and political skill.',
            'Unification of Shikoku island',
            'Strong infantry forces',
            'Skilled naval operations',
            'The Chosokabe clan''s unification of Shikoku remains one of the remarkable achievements of the Sengoku period. Though eventually subdued by Toyotomi Hideyoshi, their legacy as rulers of Shikoku endured in regional memory.',
            'Chosokabe.webp'
        ),
        (
            'Shimazu Clan',
            'Shimazu Yoshihisa',
            'Satsuma Province',
            'The Shimazu clan was the dominant power in the southernmost region of Kyushu. Known for their fierce warriors and unique battlefield tactics, they nearly unified all of Kyushu before being halted by Toyotomi Hideyoshi''s massive invasion force.',
            'Unique and aggressive battlefield tactics',
            'Highly motivated and fierce warriors',
            'Strong regional dominance in Kyushu',
            'The Shimazu clan''s near unification of Kyushu demonstrated their extraordinary military power. Even after their submission to Hideyoshi, they remained one of the most powerful clans in Japan and later played a key role in the Meiji Restoration.',
            'Shimazu.webp'
        ),
        (
            'Toyotomi Clan',
            'Toyotomi Hideyoshi',
            'Owari Province',
            'The Toyotomi clan, built by the legendary Toyotomi Hideyoshi who rose from a peasant to the ruler of Japan, achieved what Oda Nobunaga had started — the unification of the entire country. Hideyoshi''s political genius and military campaigns brought the Sengoku period to an effective close.',
            'Complete unification of Japan',
            'Masterful political and diplomatic skill',
            'Innovative military logistics',
            'Toyotomi Hideyoshi''s unification of Japan stands as one of the greatest political and military achievements in Japanese history. Though the Toyotomi line was extinguished by the Tokugawa after his death, his transformation of Japan left an indelible mark on the country.',
            'Toyotomi.webp'
        );

    END IF;
END $$;
