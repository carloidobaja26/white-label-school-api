const Pool = require('pg').Pool
const config = require('../config/dbConfig');
const pool = new Pool(config.db);

const getStudentSchedule = (request, response) => {
    // const schoolSemesterId = parseInt(request.params.schoolSemesterId)
    // const schoolYearId = parseInt(request.params.schoolYearId)
    // const studentNo = parseInt(request.params.studentNo)
    const schoolSemesterId = parseInt(1)
    const schoolYearId = parseInt(1)
    const studentNo = "stu1"
    pool.query('SELECT * FROM studentSchedule($1,$2,$3)', [schoolSemesterId,schoolYearId,studentNo], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}
module.exports = {
    getStudentSchedule,
}