import PG from 'pg'

export const pool = new PG.Pool({
  host: 'localhost',
  user: 'coke',
  password: 'amazzon.pg',
  database: 'marketplace',
  allowExitOnIdle: true
})