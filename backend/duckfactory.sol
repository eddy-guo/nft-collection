// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract duckFactory {

    event NewDuck(uint duckId, string name, uint dna); // event declaration

    uint dnaValue = 16; // Duck DNA determined by 16 digit number
    uint dnaMod = 10**16; // used in future to mod (%) numbers down to 16 digits

    // struct to represent a duck with multiple properties
    struct Duck {
        string name;
        uint dna;
    }

    // public dynamic array to store a raft of ducks :)
    Duck[] public ducks;

    // mappings: duck to owner, owner to duck count (similar to kvp)
    mapping (uint => address) public duckToOwner;
    mapping (address => uint) ownerDuckCount;
    
    // internal function to create ducks and avoid other people creating ducks
        // but allows other contracts to access in case multiplying nfts
    // _name stored in memory - if val changes in function, val of the original variable changes
    // parameter names start with underscore to differentiate from global variables (convention)
    function _createDuck (string memory _name, uint _dna) internal {
        ducks.push(Duck(_name, _dna)); // add a new Duck to the array
        uint id = ducks.length - 1; // store the ducks' id
        duckToOwner[id] = msg.sender; // map id of duck to address that called create function
        ownerDuckCount[msg.sender]++; // add 1 to total # of ducks the caller has
        emit NewDuck(id, _name, _dna); // emit event here, FE app can listen to emitted event
    }

    // private function that takes in a string to return a random dna number
    // view function since only viewing contract variables and not changing them
    function _generateRandomDna (string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str))); // typecast as uint before storing
        return rand % dnaMod; // DNA defined as 16 digits only
    }

    // public function that creates random duck - name generates unique dna, create duck!
    function _createRandomDuck (string memory _name) public {
        require(ownerDuckCount[msg.sender] == 0); // one duck per person!
        uint randomDna = _generateRandomDna(_name); // create random dna with string parameter
        _createDuck(_name, randomDna); // create duck
    }
 
}