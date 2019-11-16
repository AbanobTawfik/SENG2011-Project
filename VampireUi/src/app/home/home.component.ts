import { Component, OnInit, OnDestroy } from "@angular/core";
import { Subscription } from "rxjs";
import { first } from "rxjs/operators";
import { HttpClient } from "@angular/common/http";
import { HttpHeaders } from "@angular/common/http";
import { User } from "@/_models";
import { UserService, AuthenticationService } from "@/_services";
import { Blood } from "../_models/Blood";
import { environment } from "../../environments/environment";
import { formatDate } from "@angular/common";

@Component({ templateUrl: "home.component.html" })
export class HomeComponent implements OnInit, OnDestroy {
  currentUser: User;
  currentUserSubscription: Subscription;
  users: User[] = [];
  expiringBlood: Array<Blood>;
  lowLevelBlood: Array<Blood>;
  Threshold: Number;

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
    this.getThreshold();
  }

  async getExpiringBlood() {
    const httpOptions = {
      headers: new HttpHeaders({
        "Content-Type": "application/json",
        Authorization: "my-auth-token"
      })
    };
    this.http
      .get(environment.apiBaseUrl + "BloodInventory/GetInventory", httpOptions)
      .subscribe(result => {
        console.log("Expiring Blood");
        console.log(result);
        this.expiringBlood = Object.assign([], result);
        var ExpiryDate = new Date();
        console.log(ExpiryDate.toLocaleDateString());
        ExpiryDate.setDate(ExpiryDate.getDate() - 43); // Filter Days is HERE
        console.log(ExpiryDate.toLocaleDateString());
        this.expiringBlood = this.expiringBlood.filter(d => {
          var dateDonated1 = undefined;
          dateDonated1 = formatDate(d.dateDonated, "MM/dd/yyyy", "en-US");
          var dateDonated2 = new Date(dateDonated1);
          console.log(dateDonated2.toLocaleDateString());
          return dateDonated2 <= ExpiryDate; // FILTER WORKS
        });
      });
  }

  async getLowLevelBlood() {
    const httpOptions = {
      headers: new HttpHeaders({
        "Content-Type": "application/json",
        Authorization: "my-auth-token"
      })
    };
    this.http
      .get(environment.apiBaseUrl + "BloodInventory/GetAlerts", httpOptions)
      .subscribe(result => {
        console.log("Low Level Blood");
        this.lowLevelBlood = Object.assign([], result);
        console.log(result);
      });
  }

  getThreshold() {
    const httpOptions = {
      headers: new HttpHeaders({
        "Content-Type": "application/json",
        Authorization: "my-auth-token"
      })
    };
    this.http
      .get(environment.apiBaseUrl + "Settings/GetSettingThreshold", httpOptions)
      .subscribe(result => {
        console.log("getting threshold");
        console.log(result);
      });
  }

  updateThreshold() {
    console.log("hello");
    const httpOptions = {
      headers: new HttpHeaders({
        "Content-Type": "application/json",
        Authorization: "my-auth-token"
      })
    };
    const updateValue: any = {
      settingType: "Threshold",
      settingValue: this.Threshold
    };

    this.http
      .put(
        environment.apiBaseUrl + "Settings/UpdateSetting",
        updateValue,
        httpOptions
      )
      .subscribe(res => console.log(res));
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
      .subscribe(result => {
        // Clear this.expiringBlood
        this.expiringBlood = [];
        this.expiringBlood = Object.assign([], result[1]); // Assign New Inventory into expiring blood for checks
        this.getExpiringBlood();
        this.getLowLevelBlood();
        console.log("Dispose Expiring Blood");
        console.log(result);
      });
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
