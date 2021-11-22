import { Component, OnInit } from '@angular/core';
import { PgsqlService } from '../services/pgsql.service';
import { LocalComercial } from '../models/local-comercial';

@Component({
  selector: 'app-mycomponent',
  templateUrl: './mycomponent.component.html',
  styleUrls: ['./mycomponent.component.scss']
})
export class MycomponentComponent implements OnInit {

  //Lado izquierdo
  TipolocalComercial:LocalComercial[] = [
  {name:"Comercio"},
  {name: "Comercio"},
  {name:"Tienda"},
  {name:"Supermercado"}]; 

  TLSeleccionado: string = "undefined"
  Aceptados1:number = -1;
  Rechazados1:number = -1;

  //Lado derecho 
  LocalComercial:LocalComercial[] = [
    {name:"Pali"},
    {name:"El Rinconcito de Tita"},
    {name:"La Naranjeña"},
    {name:"CooproNaranjo"}
  ]
  LSeleccionado: string = "undefined"
  Aceptados2:number = -1;
  Rechazados2:number = -1;

  fechaInicio:string = "undefined"
  fechaFin:string = "undefined"

  estado:boolean = false

  Aceptados3:number = -1;
  Rechazados3:number = -1;

  estado2:boolean = false

  constructor(public pgsqlService: PgsqlService) { }

  ngOnInit(): void {}
  

  getTipoLocal(){
    if(this.TLSeleccionado != 'undefined'){
      this.pgsqlService.getTipoLocal(this.TLSeleccionado)
    .subscribe((seleccionado: any) => {
      this.Aceptados1 = seleccionado[0].estats_tipo_local.Aceptadas
      this.Rechazados1 = seleccionado[0].estats_tipo_local.Rechazadas
      }
    )
    }
  }

  getLocalFecha(){
  if(this.fechaFin != 'undefined' && this.fechaInicio != 'undefined'){
      this.pgsqlService.getFechas(this.LSeleccionado, this.fechaInicio, this.fechaFin)
    .subscribe((seleccionado: any) => {
      this.Aceptados2 = seleccionado[0].estats_fecha.Aceptadas
      this.Rechazados2 = seleccionado[0].estats_fecha.Rechazadas
      this.estado = true
      }
    )
  }
}

getMinisterio(){
      this.pgsqlService.getInfoMinisterioSalud(this.LSeleccionado)
      .subscribe((seleccionado: any) => {
        this.Aceptados3 = seleccionado[0].estats_personal_ms.Aceptadas
        this.Rechazados3 = seleccionado[0].estats_personal_ms.Rechazadas
        this.estado2 = true
      }
    )
}

  onSubmit1(form: { valid: any; }){
  }
  onSubmit2(form: { valid: any; }) {
  }

}
