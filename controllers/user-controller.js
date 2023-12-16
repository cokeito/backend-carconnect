import { pool } from '../config/database.js'
import bcrypt from "bcryptjs";
import fs from 'fs'
import crypto from 'crypto';

const check_user = async (id) => {
  const sql = `
      SELECT
        *
      FROM
        users
      WHERE
        id = $1
      `;

  const { rows: [user], rowCount } = await pool.query(sql, [id]);

  if (rowCount == 0) {
    throw {
      code: 404,
      response: 'User not found',
    }
  }

  return user
}


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

export const getUser = async (id) => {

  const values = [id]
  const sql = "SELECT * FROM users WHERE id = $1"

  const { rows: [user], rowCount } = await pool.query(sql, values);

  if (rowCount === 0) {
    throw {
      code: 404,
      message: 'User not found'
    }
  }

  delete user.password

  return user
}

export const getUsers = async () => {

  const sql = `
    SELECT 
      *
    FROM
      users
    ORDER BY
      id ASC
    `

  const { rows: users, rowCount } = await pool.query(sql);



  if (rowCount === 0) {
    throw {
      code: 204,
      message: 'No Data'
    }
  }

  users.forEach(user => {
    delete user.password
    delete user.status
    delete user.created_at
    delete user.updated_at
  });

  return users

}

export const createUserAvatar = async (user_id, photo) => {

  // check if user exists
  const user = await check_user(user_id)

  if (parseInt(user.id) !== parseInt(user_id)) {
    throw {
      code: 401,
      response: 'not your user',
    }
  }
  // decode base64 files from front into server

  const dir = `./public/uploads/users/${user.id}`;
  const upload_uri = `/uploads/users/${user.id}`;

  //create folders names with item_id
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }

  // remove current avatar files on disk

  const files = fs.readdirSync(dir);
  files.forEach(file => {
    console.log('removing', `${dir}/${file}`)
    fs.unlinkSync(`${dir}/${file}`);
  });

  const photo_hash = crypto.randomBytes(20).toString('hex');
  const extension = photo.split(';')[0].split('/')[1]
  const base64Data = photo.replace(/^data:image\/\w+;base64,/, '')
  const photoBuffered = Buffer.from(base64Data, 'base64')

  const file_path = `${dir}/user_photo_${photo_hash}.${extension}`
  const file_uri = `${upload_uri}/user_photo_${photo_hash}.${extension}`
  // save photos in folders
  fs.writeFileSync(file_path, photoBuffered);

  /* update user record with avatar uri */

  const sql = `
    UPDATE
      users
    SET
      avatar = $1
    WHERE
      id = $2
    RETURNING
      *
    `;
  const values = [file_uri, user.id]

  const { rows: [updated_user], rowCount } = await pool.query(sql, values);
  delete updated_user.password
  return updated_user

  return file_uri


}

export const editUser = async (id, params) => {

  const user = await check_user(id)

  if (parseInt(user.id) !== parseInt(id)) {
    throw {
      code: 401,
      response: 'not your user',
    }
  }

  const { name, email, phone } = params

  const sql = `
      UPDATE
        users
      SET
        name = $1,
        email = $2,
        phone = $3
      WHERE
        id = $4
      RETURNING
        *
      `;
  const values = [name, email, phone, id]

  const { rows: [updated_user], rowCount } = await pool.query(sql, values);
  delete updated_user.password
  return updated_user

}


