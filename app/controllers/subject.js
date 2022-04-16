const Pool = require('pg').Pool
const config = require('../config/dbConfig');
const pool = new Pool(config.db);

const createSubject = (request, response) => {
    const subjectCode = request.body.subject.subjectCode;
    const description = request.body.subject.description;
    const unit = request.body.subject.unit;
    const Lec = request.body.subject.Lec;
    const schoolYearId = parseInt(request.body.subject.schoolYearId);
    pool.query('CALL insert_subjectOffer($1,$2,$3,$4,$5)', [subjectCode, description,unit,Lec,schoolYearId], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`subject is added`)
    })
}
const updateSubject = (request, response) => {
    const subjectCode = request.body.subject.subjectCode;
    const description = request.body.subject.description;
    const unit = request.body.subject.unit;
    const Lec = request.body.subject.Lec;
    const schoolYearId = parseInt(request.body.subject.schoolYearId);
    const id = parseInt(request.body.subject.id);
    pool.query('CALL update_subjectOffer($1,$2,$3,$4,$5,$6)', [subjectCode, description,unit,Lec,schoolYearId,id], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`subject is updated`)
    })
}

const deleteSubject = (request, response) => {
    const id = parseInt(request.body.id);
    pool.query('CALL delete_subjectOffer($1)', [id], (error, results) => {
        if (error) {
            throw error
        }
        response.status(201).send(`subject is deleted`)
    })
}
const getSubjects = (request, response) => {
    pool.query('SELECT * FROM "subjectOffer" WHERE status = 1 ORDER BY id ASC', (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}

const getSubjectsById = (request, response) => {
    const id = parseInt(request.params.id)
    pool.query('SELECT * FROM "subjectOffer" WHERE id = $1', [id], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}
module.exports = {
    createSubject,
    updateSubject,
    deleteSubject,
    getSubjects,
    getSubjectsById
}