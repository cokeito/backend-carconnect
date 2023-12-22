import express from 'express'
import morgan from 'morgan-body'
import jwt from 'jsonwebtoken'
import cors from 'cors'
import 'dotenv/config'
import { verifyToken } from './middlewares/middleware.js'


import { registerUser, validateLogin, getUser, getUsers, createUserAvatar, editUser, getWishlist, getUserWishlist } from './controllers/user-controller.js'
import { createItem, getItem, getItems, setItemScore, setItemWishlist, deleteItemWishlist, deleteItem, editItem, getMyItems } from './controllers/item-controller.js'
import { getItemCategories } from './controllers/item_categories-controller.js'
import { searchItems } from './controllers/search-controller.js'

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

    const token = jwt.sign(login, process.env.JWT_SECRET, { expiresIn: '4h' })
    res.send({ token })
  } catch (error) {
    res.status(error.code || 500).send(error)
  }
})

app.post("/auth/register", async (req, res) => {
  try {
    const user_params = req.body
    const user = await registerUser(user_params)
    return res.json(user)

  } catch (error) {
    console.error(error)
    res.status(error.code || 500).send(error)
  }
})

app.get('/users/:id', verifyToken, async (req, res) => {
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

app.get('/users', verifyToken, async (_, res) => {
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

app.get('/wishlist/user', verifyToken, async (req, res) => {
  try {
    const user_id = req.current_user.id
    console.log(user_id);
    const wishlist = await getUserWishlist(user_id)

    res.json(wishlist)
  }
  catch (error) {

    if (error.code) {
      res.status(error.code).send({ message: error.response })
    }
    else {
      res.status(401).send({ message: error })
    }
  }
})


app.post('/users/avatar', verifyToken, async (req, res) => {
  try {
    const user_id = req.current_user.id
    const photo64 = req.body.avatar
    const login = await createUserAvatar(user_id, photo64)
    const token = jwt.sign(login, process.env.JWT_SECRET, { expiresIn: '4h' })

    const data = {
      user: login,
      token: token
    }
    res.json(data)
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

app.put('/users/:id', verifyToken, async (req, res) => {
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

app.get('/wishlist', verifyToken, async (req, res) => {
  try {
    const user_id = req.current_user.id // todo sacar del token
    const wishlist = await getWishlist(user_id)

    res.json(wishlist)
  }
  catch (error) {

    if (error.code) {
      res.status(error.code).send({ message: error.response })
    }
    else {
      res.status(500).send({ message: error })
    }
  }
})


/* items_categories */

app.get("/item_categories", verifyToken, async (_, res) => {
  try {
    const item_categories = await getItemCategories()
    res.json(item_categories)
  }
  catch (error) {
    res.status(500).send({ message: error })
  }
})

/* items */

app.post("/items", verifyToken, async (req, res) => {
  try {
    const item = req.body
    const created_item = await createItem(item, req.current_user)

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

app.get("/items/my", verifyToken, async (req, res) => {
  try {
    const current_user = req.current_user
    const items = await getMyItems(current_user)
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


app.get("/items/:id", verifyToken, async (req, res) => {
  try {
    const id = req.params.id
    const item = await getItem(id)
    res.json(item)
  }
  catch (error) {
    res.status(500).send({ message: error })
  }
})

app.delete("/items/:id", verifyToken, async (req, res) => {
  try {
    const id = req.params.id
    const user_id = req.current_user.id

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

app.put("/items/:id", verifyToken, async (req, res) => {
  try {
    const id = req.params.id
    const user_id = req.current_user?.id
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

app.post("/items/:id/photos", verifyToken, async (req, res) => {
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

app.post("/items/:id/score", verifyToken, async (req, res) => {
  try {
    const id = req.params.id
    const score = req.body.score
    const user_id = req.current_user?.id

    const item = await setItemScore(id, score, user_id)
    res.json(item)
  }
  catch (error) {
    console.error(error)
    res.status(500).send({ message: error })
  }
})

/* item wishilist */

app.post("/items/:id/wishlist", verifyToken, async (req, res) => {
  try {
    const id = req.params.id
    const user_id = req.current_user?.id

    const item = await setItemWishlist(id, user_id)
    res.json(item)

  }
  catch (error) {
    if (error.code == 409) {
      console.log("**", error)
      res.status(409).send(error)
    }
    else {
      res.status(500).send(error)
    }

  }
})

app.delete("/items/:id/wishlist", verifyToken, async (req, res) => {
  try {
    const id = req.params.id
    const user_id = req.current_user.id

    const item = await deleteItemWishlist(id, user_id)
    res.json(item)

  }
  catch (error) {
    if (error.code == 409) {
      console.log("**", error)
      res.status(409).send(error)
    }
    else {
      res.status(500).send(error)
    }
  }
})


/* search */

app.post("/search", async (req, res) => {
  try {
    const search = req.body.search
    const items = await searchItems(search)
    res.json(items)
  }
  catch (error) {
    res.status(500).send({ message: error })
  }
})

export const server = app;