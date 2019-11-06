import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { first } from 'rxjs/operators';
import { Blood } from '../_models/Blood';

import { User } from '@/_models';
import { UserService, AuthenticationService } from '@/_services';

@Component({ templateUrl: 'AddBlood.component.html' })
export class AddBloodComponent {
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
            password: ['', Validators.required]
        });


    }
    get f() { return this.AddBloodForm.controls; }


    onSubmit() {

    	alert("Submitted");
    	// print(this.AddBloodForm.controls.DonorName.valid);
    	// Add into Blood Object
    }



}