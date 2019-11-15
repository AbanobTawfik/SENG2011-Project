import { Routes, RouterModule } from '@angular/router';

import { HomeComponent } from './home';
import { LoginComponent } from './login';
import { RegisterComponent } from './register';
import { AuthGuard } from './_guards';
import { AddBloodComponent } from './AddBlood';
import { QueryBloodComponent } from './QueryBlood';
import { RequestBloodComponent } from './RequestBlood';
import { SearchBloodComponent } from './SearchBlood';
import { DeliveryOrdersComponent } from './DeliveryOrders'; 

const appRoutes: Routes = [
    { path: '', component: HomeComponent, canActivate: [AuthGuard] },
    { path: 'login', component: LoginComponent },
    { path: 'register', component: RegisterComponent },
    { path: 'blood/add', component: AddBloodComponent },
    { path: 'blood/query', component: QueryBloodComponent },
    { path: 'blood/request', component: RequestBloodComponent },
    { path: 'blood/search', component: SearchBloodComponent },
    { path: 'orders', component: DeliveryOrdersComponent },

    // otherwise redirect to home
    { path: '**', redirectTo: '' }
];

export const routing = RouterModule.forRoot(appRoutes);
