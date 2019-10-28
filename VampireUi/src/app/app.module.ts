import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HospitalComponent } from './Components/hospital/hospital.component';
import { VampireComponent } from './Components/vampire/vampire.component';
import { BatmobileComponent } from './Components/batmobile/batmobile.component';
import { PathologyComponent } from './Components/pathology/pathology.component';
import { DonorComponent } from './Components/donor/donor.component';
import { VampireHeadquartersComponent } from './Components/vampire-headquarters/vampire-headquarters.component';

@NgModule({
  declarations: [
    AppComponent,
    HospitalComponent,
    VampireComponent,
    BatmobileComponent,
    PathologyComponent,
    DonorComponent,
    VampireHeadquartersComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
