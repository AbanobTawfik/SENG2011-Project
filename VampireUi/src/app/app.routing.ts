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
import { SummaryComponent } from './Summary';

const appRoutes: Routes = [
    { path: '', component: HomeComponent, canActivate: [AuthGuard] },
    { path: 'login', component: LoginComponent },
    { path: 'register', component: RegisterComponent },
    { path: 'blood/add', component: AddBloodComponent, canActivate: [AuthGuard] },
    { path: 'blood/query', component: QueryBloodComponent, canActivate: [AuthGuard] },
    { path: 'blood/request', component: RequestBloodComponent, canActivate: [AuthGuard] },
    { path: 'blood/search', component: SearchBloodComponent, canActivate: [AuthGuard] },
    { path: 'orders', component: DeliveryOrdersComponent, canActivate: [AuthGuard] },
    { path: 'summary', component: SummaryComponent, canActivate: [AuthGuard] },

    // otherwise redirect to home
    { path: '**', redirectTo: '' }
];

export const routing = RouterModule.forRoot(appRoutes);
