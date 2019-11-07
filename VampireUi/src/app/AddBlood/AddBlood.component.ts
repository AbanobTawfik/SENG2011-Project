import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { first } from 'rxjs/operators';
import { Blood } from '../_models/Blood';

import { User } from '@/_models';
import { UserService, AuthenticationService } from '@/_services';

@Component({ templateUrl: 'AddBlood.component.html' })
export class AddBloodComponent implements OnInit{
    AddBloodForm: FormGroup;
    NewBlood: Blood;

    constructor(
        private formBuilder: FormBuilder,
        private route: ActivatedRoute,
        private router: Router,
        private authenticationService: AuthenticationService,
    ) {
    }

    ngOnInit() {
    	this.AddBloodForm = this.formBuilder.group({
            DonorName: ['', Validators.required],
            BloodId: ['', Validators.required],
            Status: ['', Validators.required],
            BloodType: ['', Validators.required],
            DateDonated: ['', Validators.required],
            Location: ['', Validators.required],
        });


    }
    get f() { return this.AddBloodForm.controls; }


    onSubmit() {
    	
    	if (this.f.DonorName.value == "") {
    		alert("DonorName Required");
    	} else if (this.f.BloodId.value == "") {
    		alert("Blood Id Required");
    	} else if (this.f.Status.value == "") {
    		alert("Blood Status Required");
    	} else if (this.f.BloodType.value == "") {
    		alert("Blood Type Required");
    	} else if (this.f.DateDonated.value == "") {
    		alert("Date Donated Required");
    	} else if (this.f.Location.value == "") {
    		alert("Donated Location Required");
    	} else {
    		// Add into blood Object
    		this.NewBlood = new Blood (this.f.DonorName.value, this.f.BloodId.value, 
    			this.f.Status.value, this.f.BloodType.value, this.f.DateDonated.value,
    		    this.f.Location.value);

    		// Do Something with it
    		alert("Submitted");
    	}


    	

    	// Send this to Rest API


    }



}