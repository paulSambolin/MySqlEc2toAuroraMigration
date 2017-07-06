BEGIN;
INSERT INTO cap_assessment (person_id, capability_id, proficiency_lvl, interest_lvl) VALUES (1, 1, 2, 3);

INSERT INTO cap_assessment (person_id, capability_id, proficiency_lvl, interest_lvl) VALUES (1, 2, 2, 3);

INSERT INTO cap_assessment (person_id, capability_id, proficiency_lvl, interest_lvl) VALUES (1, 3, 2, 3);

INSERT INTO cap_assessment (person_id, capability_id, proficiency_lvl, interest_lvl) VALUES (1, 4, 2, 3);
COMMIT;