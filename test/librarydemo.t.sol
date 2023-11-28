// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

import "forge-std/Test.sol";

import "../src/librarydemo.sol";

contract StringLibraryDemoTest is Test {
    function testSlice() public {
        string memory str = "hello world";
        string memory slice = StringLibrary.Slice(str, 0, 5);
        console2.logString(slice);
        assertTrue(
            keccak256(abi.encodePacked(slice)) ==
                keccak256(abi.encodePacked("hello"))
        );
    }
}

contract ArrayLibraryDemoTest is Test {
    function testSlice() public {
        uint[] memory arr = new uint[](10);
        for (uint i = 0; i < 10; i++) {
            arr[i] = i;
        }
        uint[] memory slice = ArrayLibrary.Slice(arr, 0, 5);
        assertTrue(slice.length == 5);
        for (uint i = 0; i < 5; i++) {
            assertTrue(slice[i] == i);
        }
    }
}
