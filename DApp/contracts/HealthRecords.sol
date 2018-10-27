pragma solidity ^0.4.18;

contract HealthRecords{
	struct Contact {
		//Javascript object
			// default values for each of the properties
			// in Javascript you put the properties and the values for an object
			// In solidity a struct just get the properties (can only set the keys not the values)
		string symptoms;
		string medications;
		string allergies;
		uint weight;
		uint height;
	}
	// a struct and everything inside it is not acessible

	// 2 ways to store structs
		// 1. mapping
			// the struct in the mapping has to be the second thing in the mapping (value)
		// 2. array 
			// you can have an array of structs


	//keeping track of the next contact id
	uint public nextContactNum; 
	//uint is an alias for uint256. it defaults to 0. the highest it goes up to is 2^256-1

	//data structure that maps one data type to another, generally one maps uint, address or bytes32 to another data structure
	mapping (uint => Contact) contacts;
		// initializing the mapping
		// key: value pairs 
			// where key = num from 0 to (2^ 256) -1 becuase uint = uint256
		// contacts is name for the mapping


	function newContact(string _symptoms, string _medications, string _allergies, uint _weight, uint _height) external returns (uint contactID) {

		require( (bytes(_symptoms).length <= 50) && (bytes(_medications).length <= 50) && (bytes(_allergies).length <= 50));


	    contactID = nextContactNum++; // contactID is return variable

	    // Creates new struct and saves in storage. We leave out the mapping type.
	    contacts[contactID] = Contact(_symptoms, _medications, _allergies, _weight, _height);

	    // return contactID; // contactID is not returned in javascript
	    return contactID;
	}

	//external means that this can only be called outside the contract
	//view means that the function accesses state but doesn't change it
	//last argument returns _work_address, _notes, _email_address concat'd together to avoid stack too deep error
	function getContact(uint contactID) view external returns (string _symptoms, string _medications, string _allergies, uint _weight, uint _height) {
	    require(contactID < nextContactNum);
	    Contact memory con = contacts[contactID];

	    return (con.symptoms, con.medications, con.allergies, con.weight, con.height);
	}

	function updateContact(uint contactID, string _symptoms, string _medications, string _allergies, uint _weight, uint _height) external {
		Contact storage con = contacts[contactID];

		con.symptoms = _symptoms;
		con.medications = _medications;
		con.allergies = _allergies;
		con.weight = _weight;
		con.height = _height;

	}
}