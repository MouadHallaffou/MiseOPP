-- Niveau Avancé (Difficile)
-- Trouver les 5 auteurs les plus vendus (en quantité) avec le revenu total généré par leurs livres
SELECT 
    a.id,
    a.name,
    sales.total_quantity_sold,
    sales.total_revenue
FROM 
    authors a
JOIN (
    SELECT 
        b.author_id,
        SUM(oi.quantity) AS total_quantity_sold,
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM 
        books b
    JOIN 
        order_items oi ON b.id = oi.book_id
    JOIN 
        orders o ON oi.order_id = o.id
    WHERE 
        o.status = 'paid'
    GROUP BY 
        b.author_id
) sales ON a.id = sales.author_id
ORDER BY 
    sales.total_quantity_sold DESC
LIMIT 5;
-- Calculer le taux de conversion des vues en téléchargements pour chaque livre (téléchargements/vues * 100)
SELECT 
    b.id, 
    b.title, 
    b.views, 
    b.downloads,
    CASE 
        WHEN b.views = 0 THEN 0 
        ELSE ROUND((b.downloads * 100.0 / b.views), 2) 
    END AS conversion_rate
FROM 
    books b
ORDER BY 
    conversion_rate DESC;
--Trouver les utilisateurs qui ont acheté tous les livres d'un certain auteur
SELECT u.id, u.full_name 
FROM users u
JOIN orders o ON o.user_id = u.id
JOIN order_items oi ON o.id = oi.order_id
JOIN books b ON oi.book_id = b.id
WHERE b.author_id = 1 
AND o.status = 'paid'
GROUP BY u.id, u.full_name
HAVING COUNT(DISTINCT b.id) = (
    SELECT COUNT(*) 
    FROM books 
    WHERE author_id = 1
);
-- Calculer le chiffre d'affaires mensuel avec une comparaison avec le mois précédent (growth rate)
SELECT 
    DATE_FORMAT(p.created_at, '%Y-%m') AS mois,
    SUM(p.amount) AS chiffre_affaire,
    LAG(SUM(p.amount)) OVER (ORDER BY DATE_FORMAT(p.created_at, '%Y-%m')) AS mois_precedent,
    ROUND(
        (SUM(p.amount) - LAG(SUM(p.amount)) OVER (ORDER BY DATE_FORMAT(p.created_at, '%Y-%m'))) / 
        LAG(SUM(p.amount)) OVER (ORDER BY DATE_FORMAT(p.created_at, '%Y-%m')) * 100, 
    2
    ) AS evolution_pourcentage
FROM 
    payments p
WHERE 
    p.status = 'paid'
GROUP BY 
    DATE_FORMAT(p.created_at, '%Y-%m')
ORDER BY 
    mois;

Trouver les paires de livres fréquemment achetés ensemble (market basket analysis)

Calculer la valeur à vie (LTV) moyenne des clients qui ont effectué plus de 3 achats

Trouver les livres qui ont une augmentation significative des ventes ce mois-ci par rapport à la moyenne des 3 derniers mois

Identifier les utilisateurs inactifs (pas de connexion depuis 3 mois) avec un historique d'achat

Calculer le temps moyen entre le premier achat et le deuxième achat pour les utilisateurs

Trouver les catégories avec le plus haut taux de rétention (clients achetant à nouveau dans la même catégorie)

Niveau Intermédiaire
Lister les livres avec une réduction supérieure à 20% (où original_price - price > 20% de original_price)

Trouver les auteurs dont les livres sont dans au moins 3 catégories différentes

Calculer le panier moyen par tranche d'âge des utilisateurs

Lister les commandes avec des items à la fois physiques et numériques

Trouver les utilisateurs ayant des items dans leur panier depuis plus de 7 jours

Calculer le pourcentage de livres numériques vs physiques vendus par catégorie

Trouver les livres les mieux notés mais avec peu de ventes

Lister les commandes payées mais non complétées (statut différent de 'completed')

Trouver les mois avec un chiffre d'affaires supérieur à la moyenne

Calculer le nombre moyen de livres par commande par utilisateur

Lister les auteurs avec le plus grand écart de prix entre leur livre le plus cher et le moins cher

Trouver les utilisateurs ayant acheté dans toutes les catégories principales

Calculer le temps moyen entre la commande et l'expédition pour les livres physiques

Identifier les livres souvent mis en wishlist mais rarement achetés

Trouver les utilisateurs avec le plus de livres dans leur wishlist mais aucun achat

Niveau Débutant (Facile)
Lister tous les livres d'un auteur spécifique

Afficher les commandes d'un utilisateur avec le détail des items

Trouver les livres les plus vendus (en quantité)

Calculer le revenu total par catégorie

Lister les utilisateurs avec leur nombre de commandes

Afficher les livres avec une note moyenne supérieure à 4

Trouver les auteurs encore en vie (sans date de décès)

Lister les livres disponibles à la fois en format physique et numérique

Afficher les catégories avec le nombre de livres associés

Trouver les commandes non payées après 7 jours

Lister les utilisateurs avec leur dernier date de connexion

Afficher les livres avec moins de 10 exemplaires en stock

Trouver les livres les plus consultés (views) mais non achetés

Lister les auteurs par nationalité avec le compte de livres

Afficher les commandes expédiées sans numéro de suivi

Trouver les utilisateurs sans adresse complète (ville ou pays manquant)

Lister les livres publiés l'année en cours

Afficher les catégories sans livres associés

Trouver les livres avec la plus longue description

Lister les utilisateurs avec plus de 3 livres dans leur wishlist

Afficher les auteurs nés après 1980

Trouver les livres avec un prix inférieur à la moyenne de leur catégorie

Lister les commandes avec un montant total supérieur à 100€

Afficher les utilisateurs sans commandes

Trouver les livres sans auteur associé

Lister les catégories parentes avec le nombre de sous-catégories

Afficher les livres ajoutés au cours du dernier mois

Trouver les utilisateurs avec le même livre dans le panier et la wishlist

Lister les paiements échoués avec le montant et la méthode

Afficher les livres avec un titre contenant le mot "programmation"

Trouver les commandes avec exactement 2 items



-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour easyprint
CREATE DATABASE IF NOT EXISTS `easyprint` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `easyprint`;

