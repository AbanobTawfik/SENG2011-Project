import { Component, OnInit } from "@angular/core";
import { Router, ActivatedRoute } from "@angular/router";
import { environment } from "../../environments/environment";
import { User } from "@/_models";
import { UserService, AuthenticationService } from "@/_services";
import { HttpClient } from "@angular/common/http";
import { HttpHeaders } from "@angular/common/http";

import { filterByType, filterByAge, sortByType, sortByDate } from "../Dafny";

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
  private invOrig: any = [];
  private inv: any = [];
  private error;

  constructor(
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
      this.invOrig = result;
      this.invOrig.forEach(b => {
        b.dateDonated = b.dateDonated.split(' ')[0];
        if (b.dateDonated.charAt(2) == '/') {
          let split = b.dateDonated.split('/');
          b.dateDonated = split[2] + '-' + split[0] + '-' + split[1];
        }
        b.bloodAge = (Date.now() - Date.parse(b.dateDonated)) / (1000*60*60*24) | 0;
      })
      this.filterInv();
    }, err => {
      this.error = err;
    });
  }

  page: number = 1;
  pageSize: number = 10;
  bloodGroup: string;
  rhesusFactor: string;
  minAge: number;
  maxAge: number;
  sortActive: string = "None";
  sortByField: any;
  sortDesc: boolean = false;

  get inventory(): Entry[] {
    if (!this.inv) return [];
    return this.inv
      .map(entry => this.cols
        .map(c => c.key) // Get keys of cols
        .reduce((e, k) => { e[k] = entry[k]; return e }, {})) // Remove unnecessary fields
      .slice((this.page - 1) * this.pageSize, (this.page - 1) * this.pageSize + this.pageSize);
  }

  sortType() {
    if (this.sortByField == sortByType) return;
    this.sortByField = sortByType;
    this.sortActive = "Type";
    this.sortInv();
  }
  sortAge() {
    if (this.sortByField == sortByDate) return;
    this.sortByField = sortByDate;
    this.sortActive = "Age";
    this.sortInv();
  }
  sortInv() {
    if (!this.sortByField) return;
    this.sortByField(this.inv, this.sortDesc);
    console.log(this.inv.length, this.invOrig.length);
  }

  filterInv() {
    if (this.bloodGroup && this.rhesusFactor) {
      this.inv = filterByType(this.invOrig, this.bloodGroup + this.rhesusFactor);
      if (this.minAge || this.maxAge) this.inv = filterByAge(this.inv, this.minAge, this.maxAge);
    } else if (this.minAge || this.maxAge)
      this.inv = filterByAge(this.invOrig, this.minAge, this.maxAge);
    else
      this.inv = this.invOrig.slice();
    this.sortInv();
  }

  resetInv() {
    this.bloodGroup = this.rhesusFactor = this.minAge = this.maxAge = undefined;
    this.filterInv();
  }

}
