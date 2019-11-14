import { Component, OnInit, OnDestroy } from "@angular/core";
import { Subscription } from "rxjs";
import { first } from "rxjs/operators";
import { HttpClient } from "@angular/common/http";
import { HttpHeaders } from "@angular/common/http";
import { User } from "@/_models";
import { UserService, AuthenticationService } from "@/_services";
import { Blood } from "../_models/Blood";
import { environment } from "../../environments/environment";

@Component({ templateUrl: "home.component.html" })
export class HomeComponent implements OnInit, OnDestroy {
  currentUser: User;
  currentUserSubscription: Subscription;
  users: User[] = [];
  expiringBlood: Array<Blood>;
  lowLevelBlood: Array<Blood>;

  constructor(
    private authenticationService: AuthenticationService,
    private userService: UserService,
    private http: HttpClient
  ) {
    this.currentUserSubscription = this.authenticationService.currentUser.subscribe(
      user => {
        this.currentUser = user;
      }
    );
  }

  ngOnInit() {
    this.loadAllUsers();
    this.expiringBlood = [];
    this.lowLevelBlood = [];
    this.getExpiringBlood();
    this.getLowLevelBlood();
  }

  getExpiringBlood() {
    const httpOptions = {
      headers: new HttpHeaders({
        "Content-Type": "application/json",
        Authorization: "my-auth-token"
      })
    };
    this.http
      .get(environment.apiBaseUrl + "BloodInventory/GetInventory", httpOptions)
      .subscribe(result => console.log(result));
    // add the code to filter here
    // you can do it all inside of the result by applying the filter function to the result

    // TO DO
    // Gets blood from Backend and fits into this.expiringBlood
  }

  getLowLevelBlood() {
    const httpOptions = {
      headers: new HttpHeaders({
        "Content-Type": "application/json",
        Authorization: "my-auth-token"
      })
    };
    this.http
      .get(environment.apiBaseUrl + "BloodInventory/GetAlerts", httpOptions)
      .subscribe(result => console.log(result));
  }

  disposeOfExpiringBlood() {
    const httpOptions = {
      headers: new HttpHeaders({
        "Content-Type": "application/json",
        Authorization: "my-auth-token"
      })
    };
    this.http
      .post(
        environment.apiBaseUrl + "BloodInventory/RemoveExpired",
        httpOptions
      )
      .subscribe(result => console.log(result));
  }

  ngOnDestroy() {
    // unsubscribe to ensure no memory leaks
    this.currentUserSubscription.unsubscribe();
  }

  deleteUser(id: number) {
    this.userService
      .delete(id)
      .pipe(first())
      .subscribe(() => {
        this.loadAllUsers();
      });
  }

  private loadAllUsers() {
    this.userService
      .getAll()
      .pipe(first())
      .subscribe(users => {
        this.users = users;
      });
  }
}
