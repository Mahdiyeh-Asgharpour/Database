-- user
CREATE TABLE "user" (
	user_id SERIAL PRIMARY KEY UNIQUE NOT NULL,
	username VARCHAR(50) UNIQUE,
	password VARCHAR(255) NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50),
	phone_number VARCHAR(17) UNIQUE NOT NULL,
	last_seen TIMESTAMP NOT NULL DEFAULT NOW()
);

-- devices
CREATE TABLE user_sessions (
	session_id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	device_id VARCHAR(50) NOT NULL,
	device_type VARCHAR(50) NOT NULL,
	start_time TIMESTAMP NOT NULL DEFAULT NOW(),
	FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

-- user contacts
CREATE TABLE user_contacts (
	user_id INTEGER NOT NULL,
	contact_id INTEGER NOT NULL,
	FOREIGN KEY (user_id) REFERENCES "user" (user_id) ON DELETE CASCADE,
	FOREIGN KEY (contact_id) REFERENCES "user" (user_id) ON DELETE CASCADE,
	UNIQUE (user_id, contact_id),
	PRIMARY KEY (user_id, contact_id)
);

-- group
CREATE TABLE "group" (
	group_id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	owner_id INTEGER NOT NULL,
	bio TEXT,
	FOREIGN KEY (owner_id) REFERENCES "user" (user_id) ON DELETE CASCADE
);

-- group members
CREATE TABLE group_members (
	group_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	role VARCHAR(10) NOT NULL DEFAULT 'member',
	FOREIGN KEY (group_id) REFERENCES "group" (group_id) ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES "user" (user_id) ON DELETE CASCADE,
	UNIQUE (group_id, user_id),
	PRIMARY KEY (group_id, user_id)
);

-- channel
CREATE TABLE channel (
	channel_id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	owner_id INTEGER NOT NULL,
	bio TEXT,
	FOREIGN KEY (owner_id) REFERENCES "user" (user_id) ON DELETE CASCADE
);

-- channel members
CREATE TABLE channel_members (
	channel_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	role VARCHAR(10) NOT NULL DEFAULT 'member',
	FOREIGN KEY (channel_id) REFERENCES channel (channel_id) ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES "user" (user_id) ON DELETE CASCADE,
	UNIQUE (channel_id, user_id),
	PRIMARY KEY (channel_id, user_id)
);

-- private messages
CREATE TABLE private_message (
  	private_message_id SERIAL PRIMARY KEY,
  	sender_id INTEGER NOT NULL,
  	receiver_id INTEGER NOT NULL,
  	content TEXT,
	attachment_url VARCHAR(255),
  	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  	FOREIGN KEY (sender_id) REFERENCES "user" (user_id),
  	FOREIGN KEY (receiver_id) REFERENCES "user" (user_id),
	CONSTRAINT check_message_type
        CHECK ((content IS NOT NULL AND attachment_url IS NULL) 
               OR (content IS NULL AND attachment_url IS NOT NULL)
               OR (content IS NOT NULL AND attachment_url IS NOT NULL))
);

-- group messages
CREATE TABLE group_message (
	  group_message_id SERIAL PRIMARY KEY,
  group_id INTEGER NOT NULL,
  sender_id INTEGER NOT NULL,
  content TEXT,
attachment_url VARCHAR(255),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  FOREIGN KEY (group_id) REFERENCES "group" (group_id) ON DELETE CASCADE,
  FOREIGN KEY (sender_id) REFERENCES "user" (user_id),
	CONSTRAINT check_message_type
        CHECK ((content IS NOT NULL AND attachment_url IS NULL) 
               OR (content IS NULL AND attachment_url IS NOT NULL)
               OR (content IS NOT NULL AND attachment_url IS NOT NULL))
);

-- channel messages
CREATE TABLE channel_message (
	channel_message_id SERIAL PRIMARY KEY,
	channel_id INTEGER NOT NULL,
	sender_id INTEGER NOT NULL,
	content TEXT,
	attachment_url VARCHAR(255),
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	FOREIGN KEY (channel_id) REFERENCES "channel" (channel_id) ON DELETE CASCADE,
	FOREIGN KEY (sender_id) REFERENCES "user" (user_id),
	CONSTRAINT check_message_type
        CHECK ((content IS NOT NULL AND attachment_url IS NULL) 
               OR (content IS NULL AND attachment_url IS NOT NULL)
               OR (content IS NOT NULL AND attachment_url IS NOT NULL))
);