const Pool = require('pg').Pool
const config = require('../config/dbConfig');
const pool = new Pool(config.db);
const getAllStudent = (request, response) => {
    pool.query('SELECT * FROM "studentInfo" ORDER BY id ASC', (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}
const getStudentByStudentNo = (request, response) => {
    const studentNo = request.params.studentNo
    pool.query('SELECT * FROM "studentInfo" WHERE "studentNo" = $1', [studentNo], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}
module.exports = {
    getAllStudent,
    getStudentByStudentNo
}