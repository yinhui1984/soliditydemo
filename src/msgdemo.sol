// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;


contract MsgDemo {

    function GetSender() public view  returns (address) {
        return msg.sender;
    }

    function GetOrigin() public view returns (address){
        return tx.origin;
    }

    function IsCallerEOA() public view returns (bool){
        return msg.sender == tx.origin;
    }

    function GetMsgData() public payable  returns (bytes memory){
        return msg.data;
    }

    function GetMsgData2(int256 i) public payable  returns (bytes memory){
        return msg.data;
    }


    receive() external payable {}
}