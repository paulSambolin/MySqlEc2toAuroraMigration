USE ParivedaTestDB;

DROP TABLE IF EXISTS Child;
DROP TABLE IF EXISTS Parent;
DROP TABLE IF EXISTS Notes;

CREATE TABLE Parent (
        id INT NOT NULL,
        name VARCHAR(100),
        PRIMARY KEY (id)
);

CREATE TABLE Child (
        id INT,
        name VARCHAR(100),
        parent_id INT,
        INDEX par_ind (parent_id),
        FOREIGN KEY (parent_id)
                REFERENCES Parent(id)
                ON DELETE CASCADE
);

CREATE TABLE Notes (
        id INT,
        s1 VARCHAR(200),
        s2 VARCHAR(200)
);

INSERT INTO Notes VALUES (1, 'Other acute myocarditis', 'Fracture of alveolus of maxilla, subs for fx w routn heal'),
 (2, 'Drowning and submersion due to fall off merchant ship', 'Bursitis of shoulder'),
 (3, 'Other specified arthritis, hand', 'Breakdown (mechanical) of int fix of unsp bone of limb, subs'),
 (4, 'Unsp fracture of sacrum, init encntr for open fracture', 'Granulation of postmastoidectomy cavity, unspecified ear');

INSERT INTO Parent
VALUES (1, 'Parent1'),
       (2, 'Parent2'),
       (3, 'Parent3');

INSERT INTO Child
VALUES (1, 'Child1', 1),
       (2, 'Child2', 1),
       (3, 'Child3', 1),
       (4, 'Child4', 2),
       (5, 'Child5', 2),
       (6, 'Child6', 2),
       (7, 'Child7', 2),
       (8, 'Child8', 3),
       (9, 'Child9', 3),
       (10, 'Child10', 3);