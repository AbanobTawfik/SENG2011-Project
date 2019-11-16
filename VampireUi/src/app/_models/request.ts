import { Blood } from '../_models/Blood';

export class Request {

	destination: String;
	// bloodBags: Array<Blood>;
    numBloodBags: Number;
    bloodType: String;

    constructor(destination: String, numBloodBags: Number, bloodType: String) {
    
    	this.destination = destination;
    	// this.bloodBags = BloodBags;
		this.numBloodBags = numBloodBags;
		this.bloodType = bloodType;
    }
}