-- Create a new personal user with all privileges
CREATE USER my_custom_personal_user WITH PASSWORD 'my_secure_personal_password_123' CREATEROLE CREATEDB SUPERUSER;

-- Ensure the user owns the public schema
GRANT ALL PRIVILEGES ON DATABASE postgres TO my_custom_personal_user;
GRANT ALL ON SCHEMA public TO my_custom_personal_user;
