// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

contract ThisDemo {

    string private greetings;
    constructor(string memory _greetings) {
        // syntax error, "this" can not access private member
        //this.greetings = _greetings;
        greetings = _greetings;
    }

 

    function Hello() public view returns (string memory) {
        return greetings;
    }
}