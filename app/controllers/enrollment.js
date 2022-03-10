const Pool = require('pg').Pool
const config = require('../config/dbConfig');
const pool = new Pool(config.db);

const getStudentEnrollment = (request, response) => {
    const schoolSemesterId = parseInt(request.params.semesterId)
    const schoolYearId = parseInt(request.params.schoolYearId)
    const studentNo = (request.params.studentNo)
    console.log(schoolSemesterId,schoolYearId,studentNo)
    // const schoolSemesterId = parseInt(1)
    // const schoolYearId = parseInt(1)
    // const studentNo = "stu1"

    pool.query('SELECT * FROM studentEnrollment($1,$2,$3)', [schoolSemesterId,schoolYearId,studentNo], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
        console.log('schoolSemesterId: '+schoolSemesterId)
    })
}
module.exports = {
    getStudentEnrollment
}