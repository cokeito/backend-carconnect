import { pool } from '../config/database.js'
import bcrypt from "bcryptjs";

export const registerUser = async (user) => {
  let { name, email, password, phone } = user

  const cryptedPass = bcrypt.hashSync(password, 10)

  const created_at = new Date()
  const values = [name, email, cryptedPass, phone, '1', created_at, created_at]

  const sql = "INSERT INTO users (name, email, password, phone, status, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, $6, $7 )"
  pool.query(sql, values)

}

export const validateLogin = async (email, password) => {

  const values = [email]
  const sql = "SELECT * FROM users WHERE email = $1"

  const { rows: [user], rowCount } = await pool.query(sql, values);

  const { password: passwordCrypted } = user

  const isMatch = bcrypt.compareSync(password, passwordCrypted)

  if (!isMatch || rowCount === 0) {
    throw {
      code: 401,
      message: 'Invalid username or password'
    }
  }

  delete user.password
  return user

}


