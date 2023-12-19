import express from 'express'
import morgan from 'morgan-body'
import jwt from 'jsonwebtoken'
import cors from 'cors'
import 'dotenv/config'
import { verifyToken } from './middlewares/middleware.js'


import { registerUser, validateLogin, getUser, getUsers, createUserAvatar, editUser } from './controllers/user-controller.js'
import { createItem, getItem, getItems, setItemScore, setItemWishlist, deleteItemWishlist, deleteItem, editItem, getMyItems } from './controllers/item-controller.js'
import { getItemCategories } from './controllers/item_categories-controller.js'

const app = express()
morgan(app)
app.listen(4000, console.log("SERVER ON"))
app.use(cors())
app.use(express.json({ limit: '50mb' })); /* set limit for 50mb*/
app.use(express.static('public')) /* public path for files */

/* users */
app.post("/auth/login", async (req, res) => {
  try {
    const { email, password } = req.body
    const login = await validateLogin(email, password)

    const token = jwt.sign(login, process.env.JWT_SECRET, { expiresIn: '2h' })
    res.send({ token })
  } catch (error) {
    res.status(error.code || 500).send(error)
  }
})

app.post("/auth/register", async (req, res) => {
  try {
    const user = req.body
    await registerUser(user)

    res.json({ message: "Usuario creado satisfactoriamente" })
  } catch (error) {
    console.error(error)
    res.status(error.code || 500).send(error)
  }
})

app.get('/users/:id', async (req, res) => {
  console.log('here')
  try {
    const id = req.params.id
    const user = await getUser(id)

    res.json(user)
  }
  catch (error) {
    console.error(error)
    res.status(error.code || 500).send(error)
  }
})

app.get('/users', async (_, res) => {
  try {
    const users = await getUsers()
    res.json(users)
  } catch (error) {
    if (error.code) {
      res.status(error.code).send({ message: error })
    } else {
      res.status(500).send({ message: error })
    }
  }
})

app.post('/users/:id/avatar', async (req, res) => {
  try {
    const id = req.params.id
    const user_id = 1 // todo sacar del token

    const photo64 = req.body.avatar

    const item = await createUserAvatar(user_id, photo64)

    res.json(item)
  }
  catch (error) {
    console.log(error);
    if (error.code) {
      res.status(error.code).send({ message: error.response })
    }
    else {
      console.error(error)
      res.status(500).send({ message: error })
    }
  }
})

app.put('/users/:id', async (req, res) => {
  try {
    const id = req.params.id
    const user_id = 1 // todo sacar del token
    const params = req.body

    const item = await editUser(id, user_id, params)

    res.json(item)
  }
  catch (error) {
    console.log(error);
    if (error.code) {
      res.status(error.code).send({ message: error.response })
    }
    else {
      res.status(500).send({ message: error })
    }
  }
})

/* items_categories */

app.get("/item_categories", async (_, res) => {
  try {
    const item_categories = await getItemCategories()
    res.json(item_categories)
  }
  catch (error) {
    res.status(500).send({ message: error })
  }
})

/* items */

app.post("/items", async (req, res) => {
  try {
    const item = req.body
    const created_item = await createItem(item)

    console.log(created_item);

    res.json(created_item)
  } catch (error) {
    console.error(error)
    res.status(error.code || 500).send(error)
  }
})

app.get("/items", verifyToken, async (req, res) => {
  console.log('current_user: ', req.current_user)

  try {
    const items = await getItems()
    res.json(items)
  }
  catch (error) {
    if (error.code == 404) {
      res.status(404).send({ message: error })
    } else {
      console.log('123')
      res.status(500).send({ message: error })
    }
  }
})

app.get("/items/my", async (_, res) => {
  try {
    const items = await getMyItems()
    res.json(items)
  }
  catch (error) {
    if (error.code == 404) {
      res.status(404).send({ message: error })
    } else {
      res.status(500).send({ message: error })
    }

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

app.delete("/items/:id", async (req, res) => {
  try {
    const id = req.params.id
    const user_id = 1 // todo sacar del token

    const item = await deleteItem(id, user_id)

    res.json(item)
  }
  catch (error) {

    if (error.code == 401) {
      res.status(401).send({ message: error })
    }
    else {
      res.status(500).send({ message: error })
    }
  }
})

app.put("/items/:id", async (req, res) => {
  try {
    const id = req.params.id
    const user_id = 1 // todo sacar del token
    const params = req.body

    const item = await editItem(id, user_id, params)

    res.json(item)
  }
  catch (error) {
    console.log(error);
    if (error.code) {
      res.status(error.code).send({ message: error.response })
    }
    else {
      res.status(500).send({ message: error })
    }
  }
})

/* item photos */

app.post("/items/:id/photos", async (req, res) => {
  try {
    const id = req.params.id
    const user_id = 1 // todo sacar del token

    //const item = await addPhotoToItem(item_id, user_id)

    res.json(item)
  }
  catch (error) {
    console.log(error);
    if (error.code) {
      res.status(error.code).send({ message: error.response })
    }
    else {
      console.error(error)
      res.status(500).send({ message: error })
    }
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

/* item wishilist */

app.post("/items/:id/wishlist", async (req, res) => {
  try {
    const id = req.params.id
    const user_id = 1 // todo sacar del token

    const item = await setItemWishlist(id, user_id)
    res.json(item)

  }
  catch (error) {
    if (error.code == 409) {
      res.status(409).send({ message: error })
    }
    else {
      res.status(500).send({ message: error })
    }

  }
})

app.delete("/items/:id/wishlist", async (req, res) => {
  try {
    const id = req.params.id
    const user_id = 1 // todo sacar del token

    const item = await deleteItemWishlist(id, user_id)
    res.json(item)

  }
  catch (error) {
    if (error.code == 409) {
      res.status(409).send({ message: error })
    }
    else {
      res.status(500).send({ message: error })
    }

  }
})