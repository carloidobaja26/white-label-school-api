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
  "orDate" datetime,
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

ALTER TABLE "schoolFaculty" ADD FOREIGN KEY ("id") REFERENCES "subjectOffer" ("id");

ALTER TABLE "schoolSemester" ADD FOREIGN KEY ("id") REFERENCES "subjectOfferSchedule" ("schoolSemesterId");

ALTER TABLE "schoolYear" ADD FOREIGN KEY ("id") REFERENCES "schoolSemester" ("schoolYearId");

ALTER TABLE "studentInfo" ADD FOREIGN KEY ("id") REFERENCES "scholarship" ("studentInfoId");

ALTER TABLE "studentInfo" ADD FOREIGN KEY ("id") REFERENCES "studentAccount" ("studentInfoId");

ALTER TABLE "scholarship" ADD FOREIGN KEY ("id") REFERENCES "studentAccount" ("semesterId");

ALTER TABLE "schoolYear" ADD FOREIGN KEY ("id") REFERENCES "studentAccount" ("schoolYearId");

ALTER TABLE "paymentMethod" ADD FOREIGN KEY ("id") REFERENCES "studentAccount" ("paymentMethodId");

ALTER TABLE "studentInfo" ADD FOREIGN KEY ("status") REFERENCES "studentGrade" ("gradeStatus");

ALTER TABLE "subjectOffer" ADD FOREIGN KEY ("schoolYearId") REFERENCES "studentGrade" ("id");
