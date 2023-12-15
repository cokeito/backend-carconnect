import express from 'express'
import morgan from 'morgan-body'
import jwt from 'jsonwebtoken'
import cors from 'cors'
import 'dotenv/config'

import { registerUser, validateLogin } from './controllers/user-controller.js'
import { createItem, getItem, getItems, setItemScore } from './controllers/item-controller.js'
import { getItemCategories } from './controllers/item_categories-controller.js'

const app = express()

morgan(app)

app.listen(4000, console.log("SERVER ON"))
app.use(cors())
app.use(express.json())

app.use(express.static('public'))

/* users */
app.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body
    const login = await validateLogin(email, password)

    const token = jwt.sign(login, process.env.JWT_SECRET, { expiresIn: '2h' })
    res.send(token)
  } catch (error) {
    res.status(error.code || 500).send(error)
  }
})

app.post("/register", async (req, res) => {
  try {
    const user = req.body
    await registerUser(user)

    res.json({ message: "User Registered" })
  } catch (error) {
    console.error(error)
    res.status(error.code || 500).send(error)
  }
})


/* items */

app.post("/items", async (req, res) => {
  try {
    const item = req.body
    const created_item = await createItem(item)

    console.log(created_item);

    res.json({ message: "Item Created" })
  } catch (error) {
    console.error(error)
    res.status(error.code || 500).send(error)
  }
})

app.get("/items", async (req, res) => {
  try {
    const items = await getItems()
    res.json(items)
  }
  catch (error) {
    res.status(500).send({ message: error })
  }
})

app.get("/items/:id", async (req, res) => {
  try {
    const id = req.params.id
    const item = await getItem(id)
    res.json(item)
  }
  catch (error) {
    res.status(500).send({ message: error })
  }
})

/* items_categories */

app.get("/item_categories", async (req, res) => {
  try {
    const item_categories = await getItemCategories()
    res.json(item_categories)
  }
  catch (error) {
    res.status(500).send({ message: error })
  }
})

/* item score */

app.post("/items/:id/score", async (req, res) => {
  try {
    const id = req.params.id
    const score = req.body.score

    console.log('********', id, score);
    const item = await setItemScore(id, score)
    res.json(item)
  }
  catch (error) {
    console.error(error)
    res.status(500).send({ message: error })
  }
})