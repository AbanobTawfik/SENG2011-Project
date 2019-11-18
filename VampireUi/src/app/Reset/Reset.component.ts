﻿import { Component, OnInit } from "@angular/core";
import { HttpClient } from "@angular/common/http";
import { HttpHeaders } from "@angular/common/http";
import { environment } from "../../environments/environment";

@Component({ templateUrl: "Reset.component.html" })
export class ResetComponent implements OnInit {

  constructor(
    private http: HttpClient
  ) {}

  private error;
  private loading;

  ngOnInit() {
    this.loading = true;
    const httpOptions = {
      headers: new HttpHeaders({
        "Content-Type": "application/json",
        "Authorization": "my-auth-token"
      })
    };
    this.http.post(
      environment.apiBaseUrl + "BloodInventory/ResetDb",
      httpOptions
    )
    .subscribe(result => {
      this.loading = false;
    }, err => {
      this.error = err;
      this.loading = false;
    });
  }
}
