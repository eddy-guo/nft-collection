// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./duckfactory.sol";

contract DuckFeeding is duckFactory {
    function feedAndMultiply (uint _duckId, uint _targetDna) public {
        require(msg.sender == duckToOwner[_duckId]);
        Duck storage myDuck = ducks[_duckId];
        _targetDna = _targetDna % dnaMod;
        uint newDna = (myDuck.dna + _targetDna) / 2;
        _createDuck("tempName", newDna);
    }
}