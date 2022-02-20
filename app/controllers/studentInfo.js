const Pool = require('pg').Pool
const config = require('../config/dbConfig');
const pool = new Pool(config.db);
const bcrypt = require("bcrypt");

const createStudentInfo = (request, response) => {
    const date = new Date();
    let year = date.getFullYear();
    const hashedPassword = await bcrypt.hash(request.body.password,10);
    const studentNoGen = year + '-' +  Math.random().toString(36).substr(2, 9) + '-ST-0';
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