BEGIN;
INSERT INTO capability (party_id, cap_name, category, skill, type) VALUES (1, 'AWS', 'Cloud', '{"EC2", "CloudFormation", "CodeDeploy", "RDS", "Lambda", "S3", "CodePipeline"}', 'Technical' );

INSERT INTO capability (party_id, cap_name, category, skill, type) VALUES (1, 'C#', 'Code', '{"Razor", "Entity Framework", "Nuget"}', 'Technical' );

INSERT INTO capability (party_id, cap_name, category, skill, type) VALUES (1, 'JavaScript', 'Code', '{"Node.js", "Prototype Pattern", "JSON", "JQuery", "Browser Compatability"}', 'Technical' );

INSERT INTO capability (party_id, cap_name, category, skill, type) VALUES (1, 'Postgresql', 'Database', '{"CREATE", "SELECT", "JOIN", "DROP", "ALTER", "INSERT"}', 'Technical' );
COMMIT;