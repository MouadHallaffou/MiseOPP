use personne;
--  Trouve les clients qui n'ont jamais passé de commande, et qui vivent dans une ville où aucun autre client n'a jamais commandé non plus.
SELECT c.id, c.nom, c.ville
FROM clients c
LEFT JOIN commandes cm ON c.id = cm.client_id
WHERE cm.client_id IS NULL
  AND c.ville NOT IN (
    SELECT DISTINCT c2.ville
    FROM clients c2
    JOIN commandes cm2 ON c2.id = cm2.client_id
);

Niveau Débutant
1. Lister tous les livres avec leur titre et prix

SELECT title, price FROM book

2. Afficher les auteurs encore vivants (sans date de décès)

SELECT name FROM authors WHERE death_date IS NUL

3. Compter le nombre de livres numériques

SELECT COUNT(*) FROM books WHERE type = 'digital';

4. Trouver les livres dont le prix est inférieur à 20€

SELECT title, price FROM books WHERE price < 2

5. Lister les catégories principales (sans parent)

SELECT name FROM categories WHERE parent_id IS NUL

Niveau Intermédiaire
6. Afficher les livres avec leur auteur (jointure)

SELECT b.title, a.name 
FROM books b JOIN authors a ON b.author_id = a.i

7. Trouver le livre le plus cher

SELECT title, price FROM books ORDER BY price DESC LIMIT 

8. Calculer la moyenne des prix par catégorie

SELECT c.name, AVG(b.price) 
FROM books b JOIN categories c ON b.category_id = c.id 
GROUP BY c.nam

9. Lister les utilisateurs avec leur rôle

SELECT u.full_name, r.name 
FROM users u JOIN role_user ru ON u.id = ru.user_id 
JOIN roles r ON ru.role_id = r.i

10. Trouver les livres commandés plus de 2 fois

SELECT b.title, COUNT(oi.book_id) 
FROM order_items oi JOIN books b ON oi.book_id = b.id 
GROUP BY b.title HAVING COUNT(oi.book_id) > 2;

11. Afficher les auteurs et leur nombre de livres

SELECT a.name, COUNT(b.id) 
FROM authors a LEFT JOIN books b ON a.id = b.author_id 
GROUP BY a.name;

12. Trouver les commandes payées en avril 2025

SELECT number, total 
FROM orders 
WHERE paid_at BETWEEN '2025-04-01' AND '2025-04-30';

13. Calculer le chiffre d affaires total

SELECT SUM(total) FROM orders WHERE status = 'paid';

14. Lister les livres jamais commandés

SELECT b.title 
FROM books b LEFT JOIN order_items oi ON b.id = oi.book_id 
WHERE oi.id IS NULL;

15. Afficher les 3 livres les plus populaires (downloads)

SELECT title, downloads FROM books ORDER BY downloads DESC LIMIT 3;

Niveau Avancé
16. Trouver les utilisateurs ayant dépensé plus de 100€

SELECT u.full_name, SUM(o.total) 
FROM users u JOIN orders o ON u.id = o.user_id 
WHERE o.status = 'paid' 
GROUP BY u.full_name HAVING SUM(o.total) > 100;

17. Afficher la hiérarchie des catégories (parent/enfant)

SELECT c1.name AS parent, c2.name AS child 
FROM categories c1 JOIN categories c2 ON c1.id = c2.parent_id;

18. Calculer le panier moyen par utilisateur

SELECT u.full_name, AVG(o.total) 
FROM users u JOIN orders o ON u.id = o.user_id 
WHERE o.status = 'paid' 
GROUP BY u.full_name;

19. Trouver les auteurs dont les livres ont une note moyenne >4

SELECT a.name, AVG(b.rating) 
FROM authors a JOIN books b ON a.id = b.author_id 
GROUP BY a.name HAVING AVG(b.rating) > 4;

20. Lister les livres avec leur réduction (original_price vs price)

SELECT title, original_price, price, 
       (original_price - price) AS discount 
FROM books WHERE original_price > 0;

