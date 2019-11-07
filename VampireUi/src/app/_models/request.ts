import { Blood } from '../_models/Blood';

export class Request {

	destination: String;
	bloodBags: Array<Blood>;
    numBloodBags: Number;
    bloodType: String;
    dateRequired: Date;

    constructor(destination: String, BloodBags: Array<Blood>, numBloodBags: Number, DateRequired: Date) {
    
    	this.destination = destination;
    	this.bloodBags = BloodBags;
    	this.numBloodBags = numBloodBags;
    	this.dateRequired = DateRequired;
    }
}