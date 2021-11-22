const { Pool } = require("pg");

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "estadisticas",
  password: "Galaxy3300",
  port: 5438,
});

//Funcion Async : Asyncrona esta devuelve un objeto
const postTipoLocal = async (req, res) => {
  const {tipoLocal} = req.body
  const response = await pool.query('select estadisticas_tipo_local('+'\'' + tipoLocal + '\'' +')').then(response =>{
    return response;
  }).then(val => {
    if (val.rowCount < 1) 
      return res.status(200).json({mensaje:"No hay datos"});
    else if (val.rowCount >= 1) 
      return res.status(200).json(val.rows);
    else 
      return res.status(400).json({mensaje:"Indefinido"});
  }).catch (err => {
    console.error(err);
    return res.status(500).send(err);
  });
};

//Funcion Async : Asyncrona esta devuelve un objeto
const postFechas = async (req, res) => {
  const {nombre, inicio, fin} = req.body
  pool.query('select estadisticas_fecha('+'\'' + nombre + '\'' + '\'' + inicio + '\'' + '\''+ '\'' + fin + '\'' +')').then(response =>{
    return response;
  }).then(val => {
    if (val.rowCount < 1) 
      return res.status(200).json({mensaje:"No hay datos"});
    else if (val.rowCount >= 1) 
      return res.status(200).json(val.rows);
    else 
      return res.status(400).json({mensaje:"Indefinido"});
  }).catch (err => {
    console.error(err);
    return res.status(500).send(err);
  });
};

//Funcion Async : Asyncrona esta devuelve un objeto
const postpersonal_MinisterioSalud = async (req, res) => {
  const {nombre} = req.body
  pool.query('select estadisticas_personal_MinisterioSalud('+'\'' + nombre + '\''   +')').then(response =>{
    return response;
  }).then(val => {
    if (val.rowCount < 1) 
      return res.status(200).json({mensaje:"No hay datos"});
    else if (val.rowCount >= 1) 
      return res.status(200).json(val.rows);
    else 
      return res.status(400).json({mensaje:"Indefinido"});
  }).catch (err => {
    console.error(err);
    return res.status(500).send(err);
  });
};

module.exports = {
  postTipoLocal,
  postFechas,
  postpersonal_MinisterioSalud
};