21. Afficher le mois avec le plus de commandes

SELECT MONTH(created_at) AS month, COUNT(*) 
FROM orders 
GROUP BY month ORDER BY COUNT(*) DESC LIMIT 1;

22. Trouver les utilisateurs avec des commandes en attente

SELECT DISTINCT u.full_name 
FROM users u JOIN orders o ON u.id = o.user_id 
WHERE o.status = 'pending';

23. Calculer le pourcentage de livres par type

SELECT type, COUNT(*)*100/(SELECT COUNT(*) FROM books) AS percentage 
FROM books GROUP BY type;

24. Afficher les auteurs les plus prolifiques (plus de 2 livres)

SELECT a.name, COUNT(b.id) 
FROM authors a JOIN books b ON a.id = b.author_id 
GROUP BY a.name HAVING COUNT(b.id) > 2;

25. Trouver les livres d une catégorie et de ses sous-catégories

WITH RECURSIVE cat_tree AS (
    SELECT id FROM categories WHERE name = 'Developement'
    UNION ALL
    SELECT c.id FROM categories c JOIN cat_tree ct ON c.parent_id = ct.id
)
SELECT b.title FROM books b JOIN cat_tree ct ON b.category_id = ct.id;

Niveau Expert
-- 26. Calculer la croissance mensuelle du chiffre d'affaires

SELECT YEAR(paid_at) AS year, MONTH(paid_at) AS month, 
       SUM(total) AS revenue,
       (SUM(total) - LAG(SUM(total)) OVER (ORDER BY YEAR(paid_at), MONTH(paid_at))) / 
       LAG(SUM(total)) OVER (ORDER BY YEAR(paid_at), MONTH(paid_at)) * 100 AS growth
FROM orders 
WHERE status = 'paid' 
GROUP BY year, month;

27. Trouver les paires de livres souvent achetés ensemble

SELECT oi1.book_id AS book1, oi2.book_id AS book2, COUNT(*) 
FROM order_items oi1 JOIN order_items oi2 
ON oi1.order_id = oi2.order_id AND oi1.book_id < oi2.book_id 
GROUP BY book1, book2 
ORDER BY COUNT(*) DESC LIMIT 5;

28. Afficher le chemin complet des catégories (hiérarchie complète)

WITH RECURSIVE category_path AS (
    SELECT id, name, CAST(name AS CHAR(1000)) AS path
    FROM categories WHERE parent_id IS NULL
    UNION ALL
    SELECT c.id, c.name, CONCAT(cp.path, ' > ', c.name)
    FROM categories c JOIN category_path cp ON c.parent_id = cp.id
)
SELECT path FROM category_path ORDER BY path;

29. Calculer la rétention des utilisateurs mois par mois

WITH user_activity AS (
    SELECT user_id, DATE_FORMAT(MIN(created_at), '%Y-%m') AS first_month,
           DATE_FORMAT(created_at, '%Y-%m') AS activity_month
    FROM orders
    GROUP BY user_id, activity_month
)
SELECT first_month, 
       COUNT(DISTINCT user_id) AS cohort_size,
       SUM(CASE WHEN activity_month = first_month THEN 1 ELSE 0 END) AS month_0,
       SUM(CASE WHEN activity_month = DATE_FORMAT(first_month + INTERVAL 1 MONTH, '%Y-%m') THEN 1 ELSE 0 END) AS month_1
FROM user_activity
GROUP BY first_month;

30. Créer une vue synthétique du business

CREATE VIEW business_overview AS
SELECT 
    (SELECT COUNT(*) FROM users) AS total_users,
    (SELECT COUNT(*) FROM books) AS total_books,
    (SELECT COUNT(*) FROM authors) AS total_authors,
    (SELECT SUM(total) FROM orders WHERE status = 'paid') AS total_revenue,
    (SELECT AVG(total) FROM orders WHERE status = 'paid') AS avg_order_value,
    (SELECT COUNT(*) FROM orders WHERE status = 'paid') AS total_orders;