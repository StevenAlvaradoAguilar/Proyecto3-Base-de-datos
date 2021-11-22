import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import { HttpClientModule } from '@angular/common/http';
import { PgsqlService } from './services/pgsql.service';
import { MycomponentComponent } from './mycomponent/mycomponent.component';
import { FormsModule } from '@angular/forms'

@NgModule({
  declarations: [
    AppComponent,

    MycomponentComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule
  ],
  providers: [
    PgsqlService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }