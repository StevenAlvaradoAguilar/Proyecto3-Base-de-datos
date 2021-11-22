import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';


@Injectable({
  providedIn: 'root'
})
export class PgsqlService {
  ip: string = 'localhost';
  port: string = '4200';
  urlRoot: string = `http://${this.ip}:${this.port}/ConexionPGSQL`;
  constructor(public http: HttpClient) { }
  
  getTipoLocal(tipo:string) {
    let data = {tipo}
    return this.http.post(`${this.urlRoot}/tipo`, data);
  }

  getFechas(local:string, fechaInicio:string, fechaFin: string) {
    let data = {local, fechaInicio, fechaFin}
    return this.http.post(`${this.urlRoot}/local`, data);
  }

  getInfoMinisterioSalud(local:string){
    let data = {local}
    return this.http.post(`${this.urlRoot}/ministerio`, data);
  }

}
