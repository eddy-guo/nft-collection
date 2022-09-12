// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./duckfactory.sol";

// interface to interact with other contracts (cryptokitty in this case)
abstract contract KittyInterface {
    // function taken from cryptokitty contract
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

    // initialize KittyInterface contract to have cryptokitty contract interact with DuckFeeding
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract  = KittyInterface(ckAddress);

    // multiply duck function - owner's duck with a target duck
    function feedAndMultiply (uint _duckId, uint _targetDna, string memory _species) public {
        require(msg.sender == duckToOwner[_duckId]); // need to own duck to multiply
        Duck storage myDuck = ducks[_duckId]; // store current duck locally using storage keyword
        _targetDna = _targetDna % dnaMod; // confirm that targetDna is correct # of digits
        uint newDna = (myDuck.dna + _targetDna) / 2; // take average of the dna's
        // change dna if duck+kitty species
        if (keccak256(abi.encodePacked(_species)) ==  keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - newDna % 100 + 99;
        }
        // access properties (ie dna) of any duck using "."
        _createDuck("tempName", newDna);
    }

    // duck+kitty; get kitty genes from contract to eventually feedandmultiply
    function feedOnKitty (uint _duckId, uint _kittyId) public {
        uint kittyDna; // declaration
        /* 
        kittyDna in place of "genes", all other returned parameters are ignored
        finds kitty from cryptokitty contract (_kittyId), store gene value in kittyDna
        */ 
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); // important syntax
        feedAndMultiply(_duckId, kittyDna, "kitty");
    }
}