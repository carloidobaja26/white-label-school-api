const Pool = require('pg').Pool
const config = require('../config/dbConfig');
const pool = new Pool(config.db);
const bcrypt = require("bcrypt");

const logInStudentInfo = async (request, response) => {
    const email = request.body.studentInfo.email;
    const password = request.body.studentInfo.password;
    pool.query('SELECT * FROM "studentInfo" WHERE email = $1', [email], async (error, results) => {
        if (error) {
            throw error
        }
        // results.rows.forEach(element => {
        //     console.log(element.password);
        // });
        if(results.rows.length == 0) {
            console.log("no acc")
            response.status(200).json({status: "2", message: "no user found",success: false})
        }
        else {
            const hashedPassword = results.rows[0].password;
            const resultPassword = await bcrypt.compare(password, hashedPassword)
            // const hashedPassword = await bcrypt.hash(request.body.studentInfo.password,10);
            if (resultPassword){
                response.status(200).json({status: "1", message: "user login", success: true})
            }
            else {
                console.log("in pass")
                response.status(200).json({status: "2", message: "password incorrect",success: false})
            } 
            // response.status(200).json(results.rows)
        }
    })
}
const logInFacultyInfo = async (request, response) => {
    const email = request.body.facultyInfo.email;
    const password = request.body.facultyInfo.password;
    pool.query('SELECT * FROM "schoolFaculty" WHERE email = $1', [email], async (error, results) => {
        if (error) {
            throw error
        }
        // results.rows.forEach(element => {
        //     console.log(element.password);
        // });
        if(results.rows.length == 0) {
            console.log("no acc")
            response.status(200).json({status: "2", message: "no user found",success: false})
        }
        else {
            const hashedPassword = results.rows[0].password;
            const resultPassword = await bcrypt.compare(password, hashedPassword)
            // const hashedPassword = await bcrypt.hash(request.body.studentInfo.password,10);
            if (resultPassword){
                response.status(200).json({status: "1", message: "user login", success: true})
            }
            else {
                console.log("in pass")
                response.status(200).json({status: "2", message: "password incorrect",success: false})
            } 
            // response.status(200).json(results.rows)
        }
    })
}
module.exports = {
    logInStudentInfo,
    logInFacultyInfo
}