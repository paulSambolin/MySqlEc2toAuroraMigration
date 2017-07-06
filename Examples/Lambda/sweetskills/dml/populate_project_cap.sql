BEGIN;
INSERT INTO project_cap (project_id, capability_id, party_id, proficiency_lvl) VALUES (1, 1, 2, 3);

INSERT INTO project_cap (project_id, capability_id, party_id, proficiency_lvl) VALUES (1, 3, 2, 3);

INSERT INTO project_cap (project_id, capability_id, party_id, proficiency_lvl) VALUES (1, 4, 2, 2);

INSERT INTO project_cap (project_id, capability_id, party_id, proficiency_lvl) VALUES (2, 2, 2, 4);

INSERT INTO project_cap (project_id, capability_id, party_id, proficiency_lvl) VALUES (3, 1, 2, 4);
COMMIT;