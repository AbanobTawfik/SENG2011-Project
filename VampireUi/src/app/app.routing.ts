import { Routes, RouterModule } from '@angular/router';

import { HomeComponent } from './home';
import { LoginComponent } from './login';
import { RegisterComponent } from './register';
import { AuthGuard } from './_guards';
import { AddBloodComponent } from './AddBlood';
import { RequestBloodComponent } from './RequestBlood';
import { SearchBloodComponent } from './SearchBlood';
import { DeliveryOrdersComponent } from './DeliveryOrders'; 

const appRoutes: Routes = [
    { path: '', component: HomeComponent, canActivate: [AuthGuard] },
    { path: 'login', component: LoginComponent },
    { path: 'register', component: RegisterComponent },
    { path: 'AddBlood', component: AddBloodComponent },
    { path: 'RequestBlood', component: RequestBloodComponent },
    { path: 'SearchBlood', component: SearchBloodComponent },
    { path: 'DeliveryOrders', component: DeliveryOrdersComponent },

    // otherwise redirect to home
    { path: '**', redirectTo: '' }
];

export const routing = RouterModule.forRoot(appRoutes);