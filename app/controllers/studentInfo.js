const Pool = require('pg').Pool
const config = require('../config/dbConfig');
const pool = new Pool(config.db);
const bcrypt = require("bcrypt");

const createStudentInfo = async (request, response) => {
    const date = new Date();
    let year = date.getFullYear();
    const hashedPassword = await bcrypt.hash(request.body.studentInfo.password,10);
    const studentNoGen = year + '-' +  Math.random().toString(36).substr(2, 9) + '-ST-0';
    const firstname = request.body.studentInfo.firstName;
    const lastName = request.body.studentInfo.lastName;
    const middleName = request.body.studentInfo.middleName;
    const gender = request.body.studentInfo.gender;
    const placeOfBirth = request.body.studentInfo.placeOfBirth;
    const mobileNo = request.body.studentInfo.mobileNo;
    const email = request.body.studentInfo.email;
    const residentialAddress = request.body.studentInfo.residentialAddress;
    const permanentAddress = request.body.studentInfo.permanentAddress;
    const admissionStatus = parseInt(1);
    const scholasticStatus = parseInt(1);
    const courseAndDescription = request.body.studentInfo.courseAndDescription;
    const schoolYearId = request.body.studentInfo.schoolYearId;
    const schoolSemesterId = request.body.studentInfo.schoolSemesterId;
    pool.query('CALL insert_student_info($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16)', [studentNoGen, hashedPassword,firstname,lastName,
        middleName,gender,placeOfBirth,mobileNo,email,residentialAddress,permanentAddress,
        admissionStatus,scholasticStatus,courseAndDescription,schoolYearId,schoolSemesterId], 
    (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`studentInfo is added studentNo is ${studentNoGen}`)
    })
}

const updateStudentInfo = (request, response) => {
    const id = parseInt(request.body.id);
    const mobileNo = parseInt(request.body.mobileNo);
    const email = parseInt(request.body.email);
    const residentialAddress = parseInt(request.body.residentialAddress);
    pool.query('CALL update_student_info($1,$2,$3,$4)', [id,mobileNo,email,residentialAddress], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`subjectSchedule is updated ${id}`)
    })
}
const deleteStudentInfo = (request, response) => {
    const id = parseInt(request.body.id);
    pool.query('CALL delete_student_info($1)', [id], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`subjectSchedule is deleted`)
    })
}
const getStudentInfo = (request, response) => {
    pool.query('SELECT * FROM "studentInfo" ORDER BY id ASC', (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}
const getStudentInfoById = (request, response) => {
    const id = parseInt(request.params.id)
    pool.query('SELECT * FROM "studentInfo" WHERE id = $1', [id], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}
module.exports = {
    createStudentInfo,
    updateStudentInfo,
    deleteStudentInfo,
    getStudentInfo,
    getStudentInfoById
}