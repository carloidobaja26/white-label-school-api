const Pool = require('pg').Pool
const config = require('../config/dbConfig');
const pool = new Pool(config.db);
const bcrypt = require("bcrypt");

const createStudentInfo = (request, response) => {
    // const password = request.body.password;
    const hashedPassword = await bcrypt.hash(request.body.password,10);
    const studentNo = request.body.studentNo;
    const firstname = request.body.firstname;
    const lastName = request.body.lastName;
    const middleName = request.body.middleName;
    const gender = request.body.gender;
    const placeOfBirth = request.body.placeOfBirth;
    const mobileNo = request.body.mobileNo;
    const email = request.body.email;
    const residentialAddress = request.body.residentialAddress;
    const permanentAddress = request.body.permanentAddress;
    const admissionStatus = request.body.admissionStatus;
    const scholasticStatus = request.body.scholasticStatus;
    const courseAndDescription = request.body.courseAndDescription;
    const schoolYearId = request.body.schoolYearId;
    const schoolSemesterId = request.body.schoolSemesterId;
    pool.query('CALL insert_student_info($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16)', [studentNo, hashedPassword,firstname,lastName,
        middleName,gender,placeOfBirth,mobileNo,email,residentialAddress,permanentAddress,
        admissionStatus,scholasticStatus,courseAndDescription,schoolYearId,schoolSemesterId], 
    (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`studentInfo is added`)
    })
}

module.exports = {
    createStudentInfo,
}