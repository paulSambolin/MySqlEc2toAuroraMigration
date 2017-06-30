BEGIN;
INSERT INTO educ_mtl (party_id, submitted_by, type, title, author, description, user_lvl, is_recommended) VALUES (1, 1, 'Book', 'JavaScript for Dummies', 'Margret Young', 'Understand JavaScript Basics using terms you already know', 'Beginner', true);

INSERT INTO educ_mtl (party_id, submitted_by, type, title, author, description, user_lvl, is_recommended) VALUES (1, 1, 'Website', 'Stack Overflow', 'Community', 'Ask and you shall recieve', 'Beginner', true);
COMMIT;