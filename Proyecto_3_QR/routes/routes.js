const { Router } = require("express");
const router = Router();

const consultas_controllers = require("../controllers/consultas-controllers");

/* RUTAS CONSULTAS */
router.post("/api/postConsulta", consultas_controllers.postConsulta);


module.exports = router;
