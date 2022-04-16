const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const bcrypt = require("bcrypt");
const db = require('./app/controllers/queries')
const sc = require('./app/controllers/student')
const ss = require('./app/controllers/schedule')
const sg = require('./app/controllers/grade')
const sa = require('./app/controllers/account')
const ssu = require('./app/controllers/subject')
const ssus = require('./app/controllers/subjectSchedule')
const st = require('./app/controllers/studentInfo')
const sf = require('./app/controllers/faculty')
const l = require('./app/controllers/login')

const se = require('./app/controllers/enrollment')
const cors = require("cors");
const constants = require ('./app/constants/constant');

const port =  process.env.PORT || 8081
//Cors config start
const allowedOrigins = [
    constants.ALLOWED_ORIGINS_STAGING,
    constants.ALLOWED_ORIGINS_LIVE,
    constants.ALLOWED_ORIGINS_LOCALHOST,
    constants.DOMAIN_FACULTY,
    constants.DOMAIN_SCHOOL
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
async function passwordTest() {
  const hashedPassword = await bcrypt.hash('password',10);
  console.log(hashedPassword);
}
app.get(
    '/users',
    //cors(corsOptions),
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
app.get(
    '/enrollment/:semesterId/:schoolYearId/:studentNo',
    cors(corsOptions),
    function (req, res) {
      try {
        se.getStudentEnrollment(req, res);
      } catch (error) {
        console.log(constants.ERROR_READ_MESSAGE + error)
      }
    }
);

app.post(
  '/createSubject',
  cors(corsOptions),
  function (req, res) {
    try {
      ssu.createSubject(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post(
  '/updatesubjects',
  cors(corsOptions),
  function (req, res) {
    try {
      ssu.updateSubject(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post(
  '/deletesubjects',
  cors(corsOptions),
  function (req, res) {
    try {
      ssu.deleteSubject(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.get(
  '/subjects',
  cors(corsOptions),
  function (req, res) {
    try {
      ssu.getSubjects(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.get(
  '/subjects/:id',
  cors(corsOptions),
  function (req, res) {
    try {
      ssu.getSubjectsById(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);

app.post(
  '/createSubjectSchedule',
  // cors(corsOptions),
  function (req, res) {
    try {
      ssus.createSubjectSchedule(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post(
  '/updateSubjectSchedule',
  // cors(corsOptions),
  function (req, res) {
    try {
      ssus.updateSubjectSchedule(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post(
  '/deleteSubjectSchedule',
  // cors(corsOptions),
  function (req, res) {
    try {
      ssus.deleteSubjectSchedule(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.get(
  '/getSubjectsSchedule/:sId',
  cors(corsOptions),
  function (req, res) {
    try {
      ssus.getSubjectsSchedule(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.get(
  '/getSubjectsSchedule/:sId/ssId',
  // cors(corsOptions),
  function (req, res) {
    try {
      ssus.getSubjectsScheduleById(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);

app.post(
  '/addStudentInfo',
  // cors(corsOptions),
  function (req, res) {
    try {
    // console.log(req.body.studentInfo.firstName);
      st.createStudentInfo(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post(
  '/updateStudentInfo',
  // cors(corsOptions),
  function (req, res) {
    try {
      st.updateStudentInfo(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post(
  '/deleteStudentInfo',
  // cors(corsOptions),
  function (req, res) {
    try {
      st.deleteStudentInfo(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.get(
  '/getStudentInfo',
  // cors(corsOptions),
  function (req, res) {
    try {
      st.getStudentInfo(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.get(
  '/getStudentInfo/:id',
  // cors(corsOptions),
  function (req, res) {
    try {
      st.getStudentInfoById(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);


app.post(
  '/addSchoolFaculty',
  cors(corsOptions),
  function (req, res) {
    try {
      sf.createSchoolFaculty(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post(
  '/updateSchoolFaculty',
  // cors(corsOptions),
  function (req, res) {
    try {
      sf.updateSchoolFaculty(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post(
  '/deleteSchoolFaculty',
  // cors(corsOptions),
  function (req, res) {
    try {
      sf.deleteSchoolFaculty(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.get(
  '/getSchoolFaculty',
  // cors(corsOptions),
  function (req, res) {
    try {
      sf.getSchoolFaculty(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.get(
  '/getSchoolFaculty/:id',
  // cors(corsOptions),
  function (req, res) {
    try {
      sf.getSchoolFacultyById(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post(
  '/logInStudentInfo',
  cors(corsOptions),
  function (req, res) {
    try {
      l.logInStudentInfo(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post(
  '/logInFacultyInfo',
  cors(corsOptions),
  function (req, res) {
    try {
      l.logInFacultyInfo(req, res);
    } catch (error) {
      console.log(constants.ERROR_READ_MESSAGE + error)
    }
  }
);
app.post('/users', db.createUser)
app.put('/users/:id', db.updateUser)
app.delete('/users/:id', db.deleteUser)
// app.post('/subjects', ssu.createSubject)
app.listen(port, () => {
    console.log(`App running on port ${port}.`)
})
