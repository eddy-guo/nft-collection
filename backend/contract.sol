// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract duckFactory {
    uint dnaValue = 16; // Duck DNA determined by 16 digit number
    uint dnaMod = 10**16; // used in future to mod (%) numbers down to 16 digits

    // struct to represent a duck with multiple properties
    struct Duck {
        string name;
        uint dna;
    }

    // public dynamic array to store a raft of ducks :)
    Duck[] public ducks;

    // public function to create ducks
    // _name stored in memory - if val changes in function, val of the original variable changes
    // parameter names start with underscore to differentiate from global variables (convention)
    function createDuck (string memory _name, uint _data) public {
        ducks.push(Duck(_name, _data)); // add a new Duck(parameters) to the array
    }
    
}