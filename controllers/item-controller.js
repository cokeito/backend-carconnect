import { pool } from '../config/database.js'
import fs from 'fs'
import crypto from 'crypto';

const check_item = async (item_id, user_id) => {
  // check if item exists
  const sql_check = `
      SELECT
        *
      FROM
        items
      WHERE
        id = $1
      `;

  const { rows: [item], rowCount } = await pool.query(sql_check, [item_id]);

  if (rowCount == 0) {
    console.log('item not found');
    throw {
      code: 404,
      response: 'item not found',
    }
  }

  return item
}

const check_ownership = (item_user_id, user_id) => {

  console.log('item_user_id: ', item_user_id);
  console.log('user_id: ', user_id);

  if (parseInt(item_user_id) !== parseInt(user_id)) {
    console.log('item is not yours');
    throw {
      code: 401,
      response: 'item is not yours',
    }
  }
}

const check_status = (item_status) => {
  if (item_status == 1) {
    console.log('item is already deleted');
    throw {
      code: 409,
      response: 'item is already deleted',
    }
  }
}

export const createItem = async (item) => {

  console.log(item);
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
        COALESCE(ROUND(AVG(item_scores.score)), 0) AS average_score,
        item_categories.name AS category_name
      FROM
        items
      LEFT JOIN
        item_photos ON item_photos.item_id = items.id
      LEFT JOIN 
        item_scores ON item_scores.item_id = items.id
      LEFT JOIN
        item_categories ON item_categories.id = items.item_category_id
      WHERE
        items.status = 0
      GROUP BY
        items.id, item_categories.name
      ORDER BY
        items.id DESC
      `;

  const { rows, rowCount } = await pool.query(sql);

  return rows
}

export const getMyItems = async () => {
  const sql = `
      SELECT
        items.*,
        array_to_json(array_remove(array_agg(DISTINCT item_photos), NULL)) AS photos,
        COALESCE(ROUND(AVG(item_scores.score)), 0) AS average_score,
        item_categories.name AS category_name
      FROM
        items
      LEFT JOIN
        item_photos ON item_photos.item_id = items.id
      LEFT JOIN 
        item_scores ON item_scores.item_id = items.id
      LEFT JOIN
        item_categories ON item_categories.id = items.item_category_id
      WHERE
        items.status = 0
      AND
        items.user_id = $1
      GROUP BY
        items.id, item_categories.name
      ORDER BY
        items.id DESC
      `;

  const user_id = 1 // todo sacar del token

  const values = [user_id]
  const { rows, rowCount } = await pool.query(sql, values);

  return rows
}

export const getItem = async (id) => {
  const sql = `
  SELECT 
    items.*, 
    array_to_json(array_remove(array_agg(DISTINCT item_photos), NULL)) AS photos,
    COALESCE(ROUND(AVG(item_scores.score)), 0) AS average_score,
    item_categories.name AS category_name
  FROM 
    items
  LEFT JOIN 
    item_photos ON item_photos.item_id = items.id
  LEFT JOIN 
    item_scores ON item_scores.item_id = items.id
  LEFT JOIN
    item_categories ON item_categories.id = items.item_category_id
  WHERE 
    items.id = $1
  AND
    items.status = 0
  GROUP BY 
    items.id, item_categories.name;
  `;

  const { rows: [item], rowCount } = await pool.query(sql, [id]);

  if (rowCount == 0) {
    console.log('item not found');
    throw {
      code: 404,
      response: 'item not found',
    }
  }

  return item
}

export const deleteItem = async (id, user_id) => {

  // logic delete of an item
  // check ownership of the item
  const item = await check_item(id, user_id)
  check_ownership(item.user_id, user_id)
  check_status(item.status)

  // delete item
  const sql = `
      UPDATE
        items
      SET
        status = 1
      WHERE
        id = $1
      AND
        user_id = $2
      RETURNING *
      `;

  const { rows: [deleted_item] } = await pool.query(sql, [id, user_id]);
  return deleted_item

}

export const editItem = async (item_id, user_id, params) => {

  const item = await check_item(item_id, user_id)
  check_ownership(item.user_id, user_id)
  check_status(item.status)

  console.log(params);
  const { name, excerpt, year, price, item_category_id, item_type, is_discount, discount_price, description } = params
  const updated_at = new Date()
  const values = [name, excerpt, year, price, item_category_id, item_type, is_discount, discount_price, description, updated_at, item_id, user_id]

  const sql = `
      UPDATE
        items
      SET
        name = $1, 
        excerpt = $2, 
        year = $3, 
        price = $4, 
        item_category_id = $5, 
        item_type = $6, 
        is_discount = $7, 
        discount_price = $8, 
        description = $9, 
        updated_at = $10
      WHERE
        id = $11
      AND
        user_id = $12
      RETURNING *
      `;

  const { rows: [updatedItem] } = await pool.query(sql, values);
  return updatedItem
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

export const deleteItemWishlist = async (item_id, user_id) => {

  const sql = `
      DELETE FROM
        item_wishlists
      WHERE
        item_id = $1
      AND
        user_id = $2
      RETURNING *
      `;

  const { rows: [item] } = await pool.query(sql, [item_id, user_id]);

  return item
}


