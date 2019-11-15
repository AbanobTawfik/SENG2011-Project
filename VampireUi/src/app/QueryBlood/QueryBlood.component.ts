﻿import { Component, OnInit } from "@angular/core";
import { Router, ActivatedRoute } from "@angular/router";
import { FormBuilder, FormGroup, Validators } from "@angular/forms";
import { first } from "rxjs/operators";
import { Blood } from "../_models/Blood";
import { environment } from "../../environments/environment";
import { User } from "@/_models";
import { UserService, AuthenticationService } from "@/_services";
import { HttpClient } from "@angular/common/http";
import { HttpHeaders } from "@angular/common/http";

import { filterByMinAge, sortByDate, sortByType } from "../Dafny";

interface Entry {
  bloodId: String,
  bloodType: String,
  bloodStatus: String,
  dateDonated: String,
  bloodAge: number
}

@Component({ templateUrl: "QueryBlood.component.html" })
export class QueryBloodComponent implements OnInit {

  private cols = [
    {head: "Blood type",    key: "bloodType"},
    {head: "Blood status",  key: "bloodStatus"},
    {head: "Donated on",    key: "dateDonated"},
    {head: "Age (days)",       key: "bloodAge"},
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
      console.log(result);
      this.inv = result;
      this.inv.forEach(b => {
        b.dateDonated = b.dateDonated.split(" ")[0];
        b.bloodAge = (Date.now() - Date.parse(b.dateDonated)) / (1000*60*60*24) | 0;
      })
    });
  }

  page: number = 1;
  pageSize: number = 10;
  filterAge: boolean = false;
  sortActive: string = "d";
  sortByField: any = sortByDate;
  sortDesc: boolean = false;

  get inventory(): Entry[] {
    if (!this.inv) return [];
    return this.inv
      .map(entry => this.cols
        .map(c => c.key) // Get keys of cols
        .reduce((e, k) => { e[k] = entry[k]; return e }, {})) // Remove unnecessary fields
      .slice((this.page - 1) * this.pageSize, (this.page - 1) * this.pageSize + this.pageSize);
  }

  sortDate() {
    if (this.sortByField == sortByDate) return;
    this.sortByField = sortByDate;
    this.sortActive = "d";
    this.sortInv();
  }
  sortType() {
    if (this.sortByField == sortByType) return;
    this.sortByField = sortByType;
    this.sortActive = "t";
    this.sortInv();
  }
  sortInv() {
    this.sortByField(this.inv, this.sortDesc);
  }

}
