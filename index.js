require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");

const app = express();
const cors = require("cors");
app.use(cors());
app.use(bodyParser.json());

// ✅ Import Routes
const authRoutes = require("./routes/authRoutes");

// ✅ Use Routes
app.use("/auth", authRoutes);

// ✅ MongoDB Connection
mongoose
  .connect(process.env.MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("MongoDB Connected ✅");
    app.listen(process.env.PORT || 5000, () => {
      console.log(`Server running on port ${process.env.PORT || 5000} 🚀`);
    });
  })
  .catch((err) => console.error("MongoDB Connection Error ❌:", err));

// ✅ Health Check Route
app.get("/", (req, res) => {
  res.send("E-Recycle Backend Running! ♻️");
});
