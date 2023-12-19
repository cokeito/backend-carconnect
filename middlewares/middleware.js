import jwt from 'jsonwebtoken';
import 'dotenv/config'


export function verifyToken(req, res, next) {
  const bearerHeader = req.headers['authorization'];

  if (!bearerHeader) {
    return res.status(403).send({ message: 'No token provided.' });
  }

  const token = bearerHeader.split(' ')[1];

  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(500).send({ message: 'Failed to authenticate token.' });
    }
    req.current_user = decoded;
    next();
  });
}