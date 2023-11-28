// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/arraydemo.sol";

contract ArrayDemoTest is Test {
    ArrayDemo ad;

    function setUp() public {
        vm.createSelectFork("theNet");

        ad = new ArrayDemo();
    }

    function testGetFixedArray() public view {
        uint[3] memory arr = ad.GetFixedArray();
        console2.logUint(arr[0]);
        console2.logUint(arr[1]);
        console2.logUint(arr[2]);
    }

    function testModifyFixedArray() public {
        ad.ModifyFixedArray(0, 100);
        ad.ModifyFixedArray(1, 200);
        ad.ModifyFixedArray(2, 300);
        uint[3] memory arr = ad.GetFixedArray();
        console2.logUint(arr[0]);
        console2.logUint(arr[1]);
        console2.logUint(arr[2]);

        assertEq(arr[0], 100);
        assertEq(arr[1], 200);
        assertEq(arr[2], 300);
    }

    function testDeleteFixedArray() public {
        ad.DeleteFixedArray();
        uint[3] memory arr = ad.GetFixedArray();
        console2.logUint(arr[0]);
        console2.logUint(arr[1]);
        console2.logUint(arr[2]);

        assertEq(arr[0], 0);
        assertEq(arr[1], 0);
        assertEq(arr[2], 0);
    }

    function testGetDynamicArray() public view {
        uint[] memory arr = ad.GetDynamicArray();
        console2.logUint(arr[0]);
        console2.logUint(arr[1]);
        console2.logUint(arr[2]);
    }

    function testDeleteDynamicArray() public {
        ad.DeleteDynamicArray();
        uint[] memory arr = ad.GetDynamicArray();
        assertEq(arr.length, 0, "length should be 0");
    }

    function testPopFromDynamicArray() public {
        ad.PopFromDynamicArray();
        uint[] memory arr = ad.GetDynamicArray();
        assertEq(arr.length, 2, "length should be 2");
    }

    function testPushToDynamicArray() public {
        ad.PushToDynamicArray(1000);
        uint[] memory arr = ad.GetDynamicArray();
        assertEq(arr.length, 4, "length should be 4");
        assertEq(arr[3], 1000, "last element should be 1000");
    }

    function testSliceFromDynamicArray() public {
        uint[] memory arr = ad.SliceFromDynamicArray(1, 3);
        assertEq(arr.length, 2, "length should be 2");
        assertEq(arr[0], 99, "first element should be 99");
        assertEq(arr[1], 999, "second element should be 999");
    }
}
