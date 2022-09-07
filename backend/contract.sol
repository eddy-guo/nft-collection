// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract duckFactory {
    uint dnaValue = 16; // Duck DNA determined by 16 digit number
    uint dnaMod = 10**16; // used in future to mod (%) numbers down to 16 digits
}