// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/msgdemo.sol";

contract MsgDemoTest is Test {
    MsgDemo md;

    function setUp() public {
        vm.createSelectFork("theNet");
        md = new MsgDemo();
    }

    function testSender() public {
        assertTrue(address(this) == md.GetSender());
    }

    function testSender2() public {
        (address alice, ) = makeAddrAndKey("alice");
        vm.startPrank(alice);
        assertTrue(alice == md.GetSender());
        vm.stopPrank();
        assertTrue(address(this) == md.GetSender());
    }

    function testOrigin() public {
        address origin0 = tx.origin;
        address origin = md.GetOrigin();
        console2.logAddress(origin0);
        console2.logAddress(origin);
        console2.logAddress(address(this));
        assertTrue(origin0 == origin);
    }

    function testOrigin2() public {
        (address alice, ) = makeAddrAndKey("alice");
        vm.startPrank(alice);
        address origin = md.GetOrigin();
        vm.stopPrank();
        assertTrue(origin != alice);
    }

    function testIsCallerEOA() public {
        assertFalse(md.IsCallerEOA());
        (address alice, ) = makeAddrAndKey("alice");
        vm.startPrank(alice);
        console2.logAddress(alice);
        console2.logAddress(md.GetSender());
        console2.logAddress(md.GetOrigin());
        assertFalse(md.IsCallerEOA());
        vm.stopPrank();
    }

    function testGetMsgData() public {
        bytes memory data = md.GetMsgData();
        console2.logBytes(data);
        bytes memory sig = abi.encodeWithSignature("GetMsgData()");
        console2.logBytes(sig);
        assertTrue(keccak256(data) == keccak256(sig));

        vm.deal(address(this), 100);
        (bool ok, bytes memory data2) = (address(md)).call{value:100, gas:50000 }(abi.encodeWithSignature("GetMsgData()"));
        assertTrue(ok);
        console2.logBytes(data2);
    }

    function testGetMsgData2() public{
        bytes memory data = md.GetMsgData2(1);
        console2.logBytes(data);
        bytes memory sig = abi.encodeWithSignature("GetMsgData2(int256)", 1);
        console2.logBytes(sig);
        assertTrue(keccak256(data) == keccak256(sig));

        vm.deal(address(this), 100);
        (bool ok, bytes memory data2) = (address(md)).call{value:100, gas:50000 }(abi.encodeWithSignature("GetMsgData2(int256)", 1));
        assertTrue(ok);
        console2.logBytes(data2);
    }
}
