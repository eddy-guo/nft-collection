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

    // private function to create ducks and avoid other people creating ducks
    // _name stored in memory - if val changes in function, val of the original variable changes
    // parameter names start with underscore to differentiate from global variables (convention)
    function _createDuck (string memory _name, uint _dna) private {
        ducks.push(Duck(_name, _dna)); // add a new Duck to the array
        uint id = ducks.length - 1; // store the ducks' id
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
        uint randomDna = _generateRandomDna(_name);
        _createDuck(_name, randomDna);
    }

}