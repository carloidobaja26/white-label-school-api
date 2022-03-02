CREATE TABLE "studentInfo" (
  "id" SERIAL PRIMARY KEY,
  "studentNo" varchar,
  "password" varchar,
  "firstName" varchar,
  "lastName" varchar,
  "middleName" varchar,
  "gender" INT,
  "placeOfBirth" varchar,
  "mobileNo" INT,
  "email" varchar,
  "residentialAddress" varchar,
  "permanentAddress" varchar,
  "admissionStatus" varchar,
  "scholasticStatus" varchar,
  "courseAndDescription" varchar,
  "status" int
);

CREATE TABLE "studentGrade" (
  "id" SERIAL PRIMARY KEY,
  "studentInfoId" int,
  "subjectCodeId" int,
  "finalGrade" float,
  "gradeStatus" varchar,
  "semester" int
);

CREATE TABLE "schoolYear" (
  "id" SERIAL PRIMARY KEY,
  "schoolyear" varchar
);

CREATE TABLE "schoolSemester" (
  "id" SERIAL PRIMARY KEY,
  "schoolSemester" varchar,
  "schoolYearId" int
);

CREATE TABLE "subjectOffer" (
  "id" SERIAL PRIMARY KEY,
  "subjectCode" varchar,
  "description" varchar,
  "unit" float,
  "Lec" varchar,
  "schoolYearId" int
);

CREATE TABLE "subjectOfferSchedule" (
  "id" SERIAL PRIMARY KEY,
  "subjectCodeId" varchar,
  "sectCode" varchar,
  "schedule" varchar,
  "facultyId" varchar,
  "schoolSemesterId" int
);
CREATE TABLE "sectCode" (
  "id" SERIAL PRIMARY KEY,
  "sectCode" varchar
);
CREATE TABLE "schoolFaculty" (
  "id" SERIAL PRIMARY KEY,
  "firstName" varchar,
  "lastName" varchar,
  "middleName" varchar
);

CREATE TABLE "scholarship" (
  "id" SERIAL PRIMARY KEY,
  "scholarship" varchar,
  "studentInfoId" varchar
);

CREATE TABLE "studentAccount" (
  "id" SERIAL PRIMARY KEY,
  "orDate" timestamp,
  "orNo" varchar,
  "assessment" float,
  "payment" float,
  "balance" float,
  "studentInfoId" int,
  "semesterId" int,
  "schoolYearId" int,
  "amount" float,
  "paymentMethodId" int,
  "status" int
);

CREATE TABLE "paymentMethod" (
  "id" SERIAL PRIMARY KEY,
  "paymentMethod" varchar
);



CREATE TABLE "status" (
  "id" SERIAL PRIMARY KEY,
  "status" varchar
);

ALTER TABLE "subjectOffer" ADD FOREIGN KEY ("id") REFERENCES "studentGrade" ("subjectCodeId");

ALTER TABLE "schoolYear" ADD FOREIGN KEY ("id") REFERENCES "subjectOffer" ("schoolYearId");

ALTER TABLE "studentInfo" ADD FOREIGN KEY ("id") REFERENCES "studentGrade" ("studentInfoId");

ALTER TABLE "subjectOffer" ADD FOREIGN KEY ("id") REFERENCES "subjectOfferSchedule" ("subjectCodeId");

ALTER TABLE "schoolFaculty" ADD FOREIGN KEY ("id") REFERENCES "subjectOfferSchedule" ("facultyId");

ALTER TABLE "schoolSemester" ADD FOREIGN KEY ("id") REFERENCES "subjectOfferSchedule" ("schoolSemesterId");

ALTER TABLE "schoolYear" ADD FOREIGN KEY ("id") REFERENCES "schoolSemester" ("schoolYearId");

ALTER TABLE "studentInfo" ADD FOREIGN KEY ("id") REFERENCES "scholarship" ("studentInfoId");

ALTER TABLE "studentInfo" ADD FOREIGN KEY ("id") REFERENCES "studentAccount" ("studentInfoId");

ALTER TABLE "scholarship" ADD FOREIGN KEY ("id") REFERENCES "studentAccount" ("semesterId");

ALTER TABLE "schoolYear" ADD FOREIGN KEY ("id") REFERENCES "studentAccount" ("schoolYearId");

ALTER TABLE "paymentMethod" ADD FOREIGN KEY ("id") REFERENCES "studentAccount" ("paymentMethodId");

ALTER TABLE "studentInfo" ADD FOREIGN KEY ("status") REFERENCES "studentGrade" ("gradeStatus");

