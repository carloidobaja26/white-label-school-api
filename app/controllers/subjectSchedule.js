const Pool = require('pg').Pool
const config = require('../config/dbConfig');
const pool = new Pool(config.db);

const createSubjectSchedule = (request, response) => {
    const subjectCodeId = parseInt(request.body.subjectCodeId);
    const sectCodeId = parseInt(request.body.sectCodeId);
    const schedule = request.body.schedule;
    const facultyId = request.body.facultyId;
    const schoolSemesterId = parseInt(request.body.schoolSemesterId);
    pool.query('CALL insert_subjectSchedule($1,$2,$3,$4,$5)', [subjectCodeId, sectCodeId,schedule,facultyId,schoolSemesterId], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`subjectSchedule is added`)
    })
}
const updateSubjectSchedule = (request, response) => {
    const subjectId = request.body.subjectId;
    const sectCodeId = request.body.sectCodeId;
    const schedule = request.body.schedule;
    const facultyId = request.body.facultyId;
    const schoolSemesterId = parseInt(request.body.schoolSemesterId);
    pool.query('CALL update_subjectSchedule($1,$2,$3,$4,$5,$6)', [subjectId, sectCodeId,schedule,facultyId,schoolSemesterId], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`subjectSchedule is updated`)
    })
}

const deleteSubjectSchedule = (request, response) => {
    const id = parseInt(request.body.id);
    pool.query('CALL delete_subjectSchedule($1)', [id], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`subjectSchedule is deleted`)
    })
}
const getSubjectsSchedule = (request, response) => {
    pool.query('SELECT * FROM "subjectOfferSchedule" ORDER BY id ASC', (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}

const getSubjectsScheduleById = (request, response) => {
    const id = parseInt(request.params.id)
    pool.query('SELECT * FROM "subjectOfferSchedule" WHERE id = $1', [id], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}
module.exports = {
    createSubjectSchedule,
    updateSubjectSchedule,
    deleteSubjectSchedule,
    getSubjectsSchedule,
    getSubjectsScheduleById
}