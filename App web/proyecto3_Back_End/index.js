// Requerido en todos
const express = require("express");
const morgan = require("morgan");
const cors = require("cors");
const bodyParser = require('body-parser');
const app = express();

// middlewares
app.use(morgan("dev"));
app.use(express.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

//CORS - Mejorar middleware
app.use(bodyParser.json())
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
)

// use it before all route definitions
app.use(cors());

// routes
app.use(require('./routes/routes'));
const port = process.env.PORT || 3300; //Declarando puerto de inicio

// Server starts
app.listen(port, () => {
    //Puerto de escucha
    console.log("Server running on port: " + port); 
}); 