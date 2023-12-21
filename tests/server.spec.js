import supertest from 'supertest';
//import { server } from "../index"
const requestWithSupertest = supertest('http://localhost:4000');

describe("Backend Testing - CarConnect", () => {

  let token = "";
  beforeAll(async () => {
    const response = await requestWithSupertest.post("/auth/login").send({
      email: "coke@mta.cl",
      password: "prueba",
    });
    token = response.body.token;

  });


  it('get a server status 403 if no token provided', async () => {
    const res = await requestWithSupertest.get("/items");
    expect(res.status).toBe(403);
  })

  it('get a server status 500 if token is invalid', async () => {
    const res = await requestWithSupertest.get("/items")
      .set("Authorization", `Bearer NOT_A_VALID_TOKEN`);
    expect(res.status).toBe(500);
  })



  it('get a server status 200 and an object with at least 1 item', async () => {
    let res = await requestWithSupertest.get("/items")
      .set("Authorization", `Bearer ${token}`);
    const { body } = res;
    expect(res.status).toBe(200);
    expect(body).toBeInstanceOf(Array);
    expect(res.body.length).toBeGreaterThan(0);
  });


});


/* 

it('get a server status 404 if try to delete a cafe without a non existing id and adding a jwt header token', async () => {
    const jwt = "1234567890";
    const randomId = Math.floor(Math.random() * 1000);
    const res = await request(server).delete("/cafes/" + randomId).set("Authorization", jwt);
    expect(res.status).toBe(404);
  });

  it('insert a new coffee with a random id', async () => {
    const newCoffee = {
      id: Math.floor(Math.random() * 1000),
      nombre: "Ice Frappe",
    }

    const res = await request(server).post("/cafes").send(newCoffee);
    expect(res.status).toBe(201);
  });

  it('get a server status 400 if try to PUT (update) a coffee sending an id different than the payload id', async () => {
    const updatedCoffee = {
      id: Math.floor(Math.random() * 1000),
      nombre: "Mocha",
    }

    const res = await request(server).put("/cafes/" + (updatedCoffee.id + 1)).send(updatedCoffee);
    expect(res.status).toBe(400);
  });
  */
