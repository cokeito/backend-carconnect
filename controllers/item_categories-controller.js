import { pool } from '../config/database.js'

export const getItemCategories = async () => {
  const sql = `
    SELECT * FROM item_categories
  `;

  const { rows, rowCount } = await pool.query(sql);

  return rows
}