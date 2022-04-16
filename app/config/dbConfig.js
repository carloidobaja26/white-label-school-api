const env = process.env;
const dotenv = require('dotenv');
dotenv.config();
// const config = {
//   db: { /* do not put password or any sensitive info here, done only for demo */
//     user: env.DB_USER,
//     host: env.DB_HOST,
//     database: env.DB_NAME,
//     password: env.DB_PASSWORD,
//     port: env.DB_PORT,
//   }
// };
const config = {
  db: { /* do not put password or any sensitive info here, done only for demo */
    connectionString: process.env.DB_URL_HR,
    ssl: {
      rejectUnauthorized: false
    }
  }
};
module.exports = config;