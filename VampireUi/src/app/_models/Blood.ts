export class Blood {

	donorName: String;
	id: String;
	bloodtype: String;
	status: String;
	dateDonated: Date;
    location: String;

    constructor(name: String, id: String, status: String, type: String,
    	dateDonatedOn: Date, donatedAt: String) {
    
    	this.donorName = name;
    	this.id = id;
    	this.bloodtype = type;
    	this.status = status;
    	this.dateDonated = dateDonatedOn;
    	this.location = donatedAt;

    }
}