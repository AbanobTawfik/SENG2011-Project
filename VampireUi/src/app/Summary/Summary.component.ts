﻿import { Component, OnInit } from "@angular/core";
import { Router, ActivatedRoute } from "@angular/router";
import { environment } from "../../environments/environment";
import { User } from "@/_models";
import { UserService, AuthenticationService } from "@/_services";
import { HttpClient } from "@angular/common/http";
import { HttpHeaders } from "@angular/common/http";

import { filterByType } from "../Dafny";

@Component({ templateUrl: "Summary.component.html" })
export class SummaryComponent implements OnInit {

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private authenticationService: AuthenticationService,
    private http: HttpClient
  ) {}

  public barChartOptions = {
    scales: {
      yAxes: [{
        id: 'A',
        type: 'linear',
        position: 'left',
        scaleLabel: {
          display: true,
          labelString: 'Quantity (bags)'
        },
        ticks: {
          beginAtZero: true
        }
      }, {
        id: 'B',
        type: 'linear',
        position: 'right',
        scaleLabel: {
          display: true,
          labelString: 'Frequency (%)'
        },
        ticks: {
          beginAtZero: true
        }
      }]
    },
    scaleShowVerticalLines: false,
    responsive: true
  };

  private error;
  private loading;

  public barChartLabels = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  public barChartType = 'bar';
  public barChartLegend = true;
  public barChartData = [
    {data: [0, 0, 0, 0, 0, 0, 0, 0], label: 'Supply levels', yAxisID: 'A'},
    {data: [31, 7, 8, 2, 2, 1, 40, 9], label: 'Expected frequency*', yAxisID: 'B'}
  ];

  ngOnInit() {
    this.loading = true;
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
      let inv = result;
      this.barChartData[0].data = this.barChartLabels.map((type) =>
        filterByType(inv, type).length
      )
      this.loading = false;
    }, err => {
      this.error = err;
      this.loading = false;
    });
  }
}
