const Pool = require('pg').Pool
const config = require('../config/dbConfig');
const pool = new Pool(config.db);
const bcrypt = require("bcrypt");

const createSchoolFaculty = async (request, response) => {
    const date = new Date();
    let year = date.getFullYear();
    console.log(request.body.facultyInfo.password)
    const hashedPassword = await bcrypt.hash(request.body.facultyInfo.password,10);
    const facultyNo = year + '-' +  Math.random().toString(36).substr(2, 9) + '-ST-0';
    const firstname = request.body.facultyInfo.firstname;
    const lastName = request.body.facultyInfo.lastName;
    const middleName = request.body.facultyInfo.middleName;
    const gender = request.body.facultyInfo.gender;
    const placeOfBirth = request.body.facultyInfo.placeOfBirth;
    const mobileNo = request.body.facultyInfo.mobileNo;
    const email = request.body.facultyInfo.email;
    const residentialAddress = request.body.facultyInfo.residentialAddress;
    const permanentAddress = request.body.facultyInfo.permanentAddress;
    pool.query('CALL insert_school_faculty($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)', [hashedPassword,firstname,lastName,
        middleName,gender,placeOfBirth,mobileNo,email,residentialAddress,permanentAddress,facultyNo], 
    (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`faculty is added ${firstname}`)
    })
}

const updateSchoolFaculty = (request, response) => {
    const id = parseInt(request.body.id);
    const mobileNo = parseInt(request.body.mobileNo);
    const email = parseInt(request.body.email);
    const residentialAddress = parseInt(request.body.residentialAddress);
    pool.query('CALL update_school_faculty($1,$2,$3,$4)', [id,mobileNo,email,residentialAddress], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`subjectSchedule is updated ${id}`)
    })
}
const deleteSchoolFaculty = (request, response) => {
    const id = parseInt(request.body.id);
    pool.query('CALL delete_school_faculty($1)', [id], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`subjectSchedule is deleted`)
    })
}
const getSchoolFaculty = (request, response) => {
    pool.query('SELECT * FROM "schoolFaculty" ORDER BY id ASC', (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}
const getSchoolFacultyById = (request, response) => {
    const id = parseInt(request.params.id)
    pool.query('SELECT * FROM "schoolFaculty" WHERE id = $1', [id], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}
module.exports = {
    createSchoolFaculty,
    updateSchoolFaculty,
    deleteSchoolFaculty,
    getSchoolFaculty,
    getSchoolFacultyById
}