const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = 8081
const db = require('./app/controllers/queries')
const sc = require('./app/controllers/student')
const ss = require('./app/controllers/schedule')
const sg = require('./app/controllers/grade')
const sa = require('./app/controllers/account')

app.use(bodyParser.json())
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
)
app.get('/', (request, response) => {
    response.json({ info: 'Node.js, Express, and Postgres API' })
})
app.get('/users', db.getUsers)
app.get('/users/:id', db.getUserById)
app.post('/users', db.createUser)
app.put('/users/:id', db.updateUser)
app.delete('/users/:id', db.deleteUser)

app.get('/students', sc.getAllStudent)
app.get('/student/:studentNo', sc.getStudentByStudentNo)
app.get('/schedule/:schoolSemesterId/:schoolYearId/:studentNo', ss.getStudentSchedule)
app.get('/grade/:schoolSemesterId/:schoolYearId/:studentNo', sg.getStudentGrade)
app.get('/account/:schoolSemesterId/:schoolYearId/:studentNo', sa.getStudentAccount)

app.listen(port, () => {
    console.log(`App running on port ${port}.`)
})
