// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./duckfactory.sol";

abstract contract KittyInterface {
    // function taken from cryptokitty contract
        // why error thrown when not declared as virtual? all functions in interfaces treated as virtual??
    function getKitty(uint256 _id) virtual external view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract DuckFeeding is duckFactory {

    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract  = KittyInterface(ckAddress);

    // multiply duck function - owner's duck with a target duck
    function feedAndMultiply (uint _duckId, uint _targetDna) public {
        require(msg.sender == duckToOwner[_duckId]); // need to own duck to multiply
        Duck storage myDuck = ducks[_duckId]; // store current duck locally using storage keyword
        _targetDna = _targetDna % dnaMod; // confirm that targetDna is correct # of digits
        uint newDna = (myDuck.dna + _targetDna) / 2; // take average of the dna's
        // access properties (ie dna) of any duck using "."
        _createDuck("tempName", newDna);
    }

    function feedOnKitty (uint _duckId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_duckId, kittyDna);
    }
}