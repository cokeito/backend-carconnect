import { pool } from '../config/database.js'
import fs from 'fs'
import crypto from 'crypto';


export const createItem = async (item) => {
  let { name, excerpt, year, price, item_category_id, item_type, is_discount, discount_price, description, photos } = item

  const status = 0
  const user_id = 1 // todo sacar del token
  const created_at = new Date()

  const values = [name, excerpt, year, price, item_category_id, item_type, is_discount, discount_price, description, status, user_id, created_at, created_at]

  console.log(values);

  const sql = `
      INSERT INTO items (name, excerpt, year, price, item_category_id, item_type, is_discount, discount_price, description, status, user_id, created_at, updated_at) 
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10,$11, $12, $13)
      RETURNING *
      `;

  const { rows: [saved_item], rowCount } = await pool.query(sql, values);
  console.log('inserted_id: ', saved_item);

  if (rowCount > 0) {

    // decode base64 files from front into server
    const item_id = saved_item.id
    const dir = `./public/uploads/items/${item_id}`;
    const upload_uri = `/uploads/items/${item_id}`;

    //create folders names with item_id
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }

    const saved_files = photos.map(photo => {
      const photo_hash = crypto.randomBytes(20).toString('hex');
      const extension = photo.split(';')[0].split('/')[1]
      const base64Data = photo.replace(/^data:image\/\w+;base64,/, '')
      const photoBuffered = Buffer.from(base64Data, 'base64')

      const file_path = `${dir}/item_photo_${photo_hash}.${extension}`

      const file_uri = `${upload_uri}/item_photo_${photo_hash}.${extension}`
      // save photos in folders
      fs.writeFileSync(file_path, photoBuffered);

      return file_uri
    });

    // save photos in db
    const status = 0
    const values = saved_files.map(photo => [photo, item_id, created_at, created_at, status])
    const sql_values = values.map((_, index) => {
      let factor = index * 5;
      return `($${factor + 1}, $${factor + 2}, $${factor + 3}, $${factor + 4}, $${factor + 5})`
    }).join(', ');

    console.log(sql_values);

    const sql = `
      INSERT INTO item_photos (photo, item_id, created_at, updated_at, status) 
      VALUES ${sql_values}
      RETURNING *
      `;
    const { rows, rowCount } = await pool.query(sql, values.flat());

    console.log('saved_photos: ', rows, rowCount);
    saved_item.photos = rows
  }

  return saved_item
}

export const getItems = async () => {
  const sql = `
      SELECT
        items.*,
        array_to_json(array_remove(array_agg(DISTINCT item_photos), NULL)) AS photos,
        COALESCE(ROUND(AVG(item_scores.score)), 0) AS average_score
      FROM
        items
      LEFT JOIN
        item_photos ON item_photos.item_id = items.id
      LEFT JOIN 
        item_scores ON item_scores.item_id = items.id
      GROUP BY
        items.id
      ORDER BY
        items.id ASC
      `;

  const { rows, rowCount } = await pool.query(sql);

  return rows
}

export const getItem = async (id) => {
  const sql = `
  SELECT 
    items.*, 
    array_to_json(array_remove(array_agg(DISTINCT item_photos), NULL)) AS photos,
    COALESCE(ROUND(AVG(item_scores.score)), 0) AS average_score
  FROM 
    items
  LEFT JOIN 
    item_photos ON item_photos.item_id = items.id
  LEFT JOIN 
    item_scores ON item_scores.item_id = items.id
  WHERE 
    items.id = $1
  GROUP BY 
    items.id;
  `;

  const { rows: [item], rowCount } = await pool.query(sql, [id]);

  return item
}

export const setItemScore = async (item_id, score) => {
  const user_id = 1 // todo sacar del token
  const created_at = new Date()
  const values = [item_id, score, created_at, created_at, user_id]
  const sql = `
      INSERT INTO item_scores (item_id, score, created_at, updated_at, user_id)
      values ($1, $2, $3, $4, $5)
      RETURNING *
      `;

  const { rows: [item], rowCount } = await pool.query(sql, values);

  return item
}

export const setItemWishlist = async (item_id, user_id) => {

  const created_at = new Date()
  const values = [item_id, created_at, created_at, user_id]

  // check if item is already in wishlist
  const sql_check = `
      SELECT
        *
      FROM
        item_wishlists
      WHERE
        item_id = $1
      AND
        user_id = $2
      `;

  const { rowCount } = await pool.query(sql_check, [item_id, user_id]);

  if (rowCount == 0) {
    const sql = `
    INSERT INTO
      item_wishlists (item_id, created_at, updated_at, user_id)
    values ($1, $2, $3, $4)
    RETURNING *
    `;

    const { rows: [item], rowCount } = await pool.query(sql, values);
    return item
  }
  else {
    //return an error that item is already in wishlist
    console.log('item is already in wishlist');
    throw {
      code: 409,
      response: 'item is already in wishlist',
    }

  }



}

