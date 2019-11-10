import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription } from 'rxjs';
import { first } from 'rxjs/operators';

import { User } from '@/_models';
import { UserService, AuthenticationService } from '@/_services';
import { Blood } from '../_models/Blood';

@Component({ templateUrl: 'home.component.html' })
export class HomeComponent implements OnInit, OnDestroy {
    currentUser: User;
    currentUserSubscription: Subscription;
    users: User[] = [];
    expiringBlood: Array<Blood>;
    lowLevelBlood: Array<Blood>;

    constructor(
        private authenticationService: AuthenticationService,
        private userService: UserService
    ) {
        this.currentUserSubscription = this.authenticationService.currentUser.subscribe(user => {
            this.currentUser = user;
        });
    }

    ngOnInit() {
        this.loadAllUsers();
        this.expiringBlood = [];
        this.lowLevelBlood = [];
        this.getExpiringBlood();
        this.getLowLevelBlood();

    }

    getExpiringBlood() {

        // TO DO
        // Gets blood from Backend and fits into this.expiringBlood

    }

    getLowLevelBlood() {

        // TO DO
        // Gets blood from backend and fits into this.lowLevelBlood


    }

    disposeOfExpiringBlood() {

        // TO DO
        // Send request to Backend to remove all the Blood Objects from this.expiringBlood
        console.log("Removed Expired Blood");
        this.getExpiringBlood();
        this.getLowLevelBlood();
    }

    


    ngOnDestroy() {
        // unsubscribe to ensure no memory leaks
        this.currentUserSubscription.unsubscribe();
    }

    deleteUser(id: number) {
        this.userService.delete(id).pipe(first()).subscribe(() => {
            this.loadAllUsers()
        });
    }

    private loadAllUsers() {
        this.userService.getAll().pipe(first()).subscribe(users => {
            this.users = users;
        });
    }
}