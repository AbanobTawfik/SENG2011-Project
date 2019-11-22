﻿import { Component, OnInit } from "@angular/core";
import { Router, ActivatedRoute } from "@angular/router";
import { environment } from "../../environments/environment";
import { User } from "@/_models";
import { UserService, AuthenticationService } from "@/_services";
import { HttpClient } from "@angular/common/http";
import { HttpHeaders } from "@angular/common/http";

import { filterByType, filterByAge } from "../Dafny";

@Component({ templateUrl: "Summary.component.html" })
export class SummaryComponent implements OnInit {

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private authenticationService: AuthenticationService,
    private http: HttpClient
  ) {}

  public barChartLabels = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  public barChartType = 'bar';
  public barChartLegend = true;
  public barChartData = [
    {data: [0, 0, 0, 0, 0, 0, 0, 0], label: 'Supply levels', yAxisID: 'A'},
    {data: [31, 7, 8, 2, 2, 1, 40, 9], label: 'Expected frequency*', yAxisID: 'B'}
  ];
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

  private lineChartSize = 5;
  private lineChartMax = 42;
  public lineChartLabels = [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, '42+'];
  public lineChartType = 'line';
  public lineChartLegend = true;
  public lineChartData = [
    {data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], label: 'Supply levels', yAxisID: 'A'}
  ];
  public lineChartOptions = {
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
      }]
    }
  }

  private error;
  private loadingBar;
  private loadingLine;

  ngOnInit() {
    this.loadingBar = this.loadingLine = true;
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
      this.barChartData[0].data = this.barChartLabels.map((type) =>
        filterByType(result, type).length
      )
      this.loadingBar = false;
      setTimeout(() => {
        this.lineChartData[0].data = this.lineChartLabels.map((age) =>
          (typeof age === "string") ?
            filterByAge(result, this.lineChartMax, undefined).length :
            filterByAge(result, age, age + this.lineChartSize - 1).length
        )
        this.loadingLine = false;
      }, 400);
    }, err => {
      this.error = err;
      this.loadingBar = this.loadingLine = false;
    });
  }
}
