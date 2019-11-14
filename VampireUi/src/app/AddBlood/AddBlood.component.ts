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

@Component({ templateUrl: "AddBlood.component.html" })
export class AddBloodComponent implements OnInit {
  AddBloodForm: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private authenticationService: AuthenticationService,
    private http: HttpClient
  ) {}

  ngOnInit() {
    this.AddBloodForm = this.formBuilder.group({
      DonorName: ["", Validators.required],
      Status: ["", Validators.required],
      BloodType: ["", Validators.required],
      DateDonated: ["", Validators.required],
      Location: ["", Validators.required]
    });
  }
  get f() {
    return this.AddBloodForm.controls;
  }


  alertSubmitted(result) {
    console.log(result);
    alert("Added Blood to Inventory.");
    
  }

  onSubmit() {
    if (this.f.DonorName.value == "") {
      alert("DonorName Required");
    } else if (this.f.Status.value == "") {
      alert("Blood Status Required");
    } else if (this.f.BloodType.value == "") {
      alert("Blood Type Required");
    } else if (this.f.DateDonated.value == "") {
      alert("Date Donated Required");
    } else if (this.f.Location.value == "") {
      alert("Donated Location Required");
    } else {
      const httpOptions = {
        headers: new HttpHeaders({
          "Content-Type": "application/json",
          Authorization: "my-auth-token"
        })
      };

      const newBlood: any = {
        donorName: this.f.DonorName.value,
        bloodType: this.f.BloodType.value,
        bloodStatus: this.f.Status.value,
        dateDonated: this.f.DateDonated.value,
        locationAcquired: this.f.Location.value
      };

      // Error
      console.log(newBlood);
      this.http
        .post(
          environment.apiBaseUrl + "BloodInventory/AddBlood",
          newBlood,
          httpOptions
        )
        .subscribe(result => this.alertSubmitted(result));

      // Do Something with it
      //alert("Submitted");
    }

    // Send this to Rest API
  }
}
