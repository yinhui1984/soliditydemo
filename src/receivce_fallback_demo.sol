// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

contract FallbackDemo{
    string public lastCalledFuncationName;

    function LastCalledFuncationName() public view returns (string memory) {
        return lastCalledFuncationName;
    }

    fallback() external payable {
        // 如果使用transfer和send进行转账，会导致fallback函数失败
        // 原因： transfer和send只有2300gas，不足以执行这里的字段赋值操作
       lastCalledFuncationName = "fallback";
    }

    function Hello() public payable {
        lastCalledFuncationName = "Hello";
    }
}

contract ReceiverDemo{
    string public lastCalledFuncationName;

    function LastCalledFuncationName() public view returns (string memory) {
        return lastCalledFuncationName;
    }

    receive() external payable {
        lastCalledFuncationName = "receive";
    }

    function Hello() public payable {
        lastCalledFuncationName = "Hello";
    }
}


contract FallbackReceiveDemo{
    string public lastCalledFuncationName;

    function LastCalledFuncationName() public view returns (string memory) {
        return lastCalledFuncationName;
    }

    fallback() external payable {
        lastCalledFuncationName = "fallback";
    }

    receive() external payable {
        lastCalledFuncationName = "receive";
    }

    function Hello() public payable {
        lastCalledFuncationName = "Hello";
    }
}