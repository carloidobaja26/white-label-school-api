CREATE TABLE studentInfo (
  ID SERIAL PRIMARY KEY,
  studentNo VARCHAR(255) UNIQUE NOT NULL,
  firstName VARCHAR(255),
  lastName VARCHAR(255),
  middleName VARCHAR(255),
  gender INT,
  placeOfBirth VARCHAR(255),
  mobileNo INT,
  email VARCHAR(255) UNIQUE,
  residentialAddress VARCHAR(255),
  permanentAddress VARCHAR(255)
);
INSERT INTO "studentInfo" ("studentNo",
  password,
  "firstName",
  "lastName",
  "middleName",
  gender,"placeOfBirth","mobileNo",email,"residentialAddress","permanentAddress","admissionStatus","scholasticStatus","courseAndDescription",status)
  VALUES ('stu1','pass1', 'Juan','Luna','Park',1,'Sta. Mesa Metro Manila',091232232,'stu1@gmail.com','Recto Metro Manila','Mendiola Metro Manila','Enrolled','regular','BSCOE',1), 
  ('stu2','pass2', 'Gregorio','Santos','Macalos',1,'San Juan Metro Manila',0988342323,'stu2@gmail.com','Pasig Metro Manila','Manda Metro Manila','Enrolled','regular','BSCOE',1);

CREATE TABLE studentGrade (
  ID SERIAL PRIMARY KEY,
  studentNo VARCHAR(255) UNIQUE NOT NULL,
  subjectCode VARCHAR(255),
  description VARCHAR(255),
  facultyId INT,
  units Float,
  sectCode VARCHAR(255),
  finalGrade Float,
  gradeStatus VARCHAR(30),
  semester INT,
  schoolyear VARCHAR(255)
);
