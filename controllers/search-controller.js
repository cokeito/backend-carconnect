import { pool } from '../config/database.js'

export const searchItems = async (str) => {
  console.log(str);
  const values = [str]

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
      items.name LIKE '%' || $1 || '%'
    GROUP BY
      items.id, item_categories.name
    ORDER by
    items.id DESC
      `;

  const { rows: search, rowCount } = await pool.query(sql, values);

  if (rowCount === 0) {
    return []
  } else {
    return search
  }

}