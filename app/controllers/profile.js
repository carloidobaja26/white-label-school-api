const Pool = require('pg').Pool
const pool = new Pool({
    user: 'me',
    host: 'localhost',
    database: 'studentportal',
    password: 'password',
    port: 5432,
})

const getUserProfile = (request, response) => {
    const id = parseInt(request.params.id)

    pool.query('SELECT * FROM "studentInfo" WHERE id = $1', [id], (error, results) => {
        if (error) {
            throw error
        }
        response.status(200).json(results.rows)
    })
}

const updateUserProfile = (request, response) => {
    const id = parseInt(request.params.id)
    const { name, email } = request.body

    pool.query(
        'UPDATE users SET name = $1, email = $2 WHERE id = $3',
        [name, email, id],
        (error, results) => {
            if (error) {
                throw error
            }
            response.status(200).send(`User modified with ID: ${id}`)
        }
    )
}

module.exports = {
    getUserProfile,
    updateUserProfile
}