const express = require('express')
const bodyParser = require('body-parser')
const app = express()

const db = require('./app/controllers/queries')
const sc = require('./app/controllers/student')
const ss = require('./app/controllers/schedule')
const sg = require('./app/controllers/grade')
const sa = require('./app/controllers/account')
const cors = require("cors");
const constants = require ('./app/constants/constant');

const port = constants.PORT_VALUE
//Cors config start
const allowedOrigins = [
    constants.ALLOWED_ORIGINS_STAGING,
    constants.ALLOWED_ORIGINS_LIVE,
    constants.ALLOWED_ORIGINS_LOCALHOST,
  ];
  
  app.options("*", cors());
  var corsOptions = {
    origin: function (origin, callback) {
      if (allowedOrigins.indexOf(origin) !== -1) {
        callback(null, true);
      } 
      else {
        callback(new Error(constants.CORS_NOT_ALLOWED));
      }
    },
  };
//Cors config end
app.use(bodyParser.json())
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
)
app.get('/', (request, response) => {
    response.json({ info: 'Node.js, Express, and Postgres API' })
})
app.get(
    '/users',
    cors(corsOptions),
    function (req, res) {
      try {
        db.getUsers(req, res);
      } catch (error) {
        console.log(constants.ERROR_READ_MESSAGE + error)
      }
    }
);
app.get(
    '/users/:id',
    cors(corsOptions),
    function (req, res) {
      try {
        db.getUserById(req, res);
      } catch (error) {
        console.log(constants.ERROR_READ_MESSAGE + error)
      }
    }
);
app.get(
    '/students',
    cors(corsOptions),
    function (req, res) {
      try {
        sc.getAllStudent(req, res);
      } catch (error) {
        console.log(constants.ERROR_READ_MESSAGE + error)
      }
    }
);
app.get(
    '/student/:studentNo',
    cors(corsOptions),
    function (req, res) {
      try {
        sc.getStudentByStudentNo(req, res);
      } catch (error) {
        console.log(constants.ERROR_READ_MESSAGE + error)
      }
    }
);
app.get(
    '/schedule/:schoolSemesterId/:schoolYearId/:studentNo',
    cors(corsOptions),
    function (req, res) {
      try {
        ss.getStudentSchedule(req, res);
      } catch (error) {
        console.log(constants.ERROR_READ_MESSAGE + error)
      }
    }
);
app.get(
    '/grade/:schoolSemesterId/:schoolYearId/:studentNo',
    cors(corsOptions),
    function (req, res) {
      try {
        sg.getStudentGrade(req, res);
      } catch (error) {
        console.log(constants.ERROR_READ_MESSAGE + error)
      }
    }
);
app.get(
    '/account/:schoolSemesterId/:schoolYearId/:studentNo',
    cors(corsOptions),
    function (req, res) {
      try {
        sa.getStudentAccount(req, res);
      } catch (error) {
        console.log(constants.ERROR_READ_MESSAGE + error)
      }
    }
);

app.post('/users', db.createUser)
app.put('/users/:id', db.updateUser)
app.delete('/users/:id', db.deleteUser)

app.listen(port, () => {
    console.log(`App running on port ${port}.`)
})
