const jwt = require("jsonwebtoken");

const authenticateToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];

  const token = authHeader && authHeader.split(" ")[1];
  if (!token)
    return res.status(401).json({ message: "Access token is missing" });

  // Verify the token
  jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ message: "Invalid token" });

    req.userId = user.id;
    req.email = user.email;
    next();
  });
};

module.exports = authenticateToken;
