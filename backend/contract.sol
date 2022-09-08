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

    // private function to create ducks and avoid other people creating ducks
    // _name stored in memory - if val changes in function, val of the original variable changes
    // parameter names start with underscore to differentiate from global variables (convention)
    function _createDuck (string memory _name, uint _data) private {
        ducks.push(Duck(_name, _data)); // add a new Duck(parameters) to the array
    }

    // private function that takes in a string to return a random dna number
    // view function since only viewing contract variables and not changing them
    function _generateRandomDna (string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str))); // typecast as uint before storing
        return rand % dnaMod; // DNA defined as 16 digits only
    }

    function _createRandomDuck (string memory _name) public {
        uint randomDna = _generateRandomDna(_name);
        _createDuck(_name, randomDna);
    }

}