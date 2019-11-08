export class Blood {

	donorName: String;
	bloodtype: String;
	status: String;
	dateDonated: string;
    location: String;

    constructor(name: String, status: String, type: String,
    	dateDonatedOn: string, donatedAt: String) {
    
    	this.donorName = name;
    	this.bloodtype = type;
    	this.status = status;
    	this.dateDonated = dateDonatedOn;
    	this.location = donatedAt;

    }
}