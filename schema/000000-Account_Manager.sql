BEGIN TRANSACTION;

	CREATE TABLE accounts (
		id												BIGSERIAL						PRIMARY KEY NOT NULL,
		parent_account_id								BIGINT							DEFAULT NULL,
		enabled											BOOLEAN							DEFAULT TRUE NOT NULL
	) WITH(OIDS=FALSE);

	CREATE TABLE account_providers (
		id												BIGSERIAL						PRIMARY KEY NOT NULL,
		name											TEXT							NOT NULL,
		description										TEXT,
		class_name										VARCHAR(128)					NOT NULL
	) WITH(OIDS=FALSE);

	CREATE TABLE account_logins (
		id												BIGSERIAL						PRIMARY KEY NOT NULL,
		account_id										BIGINT REFERENCES accounts(id) NOT NULL,
		login											VARCHAR(1024) NOT NULL,
		account_provider_id								BIGINT REFERENCES account_providers(id) NOT NULL,
		CONSTRAINT account_logins_uniq					UNIQUE (account_id, login, account_provider_id)
	) WITH(OIDS=FALSE);

	CREATE TABLE account_emails (
		id												BIGSERIAL PRIMARY KEY NOT NULL,
		account_id										BIGINT REFERENCES accounts(id) NOT NULL,
		email											VARCHAR(1024) UNIQUE NOT NULL,
		confirmation_code								VARCHAR(32) DEFAULT NULL,
		confirmed_at									TIMESTAMP WITHOUT TIME ZONE DEFAULT NULL
	) WITH(OIDS=FALSE);

	CREATE TABLE roles (
		id												BIGSERIAL PRIMARY KEY NOT NULL,
		name											VARCHAR(128) UNIQUE NOT NULL,
		description										TEXT,
		enabled											BOOLEAN DEFAULT TRUE NOT NULL
	) WITH(OIDS=FALSE);

	CREATE TABLE groups (
		id												BIGSERIAL PRIMARY KEY NOT NULL,
		name											VARCHAR(128) UNIQUE NOT NULL,
		description										TEXT,
		enabled											BOOLEAN DEFAULT TRUE NOT NULL
	) WITH(OIDS=FALSE);

	CREATE TABLE group_roles (
		group_id										BIGINT REFERENCES groups(id) NOT NULL,
		role_id											BIGINT REFERENCES roles(id) NOT NULL,
		CONSTRAINT group_roles_pkey						PRIMARY KEY (group_id, role_id)
	) WITH(OIDS=FALSE);

	CREATE TABLE account_roles (
		account_id										BIGINT REFERENCES accounts(id) NOT NULL,
		role_id											BIGINT REFERENCES roles(id) NOT NULL,
		CONSTRAINT account_roles_pkey					PRIMARY KEY (account_id, role_id)
	) WITH(OIDS=FALSE);

	CREATE TABLE account_groups (
		account_id										BIGINT REFERENCES accounts(id) NOT NULL,
		group_id										BIGINT REFERENCES groups(id) NOT NULL,
		CONSTRAINT account_groups_pkey					PRIMARY KEY (account_id, group_id)
	) WITH(OIDS=FALSE);

	CREATE TABLE account_passwords (
		id												BIGSERIAL PRIMARY KEY NOT NULL,
		account_id										BIGINT REFERENCES accounts(id) NOT NULL,
		hash											VARCHAR(128) NOT NULL,
		salt											VARCHAR(128) NOT NULL,
		sequence										BIGINT NOT NULL DEFAULT 0,
		CONSTRAINT account_passwords_sequence_uniq		UNIQUE (account_id, sequence)
	) WITH(OIDS=FALSE);

	INSERT INTO account_providers (name, description, class_name) VALUES ('Local', 'Authenticates logins against a local database with one-way hashed passwords', 'someclassname');

COMMIT TRANSACTION;
