// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;


import "forge-std/Test.sol";

import "../src/receivce_fallback_demo.sol";


contract FallbackDemoTest is Test {
    FallbackDemo fbd;

    function setUp() public {
        vm.createSelectFork("theNet");

        fbd = new FallbackDemo();
        vm.deal(address(this), 100 ether);
    }

    function test1() public {
        fbd.Hello();
        console2.logString(fbd.LastCalledFuncationName());
        assertTrue(keccak256(abi.encodePacked(fbd.LastCalledFuncationName())) == keccak256(abi.encodePacked("Hello")));
    }

    function testFailFallback1() public{
        address payable addr = payable(fbd);
        addr.transfer(1 ether);
    }
    // function testFailFallback2() public{
    //     address payable addr = payable(fbd);
    //     bool ok = addr.send(1 ether);
    //     console2.logBool(ok);
    // }

    function  testFallback3() public{
        address payable addr = payable(fbd);
        (bool ok,) = addr.call{value: 1 ether}("");
        console2.logBool(ok);
        assertTrue(ok);
        console2.logString(fbd.LastCalledFuncationName());
        assertTrue(keccak256(abi.encodePacked(fbd.LastCalledFuncationName())) == keccak256(abi.encodePacked("fallback")));
    }
}

contract ReceiverDemoTest is Test{
    ReceiverDemo rd;

    function setUp() public {
        vm.createSelectFork("theNet");

        rd = new ReceiverDemo();
        vm.deal(address(this), 100 ether);
    }

    function test1() public {
        rd.Hello();
        console2.logString(rd.LastCalledFuncationName());
        assertTrue(keccak256(abi.encodePacked(rd.LastCalledFuncationName())) == keccak256(abi.encodePacked("Hello")));
    }

    function testFailReceive1() public{
        address payable addr = payable(rd);
        addr.transfer(1 ether);
       
    }

    // function testFailReceive2() public{
    //     address payable addr = payable(rd);
        
    //     bool ok = addr.send(1 ether);
    //     console2.logBool(ok);
    // }

    function testReceive3() public{
        address payable addr = payable(rd);
        (bool ok,) = addr.call{value: 1 ether}("");
        console2.logBool(ok);
        assertTrue(ok);
        console2.logString(rd.LastCalledFuncationName());
        assertTrue(keccak256(abi.encodePacked(rd.LastCalledFuncationName())) == keccak256(abi.encodePacked("receive")));
    }
}

contract FallbackReceiveDemoTest is Test{
    FallbackReceiveDemo frd;

    function setUp() public {
        vm.createSelectFork("theNet");

        frd = new FallbackReceiveDemo();
        vm.deal(address(this), 100 ether);
    }

    function test1() public {
        frd.Hello();
        console2.logString(frd.LastCalledFuncationName());
        assertTrue(keccak256(abi.encodePacked(frd.LastCalledFuncationName())) == keccak256(abi.encodePacked("Hello")));
    }

    function testF1() public{
        address payable addr = payable(frd);
        (bool ok,) = addr.call{value: 1 ether}("");
        console2.logBool(ok);
        assertTrue(ok);
        console2.logString(frd.LastCalledFuncationName());
        assertTrue(keccak256(abi.encodePacked(frd.LastCalledFuncationName())) == keccak256(abi.encodePacked("receive")));
    }

    function testF2() public{
         address payable addr = payable(frd);
        (bool ok,) = addr.call{value: 1 ether}(abi.encodeWithSignature("Hello()"));
        console2.logBool(ok);
        assertTrue(ok);
        console2.logString(frd.LastCalledFuncationName());
        assertTrue(keccak256(abi.encodePacked(frd.LastCalledFuncationName())) == keccak256(abi.encodePacked("Hello")));
    }

    function testF3() public{
         address payable addr = payable(frd);
        (bool ok,) = addr.call{value: 1 ether}(abi.encodeWithSignature("XXX()"));
        console2.logBool(ok);
        assertTrue(ok);
        console2.logString(frd.LastCalledFuncationName());
        assertTrue(keccak256(abi.encodePacked(frd.LastCalledFuncationName())) == keccak256(abi.encodePacked("fallback")));
    }

    function testFail4() public{
         address payable addr = payable(frd);
         addr.transfer(1 ether);
    }

}