const Pool = require('pg').Pool
const pool = new Pool({
    user: 'me',
    host: 'localhost',
    database: 'studentportal',
    password: 'password',
    port: 5432,
})
const getAllStudentInfo = (request, response) => {
    pool.query('SELECT * FROM studentInfo ORDER BY id ASC', (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}
module.exports = {
    getAllStudentInfo
}