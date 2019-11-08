import { Blood } from '../_models/Blood';

export class Request {

	destination: String;
	bloodBags: Array<Blood>;
    amountRequired: Number;
    bloodType: String;
    dateRequired: Date;

    constructor(destination: String, numBloodBags: Number, type: String, DateRequired: Date) {
    
    	this.destination = destination;
        this.amountRequired = numBloodBags;
        this.bloodType = type;
    	this.dateRequired = DateRequired;
    }

    public get Destination() : String {
        return this.destination;
    }

    public get AmountRequired() : Number {
        return this.amountRequired;
    }
}