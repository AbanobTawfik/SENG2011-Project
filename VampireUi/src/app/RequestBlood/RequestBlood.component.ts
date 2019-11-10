import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { first } from 'rxjs/operators';
import { Blood } from '../_models/Blood';
import { Request } from '../_models/request';

import { User } from '@/_models';
import { UserService, AuthenticationService } from '@/_services';

@Component({ templateUrl: 'RequestBlood.component.html' })
export class RequestBloodComponent {

	RequestBloodForm: FormGroup;
    newRequest: Request;
    requests: Array<Request>;

    constructor(
        private formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private router: Router,
        private authenticationService: AuthenticationService,
    ) {
    }

    ngOnInit() {
    	this.RequestBloodForm = this.formBuilder.group({
            destination: ['', Validators.required],
            amountRequired: ['', Validators.required],
            BloodType: ['', Validators.required],
        });

        this.requests = [];


    }
    get f() { return this.RequestBloodForm.controls; }


    SubmitAll() {


    	alert("Requests Submitted.");
    	console.log(this.requests[0].bloodType);
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
    		this.newRequest = new Request (this.f.destination.value, this.f.amountRequired.value, 
    			this.f.BloodType.value);
    		
    		this.requests.push(this.newRequest);
			console.log(this.requests.length);
    		// Do Something with it

    		this.RequestBloodForm = this.formBuilder.group({
            destination: ['', Validators.required],
            amountRequired: ['', Validators.required],
            BloodType: ['', Validators.required],
        });

    	}


    	

    	// Send this to Rest API


    }


    
}