ALTER TABLE "subjectOffer" ADD FOREIGN KEY ("schoolYearId") REFERENCES "studentGrade" ("id");

INSERT INTO "studentInfo" ("studentNo",
  password,
  "firstName",
  "lastName",
  "middleName",
  gender,"placeOfBirth","mobileNo",email,"residentialAddress","permanentAddress","admissionStatus","scholasticStatus","courseAndDescription",status)
  VALUES ('stu1','pass1', 'Juan','Luna','Park',1,'Sta. Mesa Metro Manila',091232232,'stu1@gmail.com','Recto Metro Manila','Mendiola Metro Manila','Enrolled','regular','BSCOE',1), 
  ('stu2','pass2', 'Gregorio','Santos','Macalos',1,'San Juan Metro Manila',0988342323,'stu2@gmail.com','Pasig Metro Manila','Manda Metro Manila','Enrolled','regular','BSCOE',1);
INSERT INTO "schoolYear" (schoolyear) VALUES (2021),(2022);
INSERT INTO "schoolSemester"("schoolSemester","schoolYearId") 
  VALUES ('First Semester',1),('Second Semester',1), ('Summer',1), 
  ('First Semester',2),('Second Semester',2), ('Summer',2);
INSERT INTO "schoolFaculty" ("firstName","lastName","middleName") VALUES ('Richardo','Moakes','Angel'),('Inga','Hessel','Gnome'),('Nicholas','Duquesnay','Elf');
INSERT INTO "subjectOffer" ("subjectCode","description","unit","Lec","schoolYearId") VALUES ('1','Subject 1-1','3.0','2.0','1'),
('1','Subject 1-1-2','4.0','6.0','1'),
('1','Subject 1-1-3','5.0','3.0','1'),
('1','Subject 1-2-1','4.0','6.0','2'),
('1','Subject 1-2-2','2.0','3.0','2'),
('1','Subject 1-2-3','4.0','4.0','2');

INSERT INTO "sectCode" ("sectCode") VALUES ('section 1');

INSERT INTO "subjectOfferSchedule" ("subjectCodeId","sectCodeId","schedule","facultyId","schoolSemesterId") 
  VALUES ('1','1','Mon - Fri 10:00 - 1:00', '1','1');
INSERT INTO "studentGrade" ("studentInfoId","subjectCodeId","finalGrade","gradeStatus","semester")
VALUES ('1','1','2.0','P','1')

SELECT so."subjectCode",so."description",so."unit",so."Lec",so."schoolYearId",sos."schoolSemesterId",sc."sectCode",sf."firstName",sf."lastName",sf."middleName",
sg."finalGrade",sg."gradeStatus"
FROM "subjectOfferSchedule" as sos
INNER JOIN "subjectOffer" as so 
ON sos."subjectCodeId" = so."id" 
INNER JOIN "studentInfo" as si
ON sos."schoolSemesterId" = so."id" 
INNER JOIN "sectCode" as sc 
on sc."id" = sos."sectCodeId"
INNER JOIN "schoolFaculty" as sf
on sf."id" = sos."facultyId"
INNER JOIN "studentGrade" as sg
on sg."studentInfoId" = si."id"
WHERE sos."schoolSemesterId" = 1 AND so."schoolYearId" = 1 AND si."studentNo" = 'stu2';


ALTER TABLE "studentInfo"
ADD "schoolSemesterId" integer;


ALTER TABLE "subjectOfferSchedule" ALTER COLUMN "facultyId" TYPE integer USING "facultyId"::integer;

create or replace procedure getStudentSchedule(
   schoolSemesterId int,
   schoolYearId int, 
   studentNo varchar(255)
)
language plpgsql    
as $$
begin
   SELECT so."subjectCode",so."description",so."unit",so."Lec",so."schoolYearId",sos."schoolSemesterId",sc."sectCode",sf."firstName",sf."lastName",sf."middleName"
  FROM "subjectOfferSchedule" as sos
  INNER JOIN "subjectOffer" as so 
  ON sos."subjectCodeId" = so."id" 
  INNER JOIN "studentInfo" as si
  ON sos."schoolSemesterId" = so."id" 
  INNER JOIN "sectCode" as sc 
  on sc."id" = sos."sectCodeId"
  INNER JOIN "schoolFaculty" as sf
  on sf."id" = sos."facultyId"
  WHERE sos."schoolSemesterId" = schoolSemesterId AND so."schoolYearId" = schoolYearId AND si."studentNo" = studentNo;
  RETURN   
    commit;

end;$$;

