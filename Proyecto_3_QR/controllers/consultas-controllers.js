const { Pool } = require("pg");

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "consulta_esquema_vacunacion_qr",
  password: "Galaxy3300",
  port: 5437,
});

//Funcion Async : Asyncrona esta devuelve un objeto
const postConsulta = async (req, res) => {
  const {cedula,nombre,tipo_local,nombre_local,tipo_consulta,info_adicional} = req.body;
  pool.query('select estado_vacunacion('+'\'' + cedula + '\'' + ',' +'\'' + nombre + '\'' + ',' +'\'' + tipo_local + '\'' + ',' +'\'' + nombre_local + '\'' + ',' +'\'' + tipo_consulta + '\'' + ',' +'\'' + info_adicional + '\''  +')').then(response =>{
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
    err.status = 500;
    return next(err);
  });
};

module.exports = {
  postConsulta,
};