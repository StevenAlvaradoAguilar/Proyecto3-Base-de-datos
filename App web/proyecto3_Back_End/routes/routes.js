const { Router } = require("express");
const router = Router();

const consultas_controllers = require("../controllers/consultas-controllers");

/* RUTAS CONSULTAS */
router.post("/api/postTipoLocal", consultas_controllers.postTipoLocal);

router.get("/api/postFechas", consultas_controllers.postFechas);

router.get("/api/post", consultas_controllers.postpersonal_MinisterioSalud);

module.exports = router;
