import { Component, OnInit } from "@angular/core";
import { Router, ActivatedRoute } from "@angular/router";
import { FormBuilder, FormGroup, Validators } from "@angular/forms";
import { first } from "rxjs/operators";
import { Blood } from "../_models/Blood";
import { Request } from "../_models/request";
import { HttpClient } from "@angular/common/http";
import { HttpHeaders } from "@angular/common/http";
import { User } from "@/_models";
import { UserService, AuthenticationService } from "@/_services";
import { environment } from "../../environments/environment";

@Component({ templateUrl: "RequestBlood.component.html" })
export class RequestBloodComponent {
  RequestBloodForm: FormGroup;
  newRequest: Request;
  requests: Array<Request>;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private authenticationService: AuthenticationService,
    private http: HttpClient
  ) {}

  ngOnInit() {
    this.RequestBloodForm = this.formBuilder.group({
      destination: ["", Validators.required],
      amountRequired: ["", Validators.required],
      BloodType: ["", Validators.required]
    });

    this.requests = [];
  }
  get f() {
    return this.RequestBloodForm.controls;
  }

  SubmitAll() {
    alert("Requests Submitted.");
    // console.log(this.requests[0].bloodType);
    // Do Something with it
    const httpOptions = {
      headers: new HttpHeaders({
        "Content-Type": "application/json",
        Authorization: "my-auth-token"
      })
    };
    var allrequest: any = [];
    for (var i = 0; i < this.requests.length; i++) {
      const real_request = {
        bloodType: this.requests[i].bloodType,
        volume: this.requests[i].numBloodBags
      };
      allrequest.push(real_request);
    }
    this.http
      .post(environment.apiBaseUrl + "Request/Blood", allrequest, httpOptions)
      .subscribe(result => {
        console.log(result);
        var r = result['item3'];

        if (r == "") {
          // Means that request was successfully filled 

        } else {
          alert(r);
        }
        this.requests = [];

      
      
      
      
      });
  }

  onSubmit() {
    if (this.f.destination.value == "") {
      alert("Destionation Required");
    } else if (this.f.amountRequired.value == "") {
      alert("Number of Blood Bags Required");
    } else if (this.f.BloodType.value == "") {
      alert("Blood Type Required");
    } else {
      // Add into blood Object
      console.log("Adding");
      console.log(this.f.amountRequired.value);
      this.newRequest = new Request(
        this.f.destination.value,
        this.f.amountRequired.value,
        this.f.BloodType.value
      );

      this.requests.push(this.newRequest);
      console.log(this.newRequest.bloodType);

      this.RequestBloodForm = this.formBuilder.group({
        destination: ["", Validators.required],
        amountRequired: ["", Validators.required],
        BloodType: ["", Validators.required]
      });
    }
  }
}
