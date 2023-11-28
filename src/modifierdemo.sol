// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;


contract ModifierDemo {

    address payable public owner;
    constructor() payable {
        owner = payable(msg.sender);
    }

    modifier OnlyOwner {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    function withdraw() public OnlyOwner {
        owner.transfer(address(this).balance);
    }

    receive() external payable {
    }

}


contract ModifierWithNoReentrancyDemo {

    mapping (address => uint) private balances;
    bool private locked;


    function deposit() public payable  {
        balances[msg.sender] += msg.value;
    }

    modifier NoReentrancy {
        require(!locked, "Reentrancy detected.");
        locked = true;
        _;
        locked = false;
    }

    function withdraw() public NoReentrancy {
        uint amount = balances[msg.sender];
        require(amount > 0, "Insufficient balance.");
        balances[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
        
    }

    function getIsLocked() public view returns (bool) {
        return locked;
    }

    
    receive() external payable {
        
    }

}