CREATE OR REPLACE FUNCTION studentSchedule(ssId integer,syId integer,sNo varchar(255)) RETURNS TABLE(subjectCode varchar(255),description varchar(255),
unit double precision,
Lec double precision,
schoolYearId int,
schoolSemesterId int,
sectCode varchar(255),
facultyFirstName varchar(255),
facultyLastName varchar(255),
facultyMiddleName varchar(255)

) AS $$
    DECLARE
    BEGIN
         RETURN QUERY
              SELECT so."subjectCode",so."description",
              so."unit",
              so."Lec",
              so."schoolYearId",
              sos."schoolSemesterId",
              sc."sectCode",
              sf."firstName",
              sf."lastName",
              sf."middleName"
              FROM "subjectOfferSchedule" as sos
              INNER JOIN "subjectOffer" as so 
              ON sos."subjectCodeId" = so."id" 
              INNER JOIN "studentInfo" as si
              ON sos."schoolSemesterId" = so."id" 
              INNER JOIN "sectCode" as sc 
              on sc."id" = sos."sectCodeId"
              INNER JOIN "schoolFaculty" as sf
              on sf."id" = sos."facultyId"
              WHERE sos."schoolSemesterId" = ssId AND so."schoolYearId" = syId AND si."studentNo" = sNo;
    END;
$$ LANGUAGE plpgsql;

-- ALTER TABLE "subjectOffer" ALTER COLUMN "Lec" TYPE float(25) USING "Lec"::float(25);

-- GRANT ALL PRIVILEGES ON TABLE "sectCode" TO me; 
CREATE OR REPLACE FUNCTION studentGrade(ssId integer,syId integer,sNo varchar(255)) RETURNS TABLE(subjectCode varchar(255),description varchar(255),
unit double precision,
Lec double precision,
schoolYearId int,
schoolSemesterId int,
sectCode varchar(255),
facultyFirstName varchar(255),
facultyLastName varchar(255),
facultyMiddleName varchar(255),
finalGrade double precision,
gradeStatus varchar(255)
) AS $$
    DECLARE
    BEGIN
         RETURN QUERY
              SELECT so."subjectCode",so."description",
              so."unit",
              so."Lec",
              so."schoolYearId",
              sos."schoolSemesterId",
              sc."sectCode",
              sf."firstName",
              sf."lastName",
              sf."middleName",
              sg."finalGrade",
              sg."gradeStatus"
              FROM "subjectOfferSchedule" as sos
              INNER JOIN "subjectOffer" as so 
              ON sos."subjectCodeId" = so."id" 
              INNER JOIN "studentInfo" as si
              ON sos."schoolSemesterId" = so."id" 
              INNER JOIN "sectCode" as sc 
              on sc."id" = sos."sectCodeId"
              INNER JOIN "schoolFaculty" as sf
              on sf."id" = sos."facultyId"
              INNER JOIN "studentGrade" as sg
              on sg."studentInfoId" = si."id"
              WHERE sos."schoolSemesterId" = ssId AND so."schoolYearId" = syId AND si."studentNo" = sNo;
    END;
$$ LANGUAGE plpgsql;
-- GRANT ALL PRIVILEGES ON TABLE "studentGrade" TO me; 

INSERT INTO "studentAccount" ("orDate","orNo","assessment","payment","balance","studentInfoId","semesterId","schoolYearId","amount","paymentMethodId","status","scholarshipId") 
VALUES ('2004-10-19 10:23:54+02','Total Amount Due','4302','4302','4302','1','1','1','4302','1','1','1');

INSERT INTO "paymentMethod" ("paymentMethod") VALUES ('Cash'),('Bank Transfer');

    
CREATE OR REPLACE FUNCTION studentAccount(ssId integer,syId integer,sNo varchar(255)) 
  RETURNS TABLE(
    schoolSemester varchar(255),
    scholarship varchar(255),
    schoolyear varchar(255),
    orDate timestamp,
    orNo varchar,
    assessment double precision,
    payment double precision,
    balance double precision
) AS $$
    DECLARE
    BEGIN
         RETURN QUERY
             SELECT ses."schoolSemester",
              ss."scholarship",
              sy."schoolyear",
              sa."orDate",
              sa."orNo",
              sa."assessment",
              sa."payment",
              sa."balance"
              FROM "studentAccount" as sa
              INNER JOIN "studentInfo" as si
              ON sa."studentInfoId" = si."id"
              INNER JOIN "scholarship" as ss
              ON sa."scholarshipId" = ss."id"
              INNER JOIN "schoolYear" as sy
              ON sa."schoolYearId" = sy."id"
              INNER JOIN "schoolSemester" ses
              ON sa."semesterId" = ses."id"
              INNER JOIN "paymentMethod" pm
              ON sa."paymentMethodId" = pm."id"
              WHERE sa."semesterId" = ssId AND sa."schoolYearId" = syId AND si."studentNo" = sNo;
    END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE insert_subjectOffer("subjectCode" character varying,
"description" character varying,
"unit" double precision,
"Lec" double precision,
"schoolYearId" integer)
LANGUAGE SQL
AS $$
INSERT INTO public."subjectOffer" ("subjectCode",
"description","unit",
"Lec","schoolYearId","status")
VALUES ("subjectCode", "description","unit", "Lec","schoolYearId",1);
$$;

