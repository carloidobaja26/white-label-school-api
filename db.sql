--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: add(integer, integer); Type: FUNCTION; Schema: public; Owner: carlo.i.baja
--

CREATE FUNCTION public.add(integer, integer) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select $1 + $2;$_$;


ALTER FUNCTION public.add(integer, integer) OWNER TO "carlo.i.baja";

--
-- Name: delete_school_faculty(integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.delete_school_faculty(IN idp integer)
    LANGUAGE plpgsql
    AS $$  
BEGIN         
UPDATE "schoolFaculty" SET   
"status" = 2
Where "schoolFaculty".id = idp;  
END  
$$;


ALTER PROCEDURE public.delete_school_faculty(IN idp integer) OWNER TO "carlo.i.baja";

--
-- Name: delete_student_info(integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.delete_student_info(IN idp integer)
    LANGUAGE plpgsql
    AS $$  
BEGIN         
UPDATE "studentInfo" SET   
"status" = 2
Where "studentInfo".id = idp;  
END  
$$;


ALTER PROCEDURE public.delete_student_info(IN idp integer) OWNER TO "carlo.i.baja";

--
-- Name: delete_subjectoffer(integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.delete_subjectoffer(IN subjectid integer)
    LANGUAGE plpgsql
    AS $$  
BEGIN         
UPDATE "subjectOffer" SET   
"status" = 2
Where "subjectOffer".id = subjectId;  
END  
$$;


ALTER PROCEDURE public.delete_subjectoffer(IN subjectid integer) OWNER TO "carlo.i.baja";

--
-- Name: delete_subjectschedule(integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.delete_subjectschedule(IN subjectid integer)
    LANGUAGE plpgsql
    AS $$  
BEGIN         
UPDATE "subjectOfferSchedule" SET   
"status" = 2
Where "subjectOfferSchedule".id = subjectId;  
END  
$$;


ALTER PROCEDURE public.delete_subjectschedule(IN subjectid integer) OWNER TO "carlo.i.baja";

--
-- Name: getstudentschedule(integer, integer, character varying); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.getstudentschedule(IN schoolsemesterid integer, IN schoolyearid integer, IN studentno character varying)
    LANGUAGE plpgsql
    AS $$
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
    commit;
end;$$;


ALTER PROCEDURE public.getstudentschedule(IN schoolsemesterid integer, IN schoolyearid integer, IN studentno character varying) OWNER TO "carlo.i.baja";

--
-- Name: getsubjectoffer(); Type: FUNCTION; Schema: public; Owner: carlo.i.baja
--

CREATE FUNCTION public.getsubjectoffer() RETURNS TABLE(subjectcode character varying, description character varying, unit double precision, lec double precision, schoolyearid integer, status integer)
    LANGUAGE plpgsql
    AS $$
    DECLARE
    BEGIN
         RETURN QUERY
             SELECT id,
            "subjectCode","description","unit","Lec","schoolYearId","status"
              FROM "subjectOffer";
    END;
$$;


ALTER FUNCTION public.getsubjectoffer() OWNER TO "carlo.i.baja";

--
-- Name: getsubjectschedule(integer); Type: FUNCTION; Schema: public; Owner: carlo.i.baja
--

CREATE FUNCTION public.getsubjectschedule(subjectid integer) RETURNS TABLE(id integer, subjectcode character varying, sectcode character varying, schedule character varying, firstname character varying, lastname character varying, schoolsemester character varying)
    LANGUAGE plpgsql
    AS $$
    DECLARE
    BEGIN
         RETURN QUERY
select 
sos."id", so."subjectCode",sc."sectCode",
sos."schedule",sf."firstName",sf."lastName",
ss."schoolSemester"
from "subjectOfferSchedule" as sos
INNER JOIN "subjectOffer" as so 
on sos."subjectCodeId" = so."id"
INNER JOIN "sectCode" as sc
on sc."id" = sos."sectCodeId"
INNER JOIN "schoolFaculty" as sf
ON sf."id" = sos."facultyId"
INNER JOIN "schoolSemester" as ss
ON ss."id" = sos."schoolSemesterId"
Where sos."subjectCodeId" = subjectId
ORDER BY sos."id" ASC;
END;
$$;


ALTER FUNCTION public.getsubjectschedule(subjectid integer) OWNER TO "carlo.i.baja";

--
-- Name: inser_subjectoffer(character varying, character varying, double precision, double precision, integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.inser_subjectoffer(IN "subjectCode" character varying, IN description character varying, IN unit double precision, IN "Lec" double precision, IN "schoolYearId" integer)
    LANGUAGE sql
    AS $$
 INSERT INTO public."subjectOffer" ("subjectCode", "description","unit", "Lec","schoolYearId") VALUES ("subjectCode", "description","unit", "Lec","schoolYearId");
 $$;


ALTER PROCEDURE public.inser_subjectoffer(IN "subjectCode" character varying, IN description character varying, IN unit double precision, IN "Lec" double precision, IN "schoolYearId" integer) OWNER TO "carlo.i.baja";

--
-- Name: insert_school_faculty(character varying, character varying, character varying, character varying, integer, character varying, integer, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.insert_school_faculty(IN password character varying, IN "firstName" character varying, IN "lastName" character varying, IN "middleName" character varying, IN gender integer, IN "placeOfBirth" character varying, IN "mobileNo" integer, IN email character varying, IN "residentialAddress" character varying, IN "permanentAddress" character varying)
    LANGUAGE sql
    AS $$
INSERT INTO public."schoolFaculty" (
"password","firstName",
"lastName","middleName","gender",
"placeOfBirth","mobileNo","email",
"residentialAddress","permanentAddress",
"status"
)
VALUES ("password","firstName", "lastName","middleName",
"gender","placeOfBirth", "mobileNo",
"email","residentialAddress", "permanentAddress",1);
$$;


ALTER PROCEDURE public.insert_school_faculty(IN password character varying, IN "firstName" character varying, IN "lastName" character varying, IN "middleName" character varying, IN gender integer, IN "placeOfBirth" character varying, IN "mobileNo" integer, IN email character varying, IN "residentialAddress" character varying, IN "permanentAddress" character varying) OWNER TO "carlo.i.baja";

--
-- Name: insert_school_faculty(character varying, character varying, character varying, character varying, integer, character varying, integer, character varying, character varying, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.insert_school_faculty(IN password character varying, IN "firstName" character varying, IN "lastName" character varying, IN "middleName" character varying, IN gender integer, IN "placeOfBirth" character varying, IN "mobileNo" integer, IN email character varying, IN "residentialAddress" character varying, IN "permanentAddress" character varying, IN "facultyNo" character varying)
    LANGUAGE sql
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


ALTER PROCEDURE public.insert_school_faculty(IN password character varying, IN "firstName" character varying, IN "lastName" character varying, IN "middleName" character varying, IN gender integer, IN "placeOfBirth" character varying, IN "mobileNo" integer, IN email character varying, IN "residentialAddress" character varying, IN "permanentAddress" character varying, IN "facultyNo" character varying) OWNER TO "carlo.i.baja";

--
-- Name: insert_student_info(character varying, character varying, character varying, character varying, character varying, integer, character varying, integer, character varying, character varying, character varying, integer, integer, integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.insert_student_info(IN "studentNo" character varying, IN password character varying, IN "firstName" character varying, IN "lastName" character varying, IN "middleName" character varying, IN gender integer, IN "placeOfBirth" character varying, IN "mobileNo" integer, IN email character varying, IN "residentialAddress" character varying, IN "permanentAddress" character varying, IN "admissionStatus" integer, IN "scholasticStatus" integer, IN "courseAndDescription" integer, IN "schoolYearId" integer, IN "schoolSemesterId" integer)
    LANGUAGE sql
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


ALTER PROCEDURE public.insert_student_info(IN "studentNo" character varying, IN password character varying, IN "firstName" character varying, IN "lastName" character varying, IN "middleName" character varying, IN gender integer, IN "placeOfBirth" character varying, IN "mobileNo" integer, IN email character varying, IN "residentialAddress" character varying, IN "permanentAddress" character varying, IN "admissionStatus" integer, IN "scholasticStatus" integer, IN "courseAndDescription" integer, IN "schoolYearId" integer, IN "schoolSemesterId" integer) OWNER TO "carlo.i.baja";

--
-- Name: insert_studentinfo(character varying, character varying, character varying, character varying, character varying, integer, character varying, integer, character varying, character varying, character varying, integer, integer, integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.insert_studentinfo(IN "studentNo" character varying, IN password character varying, IN "firstName" character varying, IN "lastName" character varying, IN "middleName" character varying, IN gender integer, IN "placeOfBirth" character varying, IN "mobileNo" integer, IN email character varying, IN "residentialAddress" character varying, IN "permanentAddress" character varying, IN "admissionStatus" integer, IN "scholasticStatus" integer, IN "courseAndDescription" integer, IN "schoolYearId" integer, IN "schoolSemesterId" integer)
    LANGUAGE sql
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


ALTER PROCEDURE public.insert_studentinfo(IN "studentNo" character varying, IN password character varying, IN "firstName" character varying, IN "lastName" character varying, IN "middleName" character varying, IN gender integer, IN "placeOfBirth" character varying, IN "mobileNo" integer, IN email character varying, IN "residentialAddress" character varying, IN "permanentAddress" character varying, IN "admissionStatus" integer, IN "scholasticStatus" integer, IN "courseAndDescription" integer, IN "schoolYearId" integer, IN "schoolSemesterId" integer) OWNER TO "carlo.i.baja";

--
-- Name: insert_studentinfo(character varying, character varying, character varying, character varying, character varying, integer, character varying, integer, character varying, character varying, character varying, integer, integer, integer, integer, integer, integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.insert_studentinfo(IN "studentNo" character varying, IN password character varying, IN "firstName" character varying, IN "lastName" character varying, IN "middleName" character varying, IN gender integer, IN "placeOfBirth" character varying, IN "mobileNo" integer, IN email character varying, IN "residentialAddress" character varying, IN "permanentAddress" character varying, IN "admissionStatus" integer, IN "scholasticStatus" integer, IN "courseAndDescription" integer, IN status integer, IN "schoolYearId" integer, IN "schoolSemesterId" integer)
    LANGUAGE sql
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


ALTER PROCEDURE public.insert_studentinfo(IN "studentNo" character varying, IN password character varying, IN "firstName" character varying, IN "lastName" character varying, IN "middleName" character varying, IN gender integer, IN "placeOfBirth" character varying, IN "mobileNo" integer, IN email character varying, IN "residentialAddress" character varying, IN "permanentAddress" character varying, IN "admissionStatus" integer, IN "scholasticStatus" integer, IN "courseAndDescription" integer, IN status integer, IN "schoolYearId" integer, IN "schoolSemesterId" integer) OWNER TO "carlo.i.baja";

--
-- Name: insert_subjectoffer(character varying, character varying, double precision, double precision, integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.insert_subjectoffer(IN "subjectCode" character varying, IN description character varying, IN unit double precision, IN "Lec" double precision, IN "schoolYearId" integer)
    LANGUAGE sql
    AS $$
INSERT INTO public."subjectOffer" ("subjectCode",
"description","unit",
"Lec","schoolYearId","status")
VALUES ("subjectCode", "description","unit", "Lec","schoolYearId",1);
$$;


ALTER PROCEDURE public.insert_subjectoffer(IN "subjectCode" character varying, IN description character varying, IN unit double precision, IN "Lec" double precision, IN "schoolYearId" integer) OWNER TO "carlo.i.baja";

--
-- Name: insert_subjectschedule(integer, integer, character varying, integer, integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.insert_subjectschedule(IN "subjectCodeId" integer, IN "sectCodeId" integer, IN schedule character varying, IN "facultyId" integer, IN "schoolSemesterId" integer)
    LANGUAGE sql
    AS $$
INSERT INTO public."subjectOfferSchedule" ("subjectCodeId",
"sectCodeId","schedule",
"facultyId","schoolSemesterId","status")
VALUES ("subjectCodeId", "sectCodeId","schedule", "facultyId","schoolSemesterId",1);
$$;


ALTER PROCEDURE public.insert_subjectschedule(IN "subjectCodeId" integer, IN "sectCodeId" integer, IN schedule character varying, IN "facultyId" integer, IN "schoolSemesterId" integer) OWNER TO "carlo.i.baja";

--
-- Name: studentaccount(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: carlo.i.baja
--

CREATE FUNCTION public.studentaccount(ssid integer, syid integer, sno character varying) RETURNS TABLE(schoolsemester character varying, scholarship character varying, schoolyear character varying, ordate timestamp without time zone, orno character varying, assessment double precision, payment double precision, balance double precision)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.studentaccount(ssid integer, syid integer, sno character varying) OWNER TO "carlo.i.baja";

--
-- Name: studentgrade(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: carlo.i.baja
--

CREATE FUNCTION public.studentgrade(ssid integer, syid integer, sno character varying) RETURNS TABLE(subjectcode character varying, description character varying, unit double precision, lec double precision, schoolyearid integer, schoolsemesterid integer, sectcode character varying, facultyfirstname character varying, facultylastname character varying, facultymiddlename character varying, finalgrade double precision, gradestatus character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.studentgrade(ssid integer, syid integer, sno character varying) OWNER TO "carlo.i.baja";

--
-- Name: studentschedule(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: carlo.i.baja
--

CREATE FUNCTION public.studentschedule(ssid integer, syid integer, sno character varying) RETURNS TABLE(subjectcode character varying, description character varying, unit double precision, lec double precision, schoolyearid integer, schoolsemesterid integer, sectcode character varying, facultyfirstname character varying, facultylastname character varying, facultymiddlename character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.studentschedule(ssid integer, syid integer, sno character varying) OWNER TO "carlo.i.baja";

--
-- Name: test2(integer); Type: FUNCTION; Schema: public; Owner: carlo.i.baja
--

CREATE FUNCTION public.test2(user_id integer) RETURNS TABLE(subjectcode character varying, description character varying, unit double precision, lec double precision, schoolyearid integer, schoolsemesterid integer, sectcode character varying, firstname character varying, lastname character varying, middlename character varying)
    LANGUAGE plpgsql
    AS $$
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
              WHERE sos."schoolSemesterId" = user_id AND so."schoolYearId" = 1 AND si."studentNo" = 'stu1';
    END;
$$;


ALTER FUNCTION public.test2(user_id integer) OWNER TO "carlo.i.baja";

--
-- Name: test2(integer, integer); Type: FUNCTION; Schema: public; Owner: carlo.i.baja
--

CREATE FUNCTION public.test2(ssid integer, syid integer) RETURNS TABLE(subjectcode character varying, description character varying, unit double precision, lec double precision, schoolyearid integer, schoolsemesterid integer, sectcode character varying, firstname character varying, lastname character varying, middlename character varying)
    LANGUAGE plpgsql
    AS $$
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
              WHERE sos."schoolSemesterId" = ssId AND so."schoolYearId" = syId AND si."studentNo" = 'stu1';
    END;
$$;


ALTER FUNCTION public.test2(ssid integer, syid integer) OWNER TO "carlo.i.baja";

--
-- Name: test2(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: carlo.i.baja
--

CREATE FUNCTION public.test2(ssid integer, syid integer, sno character varying) RETURNS TABLE(subjectcode character varying, description character varying, unit double precision, lec double precision, schoolyearid integer, schoolsemesterid integer, sectcode character varying, firstname character varying, lastname character varying, middlename character varying)
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.test2(ssid integer, syid integer, sno character varying) OWNER TO "carlo.i.baja";

--
-- Name: update_school_faculty(integer, integer, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.update_school_faculty(IN idp integer, IN mobilenop integer, IN emailp character varying, IN residentialaddressp character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN         
UPDATE "schoolFaculty" SET   
"mobileNo" = mobileNop,  
"email" = emailp,  
"residentialAddress" = residentialAddressp
Where "schoolFaculty".id = idp;  
END  
$$;


ALTER PROCEDURE public.update_school_faculty(IN idp integer, IN mobilenop integer, IN emailp character varying, IN residentialaddressp character varying) OWNER TO "carlo.i.baja";

--
-- Name: update_student_info(integer, integer, character varying, character varying); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.update_student_info(IN idp integer, IN mobilenop integer, IN emailp character varying, IN residentialaddressp character varying)
    LANGUAGE plpgsql
    AS $$ 
BEGIN         
UPDATE "studentInfo" SET   
"mobileNo" = mobileNop,  
"email" = emailp,  
"residentialAddress" = residentialAddressp
Where "studentInfo".id = idp;  
END  
$$;


ALTER PROCEDURE public.update_student_info(IN idp integer, IN mobilenop integer, IN emailp character varying, IN residentialaddressp character varying) OWNER TO "carlo.i.baja";

--
-- Name: update_subjectoffer(character varying, character varying, double precision, double precision, integer, integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.update_subjectoffer(IN subjectcodep character varying, IN subjectdescriptionp character varying, IN unitp double precision, IN lecp double precision, IN schoolyearidp integer, IN subjectidp integer)
    LANGUAGE plpgsql
    AS $$  
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


ALTER PROCEDURE public.update_subjectoffer(IN subjectcodep character varying, IN subjectdescriptionp character varying, IN unitp double precision, IN lecp double precision, IN schoolyearidp integer, IN subjectidp integer) OWNER TO "carlo.i.baja";

--
-- Name: update_subjectschedule(integer, character varying, integer, integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.update_subjectschedule(IN sectcodeidp integer, IN schedulep character varying, IN facultyidp integer, IN schoolsemesteridp integer)
    LANGUAGE plpgsql
    AS $$  
BEGIN         
UPDATE "subjectOfferSchedule" SET   
"sectCodeId" = sectCodeIdP,  
"schedule" = scheduleP,  
"facultyId" = facultyIdP,  
"schoolSemesterId" = schoolSemesterIdP  
Where "subjectOfferSchedule".id = subjectIdP;  
END  
$$;


ALTER PROCEDURE public.update_subjectschedule(IN sectcodeidp integer, IN schedulep character varying, IN facultyidp integer, IN schoolsemesteridp integer) OWNER TO "carlo.i.baja";

--
-- Name: update_subjectschedule(integer, integer, character varying, integer, integer); Type: PROCEDURE; Schema: public; Owner: carlo.i.baja
--

CREATE PROCEDURE public.update_subjectschedule(IN subjectidp integer, IN sectcodeidp integer, IN schedulep character varying, IN facultyidp integer, IN schoolsemesteridp integer)
    LANGUAGE plpgsql
    AS $$  
BEGIN         
UPDATE "subjectOfferSchedule" SET   
"sectCodeId" = sectCodeIdP,  
"schedule" = scheduleP,  
"facultyId" = facultyIdP,  
"schoolSemesterId" = schoolSemesterIdP  
Where "subjectOfferSchedule".id = subjectIdP;  
END  
$$;


ALTER PROCEDURE public.update_subjectschedule(IN subjectidp integer, IN sectcodeidp integer, IN schedulep character varying, IN facultyidp integer, IN schoolsemesteridp integer) OWNER TO "carlo.i.baja";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: paymentMethod; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."paymentMethod" (
    id integer NOT NULL,
    "paymentMethod" character varying
);


ALTER TABLE public."paymentMethod" OWNER TO "carlo.i.baja";

--
-- Name: paymentMethod_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."paymentMethod_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."paymentMethod_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: paymentMethod_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."paymentMethod_id_seq" OWNED BY public."paymentMethod".id;


--
-- Name: scholarship; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public.scholarship (
    id integer NOT NULL,
    scholarship character varying,
    "studentInfoId" character varying
);


ALTER TABLE public.scholarship OWNER TO "carlo.i.baja";

--
-- Name: scholarship_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public.scholarship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scholarship_id_seq OWNER TO "carlo.i.baja";

--
-- Name: scholarship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public.scholarship_id_seq OWNED BY public.scholarship.id;


--
-- Name: schoolFaculty; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."schoolFaculty" (
    id integer NOT NULL,
    "firstName" character varying,
    "lastName" character varying,
    "middleName" character varying,
    password character varying(255),
    gender integer,
    "placeOfBirth" character varying(255),
    "mobileNo" integer,
    email character varying(255),
    "residentialAddress" character varying(255),
    "permanentAddress" character varying(255),
    status integer,
    "facultyNo" character varying(100)
);


ALTER TABLE public."schoolFaculty" OWNER TO "carlo.i.baja";

--
-- Name: schoolFaculty_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."schoolFaculty_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."schoolFaculty_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: schoolFaculty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."schoolFaculty_id_seq" OWNED BY public."schoolFaculty".id;


--
-- Name: schoolSemester; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."schoolSemester" (
    id integer NOT NULL,
    "schoolSemester" character varying,
    "schoolYearId" integer
);


ALTER TABLE public."schoolSemester" OWNER TO "carlo.i.baja";

--
-- Name: schoolSemester_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."schoolSemester_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."schoolSemester_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: schoolSemester_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."schoolSemester_id_seq" OWNED BY public."schoolSemester".id;


--
-- Name: schoolYear; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."schoolYear" (
    id integer NOT NULL,
    schoolyear character varying
);


ALTER TABLE public."schoolYear" OWNER TO "carlo.i.baja";

--
-- Name: schoolYear_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."schoolYear_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."schoolYear_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: schoolYear_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."schoolYear_id_seq" OWNED BY public."schoolYear".id;


--
-- Name: sectCode; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."sectCode" (
    id integer NOT NULL,
    "sectCode" character varying
);


ALTER TABLE public."sectCode" OWNER TO "carlo.i.baja";

--
-- Name: sectCode_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."sectCode_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."sectCode_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: sectCode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."sectCode_id_seq" OWNED BY public."sectCode".id;


--
-- Name: status; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public.status (
    id integer NOT NULL,
    status character varying
);


ALTER TABLE public.status OWNER TO "carlo.i.baja";

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.status_id_seq OWNER TO "carlo.i.baja";

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public.status_id_seq OWNED BY public.status.id;


--
-- Name: studentAccount; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."studentAccount" (
    id integer NOT NULL,
    "orDate" timestamp without time zone,
    "orNo" character varying,
    assessment double precision,
    payment double precision,
    balance double precision,
    "studentInfoId" integer,
    "semesterId" integer,
    "schoolYearId" integer,
    amount double precision,
    "paymentMethodId" integer,
    status integer,
    "scholarshipId" integer
);


ALTER TABLE public."studentAccount" OWNER TO "carlo.i.baja";

--
-- Name: studentAccount_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."studentAccount_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."studentAccount_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: studentAccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."studentAccount_id_seq" OWNED BY public."studentAccount".id;


--
-- Name: studentGrade; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."studentGrade" (
    id integer NOT NULL,
    "studentInfoId" integer,
    "subjectCodeId" integer,
    "finalGrade" double precision,
    "gradeStatus" character varying,
    semester integer
);


ALTER TABLE public."studentGrade" OWNER TO "carlo.i.baja";

--
-- Name: studentGrade_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."studentGrade_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."studentGrade_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: studentGrade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."studentGrade_id_seq" OWNED BY public."studentGrade".id;


--
-- Name: studentInfo; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."studentInfo" (
    id integer NOT NULL,
    "studentNo" character varying,
    password character varying,
    "firstName" character varying,
    "lastName" character varying,
    "middleName" character varying,
    gender integer,
    "placeOfBirth" character varying,
    "mobileNo" integer,
    email character varying,
    "residentialAddress" character varying,
    "permanentAddress" character varying,
    "admissionStatus" integer,
    "scholasticStatus" integer,
    "courseAndDescription" integer,
    status integer,
    "schoolYearId" integer,
    "schoolSemesterId" integer
);


ALTER TABLE public."studentInfo" OWNER TO "carlo.i.baja";

--
-- Name: studentInfo_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."studentInfo_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."studentInfo_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: studentInfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."studentInfo_id_seq" OWNED BY public."studentInfo".id;


--
-- Name: subjectOffer; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."subjectOffer" (
    id integer NOT NULL,
    "subjectCode" character varying(255),
    description character varying,
    unit double precision,
    "Lec" double precision,
    "schoolYearId" integer,
    status integer
);


ALTER TABLE public."subjectOffer" OWNER TO "carlo.i.baja";

--
-- Name: subjectOfferSchedule; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."subjectOfferSchedule" (
    id integer NOT NULL,
    "subjectCodeId" integer,
    "sectCodeId" integer,
    schedule character varying,
    "facultyId" integer,
    "schoolSemesterId" integer,
    status integer
);


ALTER TABLE public."subjectOfferSchedule" OWNER TO "carlo.i.baja";

--
-- Name: subjectOfferSchedule_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."subjectOfferSchedule_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."subjectOfferSchedule_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: subjectOfferSchedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."subjectOfferSchedule_id_seq" OWNED BY public."subjectOfferSchedule".id;


--
-- Name: subjectOffer_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."subjectOffer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."subjectOffer_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: subjectOffer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."subjectOffer_id_seq" OWNED BY public."subjectOffer".id;


--
-- Name: test; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public.test (
    id integer NOT NULL,
    test character varying
);


ALTER TABLE public.test OWNER TO "carlo.i.baja";

--
-- Name: testTable; Type: TABLE; Schema: public; Owner: carlo.i.baja
--

CREATE TABLE public."testTable" (
    id integer NOT NULL,
    "paymentMethod" character varying
);


ALTER TABLE public."testTable" OWNER TO "carlo.i.baja";

--
-- Name: testTable_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public."testTable_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."testTable_id_seq" OWNER TO "carlo.i.baja";

--
-- Name: testTable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public."testTable_id_seq" OWNED BY public."testTable".id;


--
-- Name: test_id_seq; Type: SEQUENCE; Schema: public; Owner: carlo.i.baja
--

CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.test_id_seq OWNER TO "carlo.i.baja";

--
-- Name: test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: carlo.i.baja
--

ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: me
--

CREATE TABLE public.users (
    id integer NOT NULL,
    studentno character varying(255) NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    middlename character varying(255),
    gender integer,
    placeofbirth character varying(255),
    mobileno integer,
    email character varying(255),
    residentialaddress character varying(255),
    permanentaddress character varying(255)
);


ALTER TABLE public.users OWNER TO me;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: me
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO me;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: me
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: paymentMethod id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."paymentMethod" ALTER COLUMN id SET DEFAULT nextval('public."paymentMethod_id_seq"'::regclass);


--
-- Name: scholarship id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public.scholarship ALTER COLUMN id SET DEFAULT nextval('public.scholarship_id_seq'::regclass);


--
-- Name: schoolFaculty id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."schoolFaculty" ALTER COLUMN id SET DEFAULT nextval('public."schoolFaculty_id_seq"'::regclass);


--
-- Name: schoolSemester id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."schoolSemester" ALTER COLUMN id SET DEFAULT nextval('public."schoolSemester_id_seq"'::regclass);


--
-- Name: schoolYear id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."schoolYear" ALTER COLUMN id SET DEFAULT nextval('public."schoolYear_id_seq"'::regclass);


--
-- Name: sectCode id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."sectCode" ALTER COLUMN id SET DEFAULT nextval('public."sectCode_id_seq"'::regclass);


--
-- Name: status id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.status_id_seq'::regclass);


--
-- Name: studentAccount id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."studentAccount" ALTER COLUMN id SET DEFAULT nextval('public."studentAccount_id_seq"'::regclass);


--
-- Name: studentGrade id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."studentGrade" ALTER COLUMN id SET DEFAULT nextval('public."studentGrade_id_seq"'::regclass);


--
-- Name: studentInfo id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."studentInfo" ALTER COLUMN id SET DEFAULT nextval('public."studentInfo_id_seq"'::regclass);


--
-- Name: subjectOffer id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."subjectOffer" ALTER COLUMN id SET DEFAULT nextval('public."subjectOffer_id_seq"'::regclass);


--
-- Name: subjectOfferSchedule id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."subjectOfferSchedule" ALTER COLUMN id SET DEFAULT nextval('public."subjectOfferSchedule_id_seq"'::regclass);


--
-- Name: test id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);


--
-- Name: testTable id; Type: DEFAULT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."testTable" ALTER COLUMN id SET DEFAULT nextval('public."testTable_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: paymentMethod; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."paymentMethod" (id, "paymentMethod") FROM stdin;
1	Cash
2	Bank Transfer
\.


--
-- Data for Name: scholarship; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public.scholarship (id, scholarship, "studentInfoId") FROM stdin;
1	DOST	1
\.


--
-- Data for Name: schoolFaculty; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."schoolFaculty" (id, "firstName", "lastName", "middleName", password, gender, "placeOfBirth", "mobileNo", email, "residentialAddress", "permanentAddress", status, "facultyNo") FROM stdin;
1	Richardo	Moakes	Angel	\N	\N	\N	\N	\N	\N	\N	1	\N
4	firstname	lastName	middleName	password	1	placeOfBirth	2	emaill	residentialAddress	permanentAddress	1	\N
2	Inga	Hessel	Gnome	\N	\N	\N	233	hello@gmail.com	pasiggg	\N	2	\N
3	Nicholas	Duquesnay	Elf	\N	\N	\N	233	hello@gmail.com	pasiggg	\N	2	\N
5	\N	Baja	Ido	$2b$10$.1a1uMHJeDbq2etvrKfQvefjVOuz/Vd.i/yRcGPerc6uE26RCsHxG	1	asdadsasda	121212121	carlooo@gmail.com	\N	\N	1	2022-bk9mgis6y-ST-0
6	\N	admin	admin	$2b$10$kMNJfHQ.yruHFqULgPwBUuDw9lu6NG0rQGOhLifMFCy6ivEeK6ZL2	1	manila	12345	admin@gmail.com	\N	\N	1	2022-syxvvdg50-ST-0
\.


--
-- Data for Name: schoolSemester; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."schoolSemester" (id, "schoolSemester", "schoolYearId") FROM stdin;
1	First Semester	1
2	Second Semester	1
3	Summer	1
4	First Semester	2
5	Second Semester	2
6	Summer	2
\.


--
-- Data for Name: schoolYear; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."schoolYear" (id, schoolyear) FROM stdin;
1	2021
2	2022
\.


--
-- Data for Name: sectCode; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."sectCode" (id, "sectCode") FROM stdin;
1	section 1
2	section 2
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public.status (id, status) FROM stdin;
\.


--
-- Data for Name: studentAccount; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."studentAccount" (id, "orDate", "orNo", assessment, payment, balance, "studentInfoId", "semesterId", "schoolYearId", amount, "paymentMethodId", status, "scholarshipId") FROM stdin;
1	2004-10-19 10:23:54	Total Amount Due	4302	4302	4302	1	1	1	4302	1	1	1
\.


--
-- Data for Name: studentGrade; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."studentGrade" (id, "studentInfoId", "subjectCodeId", "finalGrade", "gradeStatus", semester) FROM stdin;
1	1	1	2	P	1
\.


--
-- Data for Name: studentInfo; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."studentInfo" (id, "studentNo", password, "firstName", "lastName", "middleName", gender, "placeOfBirth", "mobileNo", email, "residentialAddress", "permanentAddress", "admissionStatus", "scholasticStatus", "courseAndDescription", status, "schoolYearId", "schoolSemesterId") FROM stdin;
1	stu1	pass1	Juan	Luna	Park	1	Sta. Mesa Metro Manila	91232232	stu1@gmail.com	Recto Metro Manila	Mendiola Metro Manila	1	1	1	1	1	1
3	studentNo	password	firstname	lastName	middleName	1	placeOfBirth	233	hello@gmail.com	pasiggg	permanentAddress	2	2	2	2	2	1
2	stu2	pass2	Gregorio	Santos	Macalos	1	San Juan Metro Manila	988342323	stu2@gmail.com	Pasig Metro Manila	Manda Metro Manila	1	1	1	2	1	1
5	2022-mw59hrc0i-ST-0	$2b$10$r050QDfzG.pNpXNjvLoC6.EJQa5mWcKYJQm6GRq16Zz0qJgRXN73e	ss	sss	s	1	1321	12312	123321	123132	123	1	1	1	1	1	1
4	2022-cvbx4vxk6-ST-0	$2b$10$McYYpBqJJlsQHRiLA7aggeGzgPbda/L4p23eF9Fa2bK04zPuBv2Ai	ss	sss	s	1	1321	12312	123321	123132	123	1	1	1	1	1	1
6	2022-4di73kol6-ST-0	$2b$10$YgA1FjHqZlYd.r0/Yd9GSOgbJ4hJWydSOw1Kd7Gc21TqFBbtpL7eu	fff	ll	mm	1	pob	1	eee	rra	pa	1	1	1	1	1	1
7	2022-tudppt9yb-ST-0	$2b$10$4dP1oKsC2jGOPVI61JSQQ.FBSyjLyUZa0hO5e2n2CTu6RV4cL9in2	admin	admin	admin	1	admin	12222	admin@gmail.com	asdasd	admin	1	1	1	1	1	1
\.


--
-- Data for Name: subjectOffer; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."subjectOffer" (id, "subjectCode", description, unit, "Lec", "schoolYearId", status) FROM stdin;
2	subj1-1-2	Subject 1-1-2	4	6	1	1
3	subj1-1-3	Subject 1-1-3	5	3	1	1
4	subj1-2-1	Subject 1-2-1	4	6	2	1
5	subj1-2-2	Subject 1-2-2	2	3	2	1
8	subj2-2-1	Subject 2-2-1	6	6	2	1
6	subj1-2-3	Subject 1-2-3	4	4	2	1
7	suj2-2-1	Subject 2-2-1	6	6	2	1
9	subj2-1-1	Subject 2-1-1	\N	5	2	1
14	SubjectCode3	This is SubjectCode 3	1	2	2	1
13	SubjectCode2	This is SubjectCode 2	3	2	2	1
12	SubjectCode1	This is SubjectCode 1 	4	1	2	1
11	sssss	dd	\N	2	2	1
10	ssss	ddddd	\N	2222	1	1
1	subj1-1-1	Subject 1-1	\N	2	1	1
\.


--
-- Data for Name: subjectOfferSchedule; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."subjectOfferSchedule" (id, "subjectCodeId", "sectCodeId", schedule, "facultyId", "schoolSemesterId", status) FROM stdin;
1	1	2	Mon - Tue 10:00 - 11:00	2	2	2
2	1	2	Wed - Tue 10:00 - 11:00	1	2	1
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public.test (id, test) FROM stdin;
1	carlo
\.


--
-- Data for Name: testTable; Type: TABLE DATA; Schema: public; Owner: carlo.i.baja
--

COPY public."testTable" (id, "paymentMethod") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: me
--

COPY public.users (id, studentno, firstname, lastname, middlename, gender, placeofbirth, mobileno, email, residentialaddress, permanentaddress) FROM stdin;
1	stu1	Juan	Luna	Park	1	Sta. Mesa Metro Manila	91232232	stu1@gmail.com	Recto Metro Manila	Mendiola Metro Manila
2	stu2	Gregorio	Santos	Macalos	1	San Juan Metro Manila	988342323	stu2@gmail.com	Pasig Metro Manila	Manda Metro Manila
\.


--
-- Name: paymentMethod_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."paymentMethod_id_seq"', 2, true);


--
-- Name: scholarship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public.scholarship_id_seq', 1, true);


--
-- Name: schoolFaculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."schoolFaculty_id_seq"', 6, true);


--
-- Name: schoolSemester_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."schoolSemester_id_seq"', 6, true);


--
-- Name: schoolYear_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."schoolYear_id_seq"', 2, true);


--
-- Name: sectCode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."sectCode_id_seq"', 2, true);


--
-- Name: status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public.status_id_seq', 1, false);


--
-- Name: studentAccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."studentAccount_id_seq"', 1, true);


--
-- Name: studentGrade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."studentGrade_id_seq"', 1, true);


--
-- Name: studentInfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."studentInfo_id_seq"', 7, true);


--
-- Name: subjectOfferSchedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."subjectOfferSchedule_id_seq"', 2, true);


--
-- Name: subjectOffer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."subjectOffer_id_seq"', 14, true);


--
-- Name: testTable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public."testTable_id_seq"', 1, false);


--
-- Name: test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: carlo.i.baja
--

SELECT pg_catalog.setval('public.test_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: me
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: paymentMethod paymentMethod_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."paymentMethod"
    ADD CONSTRAINT "paymentMethod_pkey" PRIMARY KEY (id);


--
-- Name: scholarship scholarship_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public.scholarship
    ADD CONSTRAINT scholarship_pkey PRIMARY KEY (id);


--
-- Name: schoolFaculty schoolFaculty_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."schoolFaculty"
    ADD CONSTRAINT "schoolFaculty_pkey" PRIMARY KEY (id);


--
-- Name: schoolSemester schoolSemester_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."schoolSemester"
    ADD CONSTRAINT "schoolSemester_pkey" PRIMARY KEY (id);


--
-- Name: schoolYear schoolYear_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."schoolYear"
    ADD CONSTRAINT "schoolYear_pkey" PRIMARY KEY (id);


--
-- Name: sectCode sectCode_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."sectCode"
    ADD CONSTRAINT "sectCode_pkey" PRIMARY KEY (id);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: studentAccount studentAccount_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."studentAccount"
    ADD CONSTRAINT "studentAccount_pkey" PRIMARY KEY (id);


--
-- Name: studentGrade studentGrade_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."studentGrade"
    ADD CONSTRAINT "studentGrade_pkey" PRIMARY KEY (id);


--
-- Name: studentInfo studentInfo_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."studentInfo"
    ADD CONSTRAINT "studentInfo_pkey" PRIMARY KEY (id);


--
-- Name: subjectOfferSchedule subjectOfferSchedule_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."subjectOfferSchedule"
    ADD CONSTRAINT "subjectOfferSchedule_pkey" PRIMARY KEY (id);


--
-- Name: subjectOffer subjectOffer_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."subjectOffer"
    ADD CONSTRAINT "subjectOffer_pkey" PRIMARY KEY (id);


--
-- Name: testTable testTable_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public."testTable"
    ADD CONSTRAINT "testTable_pkey" PRIMARY KEY (id);


--
-- Name: test test_pkey; Type: CONSTRAINT; Schema: public; Owner: carlo.i.baja
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_studentno_key; Type: CONSTRAINT; Schema: public; Owner: me
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_studentno_key UNIQUE (studentno);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: carlo.i.baja
--

GRANT USAGE ON SCHEMA public TO me;


--
-- Name: TABLE "paymentMethod"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public."paymentMethod" TO me;


--
-- Name: SEQUENCE "paymentMethod_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."paymentMethod_id_seq" TO me;


--
-- Name: TABLE scholarship; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public.scholarship TO me;


--
-- Name: SEQUENCE scholarship_id_seq; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public.scholarship_id_seq TO me;


--
-- Name: TABLE "schoolFaculty"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public."schoolFaculty" TO me;


--
-- Name: SEQUENCE "schoolFaculty_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."schoolFaculty_id_seq" TO me;


--
-- Name: TABLE "schoolSemester"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public."schoolSemester" TO me;


--
-- Name: SEQUENCE "schoolSemester_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."schoolSemester_id_seq" TO me;


--
-- Name: TABLE "schoolYear"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public."schoolYear" TO me;


--
-- Name: SEQUENCE "schoolYear_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."schoolYear_id_seq" TO me;


--
-- Name: TABLE "sectCode"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public."sectCode" TO me;


--
-- Name: SEQUENCE "sectCode_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."sectCode_id_seq" TO me;


--
-- Name: TABLE status; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public.status TO me;


--
-- Name: SEQUENCE status_id_seq; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public.status_id_seq TO me;


--
-- Name: TABLE "studentAccount"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public."studentAccount" TO me;


--
-- Name: SEQUENCE "studentAccount_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."studentAccount_id_seq" TO me;


--
-- Name: TABLE "studentGrade"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public."studentGrade" TO me;


--
-- Name: SEQUENCE "studentGrade_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."studentGrade_id_seq" TO me;


--
-- Name: TABLE "studentInfo"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public."studentInfo" TO me;


--
-- Name: SEQUENCE "studentInfo_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."studentInfo_id_seq" TO me;


--
-- Name: TABLE "subjectOffer"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public."subjectOffer" TO me;


--
-- Name: TABLE "subjectOfferSchedule"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public."subjectOfferSchedule" TO me;


--
-- Name: SEQUENCE "subjectOfferSchedule_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."subjectOfferSchedule_id_seq" TO me;


--
-- Name: SEQUENCE "subjectOffer_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."subjectOffer_id_seq" TO me;


--
-- Name: TABLE test; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT ALL ON TABLE public.test TO me;


--
-- Name: TABLE "testTable"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT ON TABLE public."testTable" TO me;


--
-- Name: SEQUENCE "testTable_id_seq"; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public."testTable_id_seq" TO me;


--
-- Name: SEQUENCE test_id_seq; Type: ACL; Schema: public; Owner: carlo.i.baja
--

GRANT SELECT,USAGE ON SEQUENCE public.test_id_seq TO me;


--
-- PostgreSQL database dump complete
--

