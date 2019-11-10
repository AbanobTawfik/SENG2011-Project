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

@Component({ templateUrl: 'SearchBlood.component.html' })
export class SearchBloodComponent implements OnInit{
    SearchBloodForm: FormGroup;
    sortBy: String;
    bloodList: Array<Blood>;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private authenticationService: AuthenticationService,
    private http: HttpClient
  ) {}

  ngOnInit() {
    this.SearchBloodForm = this.formBuilder.group({
      DonorName: ["", Validators.required],
      Status: ["", Validators.required],
      BloodType: ["", Validators.required],
      DateDonated: ["", Validators.required],
      Location: ["", Validators.required],
      sortBy: ["", Validators.required],
    });
    this.sortBy = "";
    this.bloodList = [];
  }
  get f() {
    return this.SearchBloodForm.controls;
  }

  onSubmit() {

  	// TO DO - Get result from backend for blood satisfying Search Requirements
  	// Store into this.bloodList




  	// Displaying the bloodList Corrrectly per sort

    if (this.f.sortBy.value == "Donor Name") {

    } else if (this.f.sortBy.value == "Blood Id") {

    } else if (this.f.sortBy.value == "Blood Type") {

    } else if (this.f.sortBy.value == "Blood Status") {

    } else if (this.f.sortBy.value == "Date Donated") {

    } else if (this.f.sortBy.value == "Location") {

    }

  }
}