CALL insert_subjectOffer('subj2-1-1','Subject 2-1-1', 5,5,1);

CREATE OR REPLACE PROCEDURE update_subjectOffer  
(subjectCodeP VARCHAR(100),
subjectDescriptionP VARCHAR(100),  
unitP double precision,  
LecP double precision,  
schoolYearIdP integer,  
subjectIdP integer)  
LANGUAGE plpgsql AS  
$$  
BEGIN         
UPDATE "subjectOffer" SET   
"subjectCode" = subjectCodeP,  
"description" = subjectDescriptionP,  
"unit" = unitP,  
"Lec" = LecP,  
"schoolYearId" = schoolYearIdP  
Where "subjectOffer".id = subjectIdP;  
END  
$$;  

CALL update_subjectOffer('subj2-1-1','Subject 2-1-1',6,6,1,7);

CREATE OR REPLACE PROCEDURE delete_subjectOffer  
(subjectId integer)  
LANGUAGE plpgsql AS  
$$  
BEGIN         
UPDATE "subjectOffer" SET   
"status" = 2
Where "subjectOffer".id = subjectId;  
END  
$$;

CALL delete_subjectOffer(6);

CREATE OR REPLACE FUNCTION getSubjectOffer() 
  RETURNS TABLE(
    subjectCode varchar(255),
    "description" varchar(255),
    unit double precision,
    Lec double precision,
    schoolYearId integer,
    "status" integer
) AS $$
    DECLARE
    BEGIN
         RETURN QUERY
             SELECT id,
            "subjectCode","description","unit","Lec","schoolYearId","status"
              FROM "subjectOffer";
    END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE insert_subjectSchedule("subjectCodeId" integer,
"sectCodeId" integer,
"schedule" varchar(1000),
"facultyId" integer,
"schoolSemesterId" integer)
LANGUAGE SQL
AS $$
INSERT INTO public."subjectOfferSchedule" ("subjectCodeId",
"sectCodeId","schedule",
"facultyId","schoolSemesterId","status")
VALUES ("subjectCodeId", "sectCodeId","schedule", "facultyId","schoolSemesterId",1);
$$;

CALL insert_subjectSchedule(1,2,'Wed - Tue 10:00 - 11:00', 1,2);

CREATE OR REPLACE PROCEDURE update_subjectSchedule  
(subjectIdP integer,
sectCodeIdP integer,
scheduleP VARCHAR(100),  
facultyIdP integer,  
schoolSemesterIdP integer)  
LANGUAGE plpgsql AS  
$$  
BEGIN         
UPDATE "subjectOfferSchedule" SET   
"sectCodeId" = sectCodeIdP,  
"schedule" = scheduleP,  
"facultyId" = facultyIdP,  
"schoolSemesterId" = schoolSemesterIdP  
Where "subjectOfferSchedule".id = subjectIdP;  
END  
$$;  
CALL update_subjectSchedule(1,2,'Mon - Tue 10:00 - 11:00',2,2);

CREATE OR REPLACE PROCEDURE delete_subjectSchedule 
(subjectId integer)  
LANGUAGE plpgsql AS  
$$  
BEGIN         
UPDATE "subjectOfferSchedule" SET   
"status" = 2
Where "subjectOfferSchedule".id = subjectId;  
END  
$$;

CALL delete_subjectSchedule(1);

ALTER TABLE "schoolFaculty" ADD COLUMN "password" varchar(255),ADD COLUMN "gender" integer,
ADD COLUMN "placeOfBirth" varchar(255),
ADD COLUMN "mobileNo" integer,
ADD COLUMN "email" varchar(255),
ADD COLUMN "residentialAddress" varchar(255),
ADD COLUMN "permanentAddress" varchar(255),
ADD COLUMN "admissionStatus" varchar(255),
ADD COLUMN "status" int;

