import { Component, OnInit } from "@angular/core";
import { Router, ActivatedRoute } from "@angular/router";
import { FormBuilder, FormGroup, Validators } from "@angular/forms";
import { first } from "rxjs/operators";
import { Blood } from "../_models/Blood";
import { environment } from "../../environments/environment";
import { User } from "@/_models";
import { UserService, AuthenticationService } from "@/_services";
import { HttpClient } from "@angular/common/http";
import { HttpHeaders } from "@angular/common/http";

import { filterByMinAge, sortByType } from "../Dafny";

interface Entry {
  bloodType: String,
  bloodStatus: String,
  dateDonated: String
}

@Component({ templateUrl: "QueryBlood.component.html" })
export class QueryBloodComponent implements OnInit {

  private cols = [
    {head: "Blood Type",   key: "bloodType"},
    {head: "Blood Status", key: "bloodStatus"},
    {head: "Donated On",   key: "dateDonated"}
  ];
  private inv: any = [];

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private authenticationService: AuthenticationService,
    private http: HttpClient
  ) {}

  ngOnInit() {
    const httpOptions = {
      headers: new HttpHeaders({
        "Content-Type": "application/json",
        "Authorization": "my-auth-token"
      })
    };
    this.http.get(
      environment.apiBaseUrl + "BloodInventory/GetInventory",
      httpOptions
    )
    .subscribe(result => {
      this.inv = result;
      sortByType(this.inv, true);
      this.inv = filterByMinAge(this.inv, 0);
      console.log(result);
    });
  }

  page = 1;
  pageSize = 10;

  get inventory(): Entry[] {
    if (!this.inv) return [];
    return this.inv
      .map(entry => ["bloodType", "bloodStatus", "dateDonated"]
        .reduce((e, k) => { e[k] = entry[k]; return e }, {}))
      .slice((this.page - 1) * this.pageSize, (this.page - 1) * this.pageSize + this.pageSize);
  }
}