-- Listage de la structure de table easyprint. authors
CREATE TABLE IF NOT EXISTS `authors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `birth_date` date DEFAULT NULL,
  `death_date` date DEFAULT NULL,
  `nationality` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.authors : ~13 rows (environ)
INSERT INTO `authors` (`id`, `name`, `photo`, `bio`, `birth_date`, `death_date`, `nationality`, `created_at`, `updated_at`) VALUES
	(1, 'Alec Tran', 'authors/MW4E5irYjOZ9YmKB7Bu1h4VubZMjfz4Xac2GC7rW.jpg', 'Non rerum praesentiu', '1992-08-19', '2010-07-16', 'Finland', '2025-04-04 21:50:12', '2025-04-04 21:50:12'),
	(2, 'Maddison Schulist', 'https://via.placeholder.com/640x480.png/006699?text=people+eum', 'Necessitatibus omnis quia aut sed. Et consequatur quam omnis molestias expedita numquam. Optio magni labore occaecati non quae.', '1931-05-22', '2005-08-30', 'Mozambique', '2025-04-04 21:56:22', '2025-04-04 21:56:22'),
	(3, 'Abby Dach', 'https://via.placeholder.com/640x480.png/0044bb?text=people+totam', 'Debitis sint illum consequatur voluptas est ea. Voluptas rerum est sit est est dolor deleniti. Porro est dolore esse fugiat nihil aut nobis rerum.', '1967-12-11', '2025-04-04', 'Netherlands', '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(4, 'Miss Eden Ratke', 'https://via.placeholder.com/640x480.png/006666?text=people+expedita', 'Sed animi sint dolores itaque aut dolorem saepe alias. Debitis qui et id facilis. Qui consectetur nostrum optio repellat error esse. Laborum eaque aspernatur veritatis iusto.', '1999-04-07', '2025-04-04', 'Tajikistan', '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(5, 'Lou Shanahan', 'https://via.placeholder.com/640x480.png/00aa22?text=people+eos', 'Delectus saepe quas ad eius inventore id. Eligendi tempora tempore suscipit nulla tempore. Accusantium dignissimos sit enim et consectetur. Maxime totam et aut dolores debitis cumque aut.', '1929-01-25', '2025-04-04', 'Turkey', '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(6, 'Jaron Corkery', 'https://via.placeholder.com/640x480.png/00ff11?text=people+non', 'Et natus qui ut. Vitae nihil velit nulla accusamus accusantium. Nihil laboriosam maxime voluptas architecto et et.', '1961-06-24', '2025-04-04', 'Mayotte', '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(7, 'Dr. Darron Walker', 'https://via.placeholder.com/640x480.png/0088dd?text=people+commodi', 'Ea omnis ducimus dolore accusantium aliquid ut dolores. Molestias nemo dolores et id rerum. Consequatur possimus omnis quaerat qui.', '1962-12-06', '2025-04-04', 'French Southern Territories', '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(8, 'Ayana Lebsack', 'https://via.placeholder.com/640x480.png/00cc88?text=people+aut', 'Praesentium iste a voluptas excepturi nostrum at. Eum sint eos sit commodi. Voluptatem sapiente sed repudiandae id. Minus rerum vero unde vel.', '1938-06-01', '1995-12-02', 'Jordan', '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(9, 'Josh Leannon Jr.', 'https://via.placeholder.com/640x480.png/0066ee?text=people+porro', 'Est sequi et quia et et eveniet ut. Aspernatur numquam nemo expedita saepe.', '1943-11-05', '2025-04-04', 'Libyan Arab Jamahiriya', '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(11, 'Myron Mann', 'https://via.placeholder.com/640x480.png/008855?text=people+ut', 'Fugiat exercitationem quas itaque earum. Asperiores laboriosam similique ab harum. Magni voluptatibus amet rem ea ut rem quos. Rerum nobis amet sunt excepturi qui consequatur ipsa similique.', '1954-12-06', '2025-04-04', 'Ecuador', '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(12, 'Sabrina Greenholt', 'https://via.placeholder.com/640x480.png/00ddcc?text=people+corporis', 'Fugit excepturi hic dolorem et voluptatibus. Vel error ut ut nihil. Modi aliquam deserunt fugit dolorem id modi. Cupiditate sed repellendus dolores corporis incidunt omnis.', '1991-08-21', '2025-04-04', 'Denmark', '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(13, 'Robert Okuneva I', 'https://via.placeholder.com/640x480.png/005577?text=people+quibusdam', 'Perferendis accusantium adipisci vel accusamus molestiae delectus quo. Nesciunt ullam aliquid ex accusamus. Voluptates corporis quod deserunt laborum cupiditate. Non eveniet quasi ea.', '1930-06-15', '2025-04-04', 'South Georgia and the South Sandwich Islands', '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(14, 'Lessie Tromp', 'https://via.placeholder.com/640x480.png/0022dd?text=people+consequatur', 'Provident qui in doloribus molestiae impedit ullam. Suscipit et magnam consequatur nisi ut totam.', '1934-08-07', '1946-03-18', 'Antigua and Barbuda', '2025-04-04 21:57:23', '2025-04-04 21:57:23');

-- Listage de la structure de table easyprint. books
CREATE TABLE IF NOT EXISTS `books` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint unsigned DEFAULT NULL,
  `author_id` bigint unsigned DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(8,2) NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `type` enum('physical','digital') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'digital',
  `publication_year` year DEFAULT NULL,
  `language` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_count` int DEFAULT NULL,
  `pdf_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` decimal(2,1) NOT NULL DEFAULT '0.0',
  `views` int NOT NULL DEFAULT '0',
  `downloads` int NOT NULL DEFAULT '0',
  `original_price` decimal(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `download_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `books_category_id_foreign` (`category_id`),
  KEY `books_author_id_foreign` (`author_id`),
  CONSTRAINT `books_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`) ON DELETE SET NULL,
  CONSTRAINT `books_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.books : ~14 rows (environ)
INSERT INTO `books` (`id`, `cover`, `title`, `category_id`, `author_id`, `description`, `price`, `stock`, `type`, `publication_year`, `language`, `page_count`, `pdf_path`, `rating`, `views`, `downloads`, `original_price`, `created_at`, `updated_at`, `download_path`) VALUES
	(1, 'covers/zhaPK2E5MMREDGvyRJdGcGVY315Y6JgDBkmojKIl.jpg', 'Consequatur aut nost', 2, 1, 'Velit Nam saepe even', 2.00, 65, 'digital', '2005', 'English', 89, 'documents/hQjz5Okxaba5QbLh3uxI6bUt1xIKNAlAUMXtT2su.pdf', 0.0, 1, 2, 2.40, '2025-04-04 21:51:00', '2025-04-20 13:51:43', NULL),
	(2, 'covers/8cm3r0ciqVIoS4vu2IlpCrw26K6FfCyRtdShNsjn.png', 'Asperiores beatae eius voluptatem eaque quibusdam.', 5, 2, 'Aliquam laborum fugiat minus et. Deleniti illum magnam sint. Dolorem et illo ratione deserunt temporibus laudantium eum vero. Magni vero nemo omnis cum officiis.', 26.69, 17, 'digital', '1990', 'English', 79, 'http://www.raynor.com/', 0.5, 2122, 1797, 30.00, '2025-04-04 21:56:22', '2025-04-20 16:50:35', NULL),
	(3, 'covers/HABwW9AhQJOrUf0000C66FTRuhdnZwoz80YMJzyl.png', 'Minima veritatis sed aspernatur.', 1, 3, 'Dolores nesciunt omnis delectus rerum quia. Aut officia et quaerat est quas soluta distinctio excepturi. Laborum id et earum nulla magni explicabo. Et molestiae et quia minima voluptatem.', 74.82, 15, 'digital', '1994', 'English', 209, 'http://hamill.org/', 4.1, 6538, 4370, 0.00, '2025-04-04 21:57:23', '2025-04-20 16:50:44', NULL),
	(4, 'covers/4mPYYRmC4VhIbMMBeebojciUn7EGMxUeGAzO1myC.png', 'Ut perferendis est sequi.', 7, 4, 'Quis eos similique asperiores repellendus architecto. Laborum nostrum ipsum aperiam id sed eum. Quos qui animi dolorum autem necessitatibus rerum similique.', 91.40, 85, 'digital', '1994', 'English', 68, 'https://torphy.info/dolore-quia-assumenda-sit-reiciendis.html', 4.4, 2398, 3148, 0.00, '2025-04-04 21:57:23', '2025-04-20 16:50:55', NULL),
	(5, 'covers/XDMELPHSTRvKTrfsyysXzBe1KDcXjrm5Hda3SNX4.png', 'Sed rerum et facere ullam.', 2, 5, 'Commodi reiciendis cupiditate est totam. Rem facere rem impedit magnam. Placeat perferendis veniam molestiae. Qui voluptas minima veritatis.', 66.57, 49, 'digital', '2012', 'English', 302, 'http://www.hane.biz/beatae-delectus-soluta-ut-veniam-vel', 3.5, 7895, 519, 0.00, '2025-04-04 21:57:23', '2025-04-20 16:51:09', NULL),
	(6, 'covers/uIAWDXTqxGy7nLPxSmfgHYkQtmoJbsSsGlJ606PL.png', 'Cum est at hic.', 5, 6, 'Maiores perferendis non ut iste est. Ut id est blanditiis accusamus tenetur magni et.', 81.25, 34, 'digital', '1997', 'English', 229, 'http://larkin.info/sit-sed-fuga-corrupti-rerum-alias-ullam-fuga', 0.6, 6065, 581, 0.00, '2025-04-04 21:57:23', '2025-04-20 16:51:28', NULL),
	(7, 'covers/SEwMJ8D9RUyKDgmjXtxrX2ZcwIU6brFcqmhskc7O.png', 'Doloremque ut dolor modi commodi.', 18, 7, 'Veniam voluptas aperiam sit optio. Et et expedita molestias ea. Consequatur dolores magnam deserunt. Doloremque minus et nobis voluptatem et rerum modi ut.', 76.84, 70, 'digital', '1993', 'English', 261, 'http://www.jacobson.com/', 3.5, 5086, 4434, 0.00, '2025-04-04 21:57:23', '2025-04-20 16:52:02', NULL),
	(8, 'covers/hrhk3b15fUWLCmhyEiUK3X6PkOGrzSaWpAj05lC6.png', 'Officia porro voluptatibus aut.', 5, 8, 'Ad voluptatum amet id. Et ab necessitatibus culpa dignissimos id ea incidunt.', 37.69, 10, 'digital', '1970', 'English', 461, 'http://www.boyle.com/labore-fugiat-numquam-sapiente-fugiat', 2.9, 6032, 602, 0.00, '2025-04-04 21:57:23', '2025-04-20 16:55:28', NULL),
	(10, 'covers/fyIZDSgmZaKyTkaVqd5ft0e2PyhPrS1NZPDn0lTT.png', 'Sint error qui dicta.', 20, 4, 'Deleniti enim quaerat vero enim eum ut earum deleniti. Est quod fugit voluptates consectetur amet. Vel nesciunt totam ipsum dolores accusantium numquam. Porro voluptatem possimus animi est.', 22.41, 17, 'digital', '2013', 'English', 230, 'http://www.lemke.com/nostrum-occaecati-qui-autem-molestias-nihil-quisquam-animi-sed', 4.7, 778, 3068, 0.00, '2025-04-04 21:57:23', '2025-04-20 16:55:42', NULL),
	(11, 'covers/6r47iiLaUdp2TwVdlunUApZWcnXOw37GnrukOdsi.png', 'Facere autem sed sit saepe.', 4, 11, 'Earum cum maxime enim harum. Dolor vel dolor aperiam nobis aut hic reprehenderit.', 8.06, 36, 'digital', '2013', 'English', 100, 'http://www.lowe.org/qui-voluptatibus-officiis-qui-dignissimos-aut-ipsum.html', 2.5, 591, 864, 0.00, '2025-04-04 21:57:23', '2025-04-20 16:55:57', NULL),
	(12, 'covers/8gNemdyTR2hiJhMy2cN7wJwTuPjUejxQgFvQ7NBu.png', 'Aut rerum nihil nihil omnis.', 4, 12, 'Facilis ullam occaecati magni necessitatibus eaque nam. Aut molestias dolores doloremque dolor recusandae.', 24.24, 52, 'digital', '1990', 'English', 311, 'http://howe.net/', 2.2, 6579, 2913, 0.00, '2025-04-04 21:57:23', '2025-04-20 16:56:13', NULL),
	(13, 'covers/OjrPeuaB6nyslVgRtPG523VtZoQ5ICwSTEvV5tq9.png', 'Blanditiis autem vitae qui sit.', 4, 13, 'Ut et aliquid distinctio enim at id hic. Aut omnis dolores tenetur eum. Cum voluptatem necessitatibus quod et magnam voluptas totam.', 13.44, 22, 'digital', '1994', 'English', 328, 'http://hartmann.com/dolor-a-autem-est-eius-a-aut-qui', 3.6, 8916, 1178, 0.00, '2025-04-04 21:57:23', '2025-04-20 16:56:36', NULL),
	(15, 'covers/U8nW21Vux24vhGMRiSVrLGlAaYIf8JgX9B6sX8AV.jpg', 'Molestiae a similiqu', 6, 7, 'Perspiciatis magni', 10.00, 828, 'digital', '2013', 'English', 39, 'documents/RepiL6qR5iTrrl5GCp5XaaC5hEmooMCuuCBvd5Cx.pdf', 0.0, 0, 0, 12.00, '2025-04-05 00:02:28', '2025-04-20 11:42:13', NULL),
	(16, 'covers/ERgSBqb49nUOegVqyeCaoLaHO9JLxbrFzRSIbkR3.jpg', 'Do hic velit quis e', 2, 14, 'Porro quibusdam labo', 366.00, 296, 'digital', '1989', 'Spanish', 38, 'documents/PCGGVCgpv4Knwff1fRheqXNaOgHbqVKwxxgK0YXi.pdf', 0.0, 0, 0, 1700.00, '2025-04-05 00:14:18', '2025-04-05 00:15:05', NULL);

-- Listage de la structure de table easyprint. carts
CREATE TABLE IF NOT EXISTS `carts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_user_id_foreign` (`user_id`),
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.carts : ~3 rows (environ)
INSERT INTO `carts` (`id`, `user_id`, `created_at`, `updated_at`) VALUES
	(2, 1, '2025-04-06 17:23:04', '2025-04-06 17:23:04'),
	(15, 3, '2025-04-20 13:48:19', '2025-04-20 13:48:19'),
	(16, 9, '2025-04-20 13:51:43', '2025-04-20 13:51:43');

-- Listage de la structure de table easyprint. cart_items
CREATE TABLE IF NOT EXISTS `cart_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_items_cart_id_foreign` (`cart_id`),
  KEY `cart_items_book_id_foreign` (`book_id`),
  CONSTRAINT `cart_items_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.cart_items : ~4 rows (environ)
INSERT INTO `cart_items` (`id`, `cart_id`, `book_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
	(57, 15, 2, 1, 26.69, '2025-04-20 17:08:39', '2025-04-20 17:08:39'),
	(58, 15, 3, 1, 74.82, '2025-04-20 17:08:41', '2025-04-20 17:08:41'),
	(59, 15, 4, 1, 91.40, '2025-04-20 17:08:42', '2025-04-20 17:08:42'),
	(61, 15, 1, 1, 2.00, '2025-04-21 08:57:55', '2025-04-21 08:57:55');

-- Listage de la structure de table easyprint. categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.categories : ~21 rows (environ)
INSERT INTO `categories` (`id`, `name`, `parent_id`, `image`, `deleted_at`, `created_at`, `updated_at`) VALUES
	(1, 'Sciences', NULL, 'categories/ZlU2PfQvswZG4uufqWi4vE90s35LLUvbvnGgMAa9.png', NULL, '2025-04-03 22:21:28', '2025-04-20 16:53:31'),
	(2, 'Developement', NULL, 'categories/pm6N54Bb7c24K8EI2obatDf28r3uhpLlZGTFUaYj.png', NULL, '2025-04-04 00:14:30', '2025-04-20 16:53:18'),
	(3, 'Math', 1, 'categories/aVQztIvYYWtOONcx0C2TVAbCwpj48Ll4LWSP5DkQ.png', NULL, '2025-04-04 00:14:41', '2025-04-20 16:53:10'),
	(4, 'Biologie', 1, 'categories/1e2pqQDgSalweSBTJGfS2q0aNssSCS4iC5LugEAb.png', NULL, '2025-04-04 00:15:00', '2025-04-20 16:53:42'),
	(5, 'Data', NULL, 'categories/p8NwpMQUn4nTs5jLXSFydqLt7o8FSVjGEiIf1dP1.png', NULL, '2025-04-04 21:56:22', '2025-04-20 16:53:52'),
	(6, 'incidunt', 5, 'https://via.placeholder.com/640x480.png/009955?text=cats+et', NULL, '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(7, 'est', 6, 'https://via.placeholder.com/640x480.png/0066bb?text=cats+eos', NULL, '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(8, 'sit', 1, 'https://via.placeholder.com/640x480.png/00eeee?text=cats+sapiente', '2025-04-19 15:39:56', '2025-04-04 21:57:23', '2025-04-19 15:39:56'),
	(9, 'sunt', 1, 'https://via.placeholder.com/640x480.png/0099aa?text=cats+aliquid', '2025-04-19 15:42:27', '2025-04-04 21:57:23', '2025-04-19 15:42:27'),
	(10, 'exercitationem', 7, 'https://via.placeholder.com/640x480.png/0044ff?text=cats+reprehenderit', NULL, '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(11, 'sed', NULL, 'https://via.placeholder.com/640x480.png/001166?text=cats+vitae', '2025-04-19 15:29:07', '2025-04-04 21:57:23', '2025-04-19 15:29:07'),
	(12, 'in', 5, 'https://via.placeholder.com/640x480.png/005588?text=cats+in', NULL, '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(13, 'porro', NULL, 'https://via.placeholder.com/640x480.png/003399?text=cats+rerum', '2025-04-19 16:20:46', '2025-04-04 21:57:23', '2025-04-19 16:20:46'),
	(14, 'vel', 3, 'https://via.placeholder.com/640x480.png/00aa44?text=cats+itaque', '2025-04-19 15:45:36', '2025-04-04 21:57:23', '2025-04-19 15:45:36'),
	(15, 'eligendi', NULL, 'https://via.placeholder.com/640x480.png/008833?text=cats+et', '2025-04-19 16:20:36', '2025-04-04 21:57:23', '2025-04-19 16:20:36'),
	(16, 'optio', 21, 'https://via.placeholder.com/640x480.png/00aa55?text=cats+et', NULL, '2025-04-04 21:57:23', '2025-04-20 17:29:07'),
	(17, 'esse', 5, 'https://via.placeholder.com/640x480.png/0033dd?text=cats+sapiente', NULL, '2025-04-04 21:57:23', '2025-04-04 21:57:23'),
	(18, 'Data Analytique', 2, 'categories/6HqSZDjKokbVx2i8cnIsr0LO5BnvjaWedgc5eGn5.gif', NULL, '2025-04-19 14:55:27', '2025-04-19 14:55:27'),
	(19, 'CyberSecurite', 2, 'categories/TgtK5HEaAmQiamyQhnLuwfB7jzcB8iwK4KHu4tFx.jpg', NULL, '2025-04-19 15:28:16', '2025-04-19 15:28:46'),
	(20, 'DevOps', 2, NULL, NULL, '2025-04-19 21:29:57', '2025-04-19 21:29:57'),
	(21, 'Finances', NULL, 'categories/MfVyhKdNbyJteRRkPXTfjaMYxcm6b43yH6CRpDhZ.png', NULL, '2025-04-19 23:01:43', '2025-04-20 16:54:32');

-- Listage de la structure de table easyprint. orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` enum('pending','paid','processing','shipped','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `tracking_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `stripe_session_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_number_unique` (`number`),
  KEY `orders_user_id_foreign` (`user_id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.orders : ~43 rows (environ)
INSERT INTO `orders` (`id`, `number`, `user_id`, `subtotal`, `total`, `status`, `tracking_number`, `paid_at`, `stripe_session_id`, `created_at`, `updated_at`) VALUES
	(1, 'ORD-20250406174408', 3, 25.00, 25.00, 'pending', NULL, NULL, NULL, '2025-04-06 17:44:08', '2025-04-06 17:44:08'),
	(2, 'ORD-20250406174505', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 17:45:05', '2025-04-06 17:45:05'),
	(3, 'ORD-20250406174958', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 17:49:58', '2025-04-06 17:49:58'),
	(4, 'ORD-20250406175522', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 17:55:22', '2025-04-06 17:55:22'),
	(5, 'ORD-20250406175532', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 17:55:32', '2025-04-06 17:55:32'),
	(6, 'ORD-20250406175717', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 17:57:17', '2025-04-06 17:57:17'),
	(7, 'ORD-20250406175736', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 17:57:36', '2025-04-06 17:57:36'),
	(8, 'ORD-20250406175745', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 17:57:45', '2025-04-06 17:57:45'),
	(9, 'ORD-20250406180242', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 18:02:42', '2025-04-06 18:02:42'),
	(10, 'ORD-20250406180615', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 18:06:15', '2025-04-06 18:06:15'),
	(11, 'ORD-20250406181141', 3, 5.00, 5.00, 'paid', NULL, '2025-04-06 18:13:44', 'cs_test_a1Zq4pZHAC1I7UllD9hyIWf19Fr5bZFhYFJd9exhJsHBgvYa2RZxien2cd', '2025-04-06 18:11:41', '2025-04-06 18:13:44'),
	(12, 'ORD-20250406181819', 3, 26.69, 26.69, 'processing', NULL, NULL, 'cs_test_a1q0BNtGPEEie0elouA4raibBVjMsAIBGX3julH860sQwbUfmLoV2lC84Y', '2025-04-06 18:18:19', '2025-04-06 18:18:20'),
	(13, 'ORD-20250406182050', 3, 26.69, 26.69, 'paid', NULL, '2025-04-06 18:21:26', 'cs_test_a1fMfr4DXhdME9PzWB2U0HuT7c8v6SKnRTzKb6uPoEAI3WsEMJbgr6smyo', '2025-04-06 18:20:50', '2025-04-06 18:21:26'),
	(14, 'ORD-20250406182242', 3, 26.69, 26.69, 'paid', NULL, '2025-04-06 18:23:11', 'cs_test_a1lFvbJ1zioNVo0rkQ8czDt7aCU2dGUk51oua4qagxJggGYPxczh3oxcZH', '2025-04-06 18:22:42', '2025-04-06 18:23:11'),
	(15, 'ORD-20250406182647', 3, 5.00, 5.00, 'paid', NULL, '2025-04-06 18:31:05', 'cs_test_a1hlm0Zufl4Jw9jv6LhL7FTYNX27jdEB7fOF8uE6tj5hnYcgiqVQuYATAx', '2025-04-06 18:26:47', '2025-04-06 18:31:05'),
	(16, 'ORD-20250406183906', 3, 5.00, 5.00, 'paid', NULL, '2025-04-06 19:29:52', 'cs_test_a1xQWbOeyOCxBjPdQzPyJhsyq0XZG1gbj0Ono9boS7qj7kM1WyoYijJt6B', '2025-04-06 18:39:06', '2025-04-06 19:29:52'),
	(17, 'ORD-20250406193038', 3, 5.00, 5.00, 'paid', NULL, '2025-04-06 19:31:19', 'cs_test_a1beIdAVtPdUx3NnnaWfrhwlE7rZAxBkg6jd6beSlUeL6m1xGj2l7s4YyK', '2025-04-06 19:30:38', '2025-04-06 19:31:19'),
	(18, 'ORD-20250406210617', 3, 366.00, 366.00, 'pending', NULL, NULL, NULL, '2025-04-06 21:06:17', '2025-04-06 21:06:17'),
	(19, 'ORD-20250406210717', 3, 366.00, 366.00, 'pending', NULL, NULL, NULL, '2025-04-06 21:07:17', '2025-04-06 21:07:17'),
	(20, 'ORD-20250406210734', 3, 366.00, 366.00, 'pending', NULL, NULL, NULL, '2025-04-06 21:07:34', '2025-04-06 21:07:34'),
	(21, 'ORD-20250406210753', 3, 366.00, 366.00, 'pending', NULL, NULL, NULL, '2025-04-06 21:07:53', '2025-04-06 21:07:53'),
	(22, 'ORD-20250406210939', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 21:09:39', '2025-04-06 21:09:39'),
	(23, 'ORD-20250406211023', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 21:10:23', '2025-04-06 21:10:23'),
	(24, 'ORD-20250406211117', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 21:11:17', '2025-04-06 21:11:17'),
	(25, 'ORD-20250406211648', 3, 5.00, 5.00, 'pending', NULL, NULL, NULL, '2025-04-06 21:16:48', '2025-04-06 21:16:48'),
	(26, 'ORD-20250406212050', 3, 5.00, 5.00, 'paid', NULL, '2025-04-06 21:21:53', 'cs_test_a1Cp6HYt5c6rf0HGWsXT8KSW5gNAByFtrqD82xhNxnA2d403TBlIL5dzJr', '2025-04-06 21:20:50', '2025-04-06 21:21:53'),
	(27, 'ORD-20250413135545', 3, 10.00, 10.00, 'pending', NULL, NULL, NULL, '2025-04-13 12:55:45', '2025-04-13 12:55:45'),
	(28, 'ORD-20250413135644', 3, 10.00, 10.00, 'pending', NULL, NULL, NULL, '2025-04-13 12:56:44', '2025-04-13 12:56:44'),
	(29, 'ORD-20250413135735', 3, 84.82, 84.82, 'pending', NULL, NULL, NULL, '2025-04-13 12:57:35', '2025-04-13 12:57:35'),
	(30, 'ORD-20250413135944', 3, 366.00, 366.00, 'pending', NULL, NULL, NULL, '2025-04-13 12:59:44', '2025-04-13 12:59:44'),
	(31, 'ORD-20250413140311', 3, 366.00, 366.00, 'pending', NULL, NULL, NULL, '2025-04-13 13:03:11', '2025-04-13 13:03:11'),
	(32, 'ORD-20250413140539', 3, 366.00, 366.00, 'processing', NULL, NULL, 'cs_test_a1mL13PMRWoe694ia74qSiU2GyMka9Kh7m2DpNWBJBxv4H4WUlQGIJ7Njk', '2025-04-13 13:05:39', '2025-04-13 13:05:40'),
	(33, 'ORD-20250413140752', 3, 366.00, 366.00, 'processing', NULL, NULL, 'cs_test_a1qcrnKdKau5RNizFqds9cp2lRppypvLXjzIFFYO5JcmBQC7aSDkr6LFuS', '2025-04-13 13:07:52', '2025-04-13 13:07:53'),
	(34, 'ORD-20250413153649', 3, 366.00, 366.00, 'paid', NULL, '2025-04-13 14:37:17', 'cs_test_a1QVR5NFWudbNmPxCPHG5lUdnEcKMS0942CHxC3xcvZXfmhkZ0HZKfEAaF', '2025-04-13 14:36:49', '2025-04-13 14:37:17'),
	(35, 'ORD-20250413213708', 3, 74.82, 74.82, 'processing', NULL, NULL, 'cs_test_a1Q0dC0zKeXfWSleC1Tm5E3OQ3Dt8pHCxvADMd5QCWKPtbukFOVdVI3vjq', '2025-04-13 20:37:08', '2025-04-13 20:37:11'),
	(36, 'ORD-20250414095154', 3, 101.51, 101.51, 'paid', NULL, '2025-04-14 08:59:36', 'cs_test_b1BkCOCoSldpBBUw7dPNV42KsmDcMz5u7uaqtYBUh8OpZhK23Ga7qlrCBI', '2025-04-14 08:51:54', '2025-04-14 08:59:36'),
	(37, 'ORD-20250419122848', 3, 76.84, 76.84, 'paid', NULL, '2025-04-19 11:29:58', 'cs_test_a14LTXxl65W3Qza8jWnDVbnqI4q69P2ogJHHe2DWeQHL6VEx8BsuBQvHTs', '2025-04-19 11:28:48', '2025-04-19 11:29:58'),
	(38, 'ORD-20250420110820', 3, 10.00, 10.00, 'processing', NULL, NULL, 'cs_test_a1QDb5Ee6jl6krPqDKgvmQk5JsTjAZ0OAeVJhPoiv1tJWC7mNisiVslCMs', '2025-04-20 10:08:20', '2025-04-20 10:08:28'),
	(39, 'ORD-20250420123546', 3, 182.65, 182.65, 'paid', NULL, '2025-04-20 11:36:17', 'cs_test_b1XHUTbRWe6HoTR2OKIJLp4SmXKOBl6exvLFPp6EaTM9zepyv3P0MuKxUz', '2025-04-20 11:35:46', '2025-04-20 11:36:17'),
	(40, 'ORD-20250420140412', 3, 2.00, 2.00, 'paid', NULL, '2025-04-20 13:21:45', 'cs_test_a1V3196JSj3QFo0wiAkhRCmSKKhKcBMKle4iLf0UsNlyea7xF1i5BLQcGn', '2025-04-20 13:04:12', '2025-04-20 13:21:45'),
	(41, 'ORD-20250420142200', 3, 2.00, 2.00, 'paid', NULL, '2025-04-20 13:22:54', 'cs_test_a1l3YjnOWQDwmXdoLi2BfxYj28r8Z6ifqxf21emfXrg5g6xwboNa4ZqOaA', '2025-04-20 13:22:00', '2025-04-20 13:22:54'),
	(42, 'ORD-20250420144749', 3, 2.00, 2.00, 'paid', NULL, '2025-04-20 13:48:19', 'cs_test_a1ZubwVNLNVjgmlIE00FD6QoRMCDFVjNgIUfwFGvETA23zGClM275a8zaA', '2025-04-20 13:47:49', '2025-04-20 13:48:19'),
	(43, 'ORD-20250420145110', 9, 2.00, 2.00, 'paid', NULL, '2025-04-20 13:51:43', 'cs_test_a1mptED0IjQmAOzyYDSrA9xo1lurOc7dMrMxEZ3JzVu8AHNO1e1RbluJu2', '2025-04-20 13:51:10', '2025-04-20 13:51:43');

-- Listage de la structure de table easyprint. order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `download_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_book_id_foreign` (`book_id`),
  CONSTRAINT `order_items_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.order_items : ~37 rows (environ)
INSERT INTO `order_items` (`id`, `order_id`, `book_id`, `quantity`, `price`, `download_url`, `created_at`, `updated_at`) VALUES
	(1, 3, 1, 1, 5.00, 'http://127.0.0.1:8000/download/6l2eQZqyYoDmSbhOufmNxhn5aYiEX0HoqBXNeFcl', '2025-04-06 17:49:58', '2025-04-06 17:49:58'),
	(2, 4, 1, 1, 5.00, 'http://127.0.0.1:8000/download/nCEyxntt5RB7TcUcZx4wizSekbF3kHzaSuAoJ4NZ', '2025-04-06 17:55:22', '2025-04-06 17:55:22'),
	(3, 5, 1, 1, 5.00, 'http://127.0.0.1:8000/download/DodQAqdQzqqT7dEInVFF4ymL6ty8v21rlB4rMgmg', '2025-04-06 17:55:32', '2025-04-06 17:55:32'),
	(4, 6, 1, 1, 5.00, 'http://127.0.0.1:8000/download/NCv971jKKiChA4XeDH2jh9cJVcZNmNmxUxqHTDle', '2025-04-06 17:57:17', '2025-04-06 17:57:17'),
	(5, 7, 1, 1, 5.00, 'http://127.0.0.1:8000/download/v3pjN6gPxsX63qUDoVVkz8ukEo933mfqjRkcSFKr', '2025-04-06 17:57:36', '2025-04-06 17:57:36'),
	(6, 8, 1, 1, 5.00, 'http://127.0.0.1:8000/download/0ZCw2cC1TEbN0zmPGQoR1v4TuYq1CL4zSFIqX5IS', '2025-04-06 17:57:45', '2025-04-06 17:57:45'),
	(7, 9, 1, 1, 5.00, 'http://127.0.0.1:8000/download/Euubv3mgCqDi5V56XZaQfYkUCZ4HxHX9Mi53MSGg', '2025-04-06 18:02:42', '2025-04-06 18:02:42'),
	(8, 10, 1, 1, 5.00, 'http://127.0.0.1:8000/download/Zor3fgyk1ocGaWgPgdvqwv60qKOqHa8P7qvq9njK', '2025-04-06 18:06:15', '2025-04-06 18:06:15'),
	(9, 11, 1, 1, 5.00, 'http://127.0.0.1:8000/download/dN2sunniNRi17Hk9u2WeAhxrxat5bizyPAeW38Pz', '2025-04-06 18:11:41', '2025-04-06 18:11:41'),
	(10, 12, 2, 1, 26.69, 'http://127.0.0.1:8000/download/IrTtAUSpjUWzJzAxmG790SbyfTMKxFhc6eHjksiy', '2025-04-06 18:18:19', '2025-04-06 18:18:19'),
	(11, 13, 2, 1, 26.69, 'http://127.0.0.1:8000/download/PcowD3LcZmSWhY7qgpbq3wjyeFp0kua0mChC5q7k', '2025-04-06 18:20:50', '2025-04-06 18:20:50'),
	(12, 14, 2, 1, 26.69, 'http://127.0.0.1:8000/download/LUhoirw2cLLnxnQzk82iXJH3r6R5WktXuUcJHwnY', '2025-04-06 18:22:42', '2025-04-06 18:22:42'),
	(13, 15, 1, 1, 5.00, 'http://127.0.0.1:8000/download/n1FBFw6BHM35o76rGMLX1YxPYyNJQSe3VQ3xIm7b', '2025-04-06 18:26:47', '2025-04-06 18:26:47'),
	(14, 16, 1, 1, 5.00, 'http://127.0.0.1:8000/storage/documents/hQjz5Okxaba5QbLh3uxI6bUt1xIKNAlAUMXtT2su.pdf', '2025-04-06 18:39:06', '2025-04-06 18:39:06'),
	(15, 17, 1, 1, 5.00, 'http://127.0.0.1:8000/storage/documents/hQjz5Okxaba5QbLh3uxI6bUt1xIKNAlAUMXtT2su.pdf', '2025-04-06 19:30:38', '2025-04-06 19:30:38'),
	(16, 26, 1, 1, 5.00, 'http://127.0.0.1:8000/storage/documents/hQjz5Okxaba5QbLh3uxI6bUt1xIKNAlAUMXtT2su.pdf', '2025-04-06 21:20:50', '2025-04-06 21:20:50'),
	(17, 27, 15, 1, 10.00, NULL, '2025-04-13 12:55:45', '2025-04-13 12:55:45'),
	(18, 28, 15, 1, 10.00, NULL, '2025-04-13 12:56:44', '2025-04-13 12:56:44'),
	(19, 29, 15, 1, 10.00, NULL, '2025-04-13 12:57:35', '2025-04-13 12:57:35'),
	(20, 29, 3, 1, 74.82, 'http://127.0.0.1:8000/storage/documents/hamill.org', '2025-04-13 12:57:35', '2025-04-13 12:57:35'),
	(21, 30, 16, 1, 366.00, 'http://127.0.0.1:8000/storage/documents/PCGGVCgpv4Knwff1fRheqXNaOgHbqVKwxxgK0YXi.pdf', '2025-04-13 12:59:44', '2025-04-13 12:59:44'),
	(22, 31, 16, 1, 366.00, 'http://127.0.0.1:8000/storage/documents/PCGGVCgpv4Knwff1fRheqXNaOgHbqVKwxxgK0YXi.pdf', '2025-04-13 13:03:11', '2025-04-13 13:03:11'),
	(23, 32, 16, 1, 366.00, 'http://127.0.0.1:8000/storage/documents/PCGGVCgpv4Knwff1fRheqXNaOgHbqVKwxxgK0YXi.pdf', '2025-04-13 13:05:39', '2025-04-13 13:05:39'),
	(24, 33, 16, 1, 366.00, 'http://127.0.0.1:8000/storage/documents/PCGGVCgpv4Knwff1fRheqXNaOgHbqVKwxxgK0YXi.pdf', '2025-04-13 13:07:52', '2025-04-13 13:07:52'),
	(25, 34, 16, 1, 366.00, 'http://127.0.0.1:8000/storage/documents/PCGGVCgpv4Knwff1fRheqXNaOgHbqVKwxxgK0YXi.pdf', '2025-04-13 14:36:49', '2025-04-13 14:36:49'),
	(26, 35, 3, 1, 74.82, 'http://127.0.0.1:8000/storage/documents/hamill.org', '2025-04-13 20:37:08', '2025-04-13 20:37:08'),
	(27, 36, 3, 1, 74.82, 'http://127.0.0.1:8000/storage/documents/hamill.org', '2025-04-14 08:51:54', '2025-04-14 08:51:54'),
	(28, 36, 2, 1, 26.69, 'http://127.0.0.1:8000/storage/documents/www.raynor.com', '2025-04-14 08:51:54', '2025-04-14 08:51:54'),
	(29, 37, 7, 1, 76.84, 'http://127.0.0.1:8000/storage/documents/www.jacobson.com', '2025-04-19 11:28:48', '2025-04-19 11:28:48'),
	(30, 38, 15, 1, 10.00, NULL, '2025-04-20 10:08:20', '2025-04-20 10:08:20'),
	(31, 39, 15, 1, 10.00, NULL, '2025-04-20 11:35:46', '2025-04-20 11:35:46'),
	(32, 39, 6, 1, 81.25, 'http://127.0.0.1:8000/storage/documents/sit-sed-fuga-corrupti-rerum-alias-ullam-fuga', '2025-04-20 11:35:46', '2025-04-20 11:35:46'),
	(33, 39, 4, 1, 91.40, 'http://127.0.0.1:8000/storage/documents/dolore-quia-assumenda-sit-reiciendis.html', '2025-04-20 11:35:46', '2025-04-20 11:35:46'),
	(34, 40, 1, 1, 2.00, 'http://127.0.0.1:8000/storage/documents/hQjz5Okxaba5QbLh3uxI6bUt1xIKNAlAUMXtT2su.pdf', '2025-04-20 13:04:12', '2025-04-20 13:04:12'),
	(35, 41, 1, 1, 2.00, 'http://127.0.0.1:8000/storage/documents/hQjz5Okxaba5QbLh3uxI6bUt1xIKNAlAUMXtT2su.pdf', '2025-04-20 13:22:00', '2025-04-20 13:22:00'),
	(36, 42, 1, 1, 2.00, 'http://localhost:8000/storage/documents/hQjz5Okxaba5QbLh3uxI6bUt1xIKNAlAUMXtT2su.pdf', '2025-04-20 13:47:49', '2025-04-20 13:47:49'),
	(37, 43, 1, 1, 2.00, 'http://localhost:8000/storage/documents/hQjz5Okxaba5QbLh3uxI6bUt1xIKNAlAUMXtT2su.pdf', '2025-04-20 13:51:10', '2025-04-20 13:51:10');

-- Listage de la structure de table easyprint. payments
CREATE TABLE IF NOT EXISTS `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','completed','failed','refunded') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payments_transaction_id_unique` (`transaction_id`),
  KEY `payments_order_id_foreign` (`order_id`),
  CONSTRAINT `payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.payments : ~15 rows (environ)
INSERT INTO `payments` (`id`, `order_id`, `transaction_id`, `amount`, `method`, `status`, `created_at`, `updated_at`) VALUES
	(1, 11, 'pi_3RAxhQLE4hmSPgNP0sTpF7vg', 5.00, 'stripe', 'completed', '2025-04-06 18:13:44', '2025-04-06 18:13:44'),
	(2, 13, 'pi_3RAxosLE4hmSPgNP2WIzOVpM', 26.69, 'stripe', 'completed', '2025-04-06 18:21:27', '2025-04-06 18:21:27'),
	(3, 14, 'pi_3RAxqZLE4hmSPgNP250BCjH5', 26.69, 'stripe', 'completed', '2025-04-06 18:23:11', '2025-04-06 18:23:11'),
	(4, 15, 'pi_3RAxucLE4hmSPgNP2IOiY3y8', 5.00, 'stripe', 'completed', '2025-04-06 18:27:23', '2025-04-06 18:27:23'),
	(6, 16, 'pi_3RAy6TLE4hmSPgNP0YymrJrC', 5.00, 'stripe', 'completed', '2025-04-06 18:39:37', '2025-04-06 18:39:37'),
	(8, 17, 'pi_3RAyuVLE4hmSPgNP14H3QIT3', 5.00, 'stripe', 'completed', '2025-04-06 19:31:19', '2025-04-06 19:31:19'),
	(9, 26, 'pi_3RB0dVLE4hmSPgNP1pvkt0px', 5.00, 'stripe', 'completed', '2025-04-06 21:21:53', '2025-04-06 21:21:53'),
	(10, 34, 'pi_3RDSasLE4hmSPgNP1ubldIoK', 366.00, 'stripe', 'completed', '2025-04-13 14:37:17', '2025-04-13 14:37:17'),
	(11, 36, 'pi_3RDjmxLE4hmSPgNP08zy8Ioe', 101.51, 'stripe', 'completed', '2025-04-14 08:58:54', '2025-04-14 08:58:54'),
	(13, 37, 'pi_3RFaWsLE4hmSPgNP1YlyvQJd', 76.84, 'stripe', 'completed', '2025-04-19 11:29:58', '2025-04-19 11:29:58'),
	(14, 39, 'pi_3RFx6XLE4hmSPgNP20aWWVzn', 182.65, 'stripe', 'completed', '2025-04-20 11:36:17', '2025-04-20 11:36:17'),
	(16, 40, 'pi_3RFyUNLE4hmSPgNP1W6le38t', 2.00, 'stripe', 'completed', '2025-04-20 13:21:45', '2025-04-20 13:21:45'),
	(17, 41, 'pi_3RFyliLE4hmSPgNP0QTQzKon', 2.00, 'stripe', 'completed', '2025-04-20 13:22:54', '2025-04-20 13:22:54'),
	(18, 42, 'pi_3RFzAILE4hmSPgNP1pTFtQ4i', 2.00, 'stripe', 'completed', '2025-04-20 13:48:19', '2025-04-20 13:48:19'),
	(19, 43, 'pi_3RFzDbLE4hmSPgNP2iQe9llS', 2.00, 'stripe', 'completed', '2025-04-20 13:51:43', '2025-04-20 13:51:43');

-- Listage de la structure de table easyprint. permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.permissions : ~11 rows (environ)
INSERT INTO `permissions` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'manage_books', '2025-04-03 21:10:20', '2025-04-03 21:10:20'),
	(2, 'manage_authors', '2025-04-03 21:10:20', '2025-04-03 21:10:20'),
	(3, 'manage_categories', '2025-04-03 21:10:20', '2025-04-03 21:10:20'),
	(4, 'manage_payments', '2025-04-03 21:10:20', '2025-04-03 21:10:20'),
	(5, 'manage_orders', '2025-04-03 21:10:20', '2025-04-03 21:10:20'),
	(6, 'manage_users', '2025-04-03 21:10:20', '2025-04-03 21:10:20'),
	(7, 'view_home', '2025-04-03 21:10:20', '2025-04-03 21:10:20'),
	(8, 'view_books', '2025-04-03 21:10:20', '2025-04-03 21:10:20'),
	(9, 'purchase_books', '2025-04-03 21:10:20', '2025-04-03 21:10:20'),
	(10, 'manage_permissions', '2025-04-03 22:18:52', '2025-04-03 22:18:53'),
	(11, 'manage_roles', '2025-04-03 22:19:13', '2025-04-03 22:19:14');

-- Listage de la structure de table easyprint. permission_role
CREATE TABLE IF NOT EXISTS `permission_role` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.permission_role : ~11 rows (environ)
INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(10, 1),
	(11, 1),
	(7, 2),
	(8, 2),
	(9, 2);

-- Listage de la structure de table easyprint. roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.roles : ~2 rows (environ)
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', '2025-04-03 21:10:20', '2025-04-03 21:10:20'),
	(2, 'client', '2025-04-03 21:10:20', '2025-04-03 21:10:20');

-- Listage de la structure de table easyprint. role_user
CREATE TABLE IF NOT EXISTS `role_user` (
  `user_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_user_role_id_foreign` (`role_id`),
  CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.role_user : ~8 rows (environ)
INSERT INTO `role_user` (`user_id`, `role_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 2),
	(4, 2),
	(5, 2),
	(6, 2),
	(7, 2),
	(9, 2);

-- Listage de la structure de table easyprint. users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_verify` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','suspended') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `date_of_birth` date DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `gender` enum('male','female') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.users : ~8 rows (environ)
INSERT INTO `users` (`id`, `full_name`, `email`, `email_verified_at`, `password`, `password_verify`, `phone`, `profile`, `status`, `is_verified`, `date_of_birth`, `city`, `country`, `address`, `bio`, `gender`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'mouad hallaffou', 'mouadhallaffou@gmail.com', NULL, '$2y$12$3hV12lafF0XWsvtzjITeGujYG7XXPJ3wcUParsuPfNcUbD4976X8O', NULL, '0123456789', 'profiles/tkK0qvhH2xdPESJABdFMBfqAWWNU0BwBBYCdMp8A.jpg', 'active', 0, NULL, NULL, NULL, NULL, NULL, 'male', NULL, '2025-04-03 21:19:46', '2025-04-14 09:42:36', NULL),
	(2, 'Guy Rivers', 'mupesa@mailinator.com', NULL, '$2y$12$/LcolAFuHuXeMPjoH2hG5.ZNrwD/QKhhN9T1RMHBoETy1XDzFvzJm', NULL, NULL, NULL, 'suspended', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-03 21:55:26', '2025-04-13 10:19:39', NULL),
	(3, 'jabir hallaffou', 'jabir@gmail.com', NULL, '$2y$12$GCPUFxnBP6YWTOmeSEQFq.d2/olUAEq61aAIbcYPqs3CuQuK6MJT6', NULL, '0123456789', 'profiles/U1MXvxWxIdFeYD4qo8w0LO7ohQalhlCT8B1BOgnc.png', 'active', 0, NULL, NULL, NULL, NULL, NULL, 'male', NULL, '2025-04-05 17:02:53', '2025-04-14 07:50:20', NULL),
	(4, 'annass hallaffou', 'annass@gmail.com', NULL, '$2y$12$VMicstjAQcm3uQwnSdS.hOfcIgY5f7QtPJ3KVhswPq8F8DU5JIEQu', NULL, NULL, NULL, 'active', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-13 11:41:40', '2025-04-13 11:41:40', NULL),
	(5, 'aymane dev', 'aymene@gmail.com', NULL, '$2y$12$o6lhdZAGKFZ6fq8UrcQuX.JQelmGbpb9JP43vQfjY6c2uJpd7MzeK', NULL, NULL, NULL, 'active', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-13 11:42:03', '2025-04-13 11:42:03', NULL),
	(6, 'salah hallaffou', 'salah@gmail.com', NULL, '$2y$12$Aw2.4nBXrJburp4RXh0yeeYFi0hN8R5Midy/2VJuhlSetyV9hRzOm', NULL, NULL, NULL, 'active', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-13 11:42:33', '2025-04-19 14:37:05', NULL),
	(7, 'Hafsa', 'hafsa@gmail.com', NULL, '$2y$12$uOjxn.0Yj3PCbQQf4rZrJeh/tlj9Kbu9jF4Q2eqqfnyMD/elvQl3K', NULL, NULL, NULL, 'active', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-13 11:42:56', '2025-04-13 11:42:56', NULL),
	(9, 'Mouad Hallaffou', 'mouadhallaffou520@gmail.com', NULL, '$2y$12$CmXsbSt9WsdV6unMRYiUU.Mb3gkPcjGrzrR0sgcbWTdfDgn27W0XS', NULL, NULL, 'profiles/r5HMCwHnBJWEeM7sIs2uaCDDcsYUR5l4ZO6Mog94.jpg', 'active', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-04-20 13:33:36', '2025-04-20 13:45:44', NULL);

-- Listage de la structure de table easyprint. wishlists
CREATE TABLE IF NOT EXISTS `wishlists` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `book_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wishlists_user_id_book_id_unique` (`user_id`,`book_id`),
  KEY `wishlists_book_id_foreign` (`book_id`),
  CONSTRAINT `wishlists_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table easyprint.wishlists : ~3 rows (environ)
INSERT INTO `wishlists` (`id`, `user_id`, `book_id`, `created_at`, `updated_at`) VALUES
	(16, 3, 1, '2025-04-14 09:26:04', '2025-04-14 09:26:04'),
	(25, 9, 1, '2025-04-20 13:50:46', '2025-04-20 13:50:46'),
	(26, 3, 2, '2025-04-20 17:12:49', '2025-04-20 17:12:49');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