CREATE OR REPLACE PROCEDURE insert_student_info(
"studentNo" varchar(255),
"password" varchar(255),
"firstName" varchar(255),
"lastName" varchar(255),
"middleName" varchar(255),
"gender" integer,
"placeOfBirth" varchar(255),
"mobileNo" integer,
"email" varchar(255),
"residentialAddress" varchar(255),
"permanentAddress" varchar(255),
"admissionStatus" integer,
"scholasticStatus" integer,
"courseAndDescription" integer,
"schoolYearId" integer,
"schoolSemesterId" integer)
LANGUAGE SQL
AS $$
INSERT INTO public."studentInfo" ("studentNo",
"password","firstName",
"lastName","middleName","gender",
"placeOfBirth","mobileNo","email",
"residentialAddress","permanentAddress","admissionStatus",
"scholasticStatus","courseAndDescription","status",
"schoolYearId","schoolSemesterId"
)
VALUES ("studentNo", 
"password","firstName", "lastName","middleName",
"gender","placeOfBirth", "mobileNo",
"email","residentialAddress", "permanentAddress",
"admissionStatus","scholasticStatus", "courseAndDescription",1,
"schoolYearId", "schoolSemesterId");
$$;

ALTER TABLE "studentInfo" ALTER COLUMN "gender" TYPE integer, ALTER COLUMN "admissionStatus" TYPE integer USING ("admissionStatus"::integer)
,ALTER COLUMN "scholasticStatus" TYPE integer USING ("scholasticStatus"::integer)
,ALTER COLUMN "courseAndDescription" TYPE integer USING ("courseAndDescription"::integer);

CALL insert_student_info('studentNo','password','firstname','lastName','middleName',1,'placeOfBirth',
2,'emaill','residentialAddress','permanentAddress',2,2,2,2,1);

CREATE OR REPLACE PROCEDURE update_student_info 
(idp integer,
mobileNop integer,
emailp VARCHAR(255),  
residentialAddressp VARCHAR(255))  
LANGUAGE plpgsql AS  
$$  
BEGIN         
UPDATE "studentInfo" SET   
"mobileNo" = mobileNop,  
"email" = emailp,  
"residentialAddress" = residentialAddressp
Where "studentInfo".id = idp;  
END  
$$; 
CALL update_student_info(3,233,'hello@gmail.com','pasiggg');


CREATE OR REPLACE PROCEDURE delete_student_info 
(idp integer)  
LANGUAGE plpgsql AS  
$$  
BEGIN         
UPDATE "studentInfo" SET   
"status" = 2
Where "studentInfo".id = idp;  
END  
$$;  

CALL delete_student_info(2);


CREATE OR REPLACE PROCEDURE insert_school_faculty(
"password" varchar(255),
"firstName" varchar(255),
"lastName" varchar(255),
"middleName" varchar(255),
"gender" integer,
"placeOfBirth" varchar(255),
"mobileNo" integer,
"email" varchar(255),
"residentialAddress" varchar(255),
"permanentAddress" varchar(255),
"facultyNo" varchar(255))
LANGUAGE SQL
AS $$
INSERT INTO public."schoolFaculty" (
"password","firstName",
"lastName","middleName","gender",
"placeOfBirth","mobileNo","email",
"residentialAddress","permanentAddress",
"status","facultyNo"
)
VALUES ("password","firstName", "lastName","middleName",
"gender","placeOfBirth", "mobileNo",
"email","residentialAddress", "permanentAddress",1,"facultyNo");
$$;

CALL insert_school_faculty('password','firstname','lastName','middleName',1,'placeOfBirth',
2,'emaill','residentialAddress','permanentAddress',"facultyNo");


CREATE OR REPLACE PROCEDURE update_school_faculty 
(idp integer,
mobileNop integer,
emailp VARCHAR(255),  
residentialAddressp VARCHAR(255))  
LANGUAGE plpgsql AS  
$$  
BEGIN         
UPDATE "schoolFaculty" SET   
"mobileNo" = mobileNop,  
"email" = emailp,  
"residentialAddress" = residentialAddressp
Where "schoolFaculty".id = idp;  
END  
$$; 

CALL update_school_faculty(3,233,'hello@gmail.com','pasiggg');


CREATE OR REPLACE PROCEDURE delete_school_faculty 
(idp integer)  
LANGUAGE plpgsql AS  
$$  
BEGIN         
UPDATE "schoolFaculty" SET   
"status" = 2
Where "schoolFaculty".id = idp;  
END  
$$;  

CALL delete_school_faculty(3);