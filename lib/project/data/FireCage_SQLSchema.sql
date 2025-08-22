CREATE TABLE IF NOT EXISTS "person" (
	"id" INTEGER NOT NULL UNIQUE,
	"uuid" INTEGER NOT NULL,
	"firstname" TEXT NOT NULL,
	"lastname" TEXT NOT NULL,
	"qualification" INTEGER NOT NULL,
	"isactive" INTEGER NOT NULL,
	"timestamp_updated" INTEGER NOT NULL,
	"timestamp_created" INTEGER NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "emergency_ats" (
	"id" INTEGER NOT NULL UNIQUE,
	"uuid" INTEGER NOT NULL,
	"remark" TEXT NOT NULL,
	"diary_id" INTEGER NOT NULL,
	"wtf_id" INTEGER NOT NULL,
	"atf_id" INTEGER NOT NULL,
	"atm_id" INTEGER NOT NULL,
	"surveillancer_id" INTEGER NOT NULL,
	"em_status" INTEGER NOT NULL,
	"em_type" INTEGER NOT NULL,
	"em_seconds" INTEGER NOT NULL,
	"dtime_begin" INTEGER NOT NULL,
	"dtime_end" INTEGER NOT NULL,
	"timestamp_created" INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY ("wtf_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("atf_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("atm_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("surveillancer_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("diary_id") REFERENCES "message_diary"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "user" (
	"id" INTEGER NOT NULL UNIQUE,
	"uuid" INTEGER NOT NULL,
	"person_id" INTEGER,
	"username" VARCHAR NOT NULL,
	"email" VARCHAR NOT NULL,
	"pw_hashed" VARCHAR NOT NULL,
	"timestamp_updated" INTEGER NOT NULL,
	"timestamp_created" INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY ("person_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "message_entries" (
	"id" INTEGER NOT NULL UNIQUE,
	"diary_id" INTEGER NOT NULL,
	"type" INTEGER NOT NULL,
	"sender" VARCHAR,
	"receiver" VARCHAR,
	"message" TEXT NOT NULL,
	"timestamp_created" INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY ("diary_id") REFERENCES "message_diary"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "department" (
	"id" INTEGER NOT NULL UNIQUE,
	"uuid" INTEGER NOT NULL,
	"name" VARCHAR NOT NULL,
	"timestamp_updated" INTEGER NOT NULL,
	"timestamp_created" INTEGER NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "ats_team" (
	"id" INTEGER NOT NULL UNIQUE,
	"wtf_id" INTEGER NOT NULL,
	"atf_id" INTEGER NOT NULL,
	"atm_id" INTEGER NOT NULL,
	"surveillancer_id" INTEGER NOT NULL,
	"timestamp_updated" INTEGER NOT NULL,
	"timestamp_created" INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY ("atm_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("atf_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("surveillancer_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("wtf_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "pressure_bottle" (
	"id" INTEGER NOT NULL UNIQUE,
	"emergency_ats_id" INTEGER NOT NULL,
	"person_id" INTEGER NOT NULL,
	"pressure_start" INTEGER NOT NULL,
	"pressure_10min" INTEGER NOT NULL,
	"pressure_20min" INTEGER NOT NULL,
	"pressure_end" INTEGER NOT NULL,
	"timestamp_created" INTEGER NOT NULL,
	"timestamp_updated" INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY ("person_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("emergency_ats_id") REFERENCES "emergency_ats"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS "message_diary" (
	"id" INTEGER NOT NULL UNIQUE,
	"uuid" INTEGER NOT NULL,
	"remark" TEXT,
	"timestamp_updated" INTEGER NOT NULL,
	"timestamp_created" INTEGER NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "department_personell" (
	"id" INTEGER NOT NULL UNIQUE,
	"person_id" INTEGER NOT NULL,
	"department_id" INTEGER NOT NULL,
	"role" INTEGER NOT NULL,
	"isactive" INTEGER NOT NULL,
	"timestamp_updated" INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY ("department_id") REFERENCES "department"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY ("person_id") REFERENCES "person"("id")
	ON UPDATE NO ACTION ON DELETE NO ACTION
);
