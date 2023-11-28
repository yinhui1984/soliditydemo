// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/stringdemo.sol";

contract StringDemoTest is Test {
    StringDemo sd;

    function setUp() public {
        vm.createSelectFork("theNet");
        sd = new StringDemo();
    }

    function testConcatString() public {
        string memory s = sd.ConcatString("hello", "world");
        console2.log(s);
        assertEq(s, "helloworld");
    }

    function testGetLength() public {
        uint len = sd.GetLength("hello");
        console2.logUint(len);
        assertEq(len, 5);
    }

    function testCompare() public {
        bool b = sd.Compare("hello", "hello");
        assertEq(b, true);

        b = sd.Compare2("hello", "hello");
        assertEq(b, true);

        b = sd.Compare3("hello", "hello");
        assertEq(b, true);

        b = sd.Compare("hello", "world");
        assertEq(b, false);

        b = sd.Compare2("hello", "world");
        assertEq(b, false);

        b = sd.Compare3("hello", "world");
        assertEq(b, false);
    }

    function testSubString() public {
        string memory s = sd.SubString("hello", 0, 2);
        console2.log(s);
        assertEq(s, "he");

        s = sd.SubString("hello", 1, 3);
        console2.log(s);
        assertEq(s, "el");

        s = sd.SubString("hello", 1, 4);
        console2.log(s);
        assertEq(s, "ell");

        s = sd.SubString("hello", 1, 5);
        console2.log(s);
        assertEq(s, "ello");

        s = sd.SubString("hello", 1, 6);
        console2.log(s);
        assertEq(s, "ello");

        // s = sd.SubString("hello", 1, 1);
        // console2.log(s);
        // assertEq(s, "");

        // s = sd.SubString("hello", 1, 0);
        // console2.log(s);
        // assertEq(s, "");
    }

    function testStringToInt() public {
        int u = sd.StringToInt("123");
        console2.logInt(u);
        assertEq(u, 123);

        u = sd.StringToInt("-123");
        console2.logInt(u);
        assertEq(u, -123);
    }

    function testIntToString() public {
        string memory s = sd.IntToString(123);
        console2.log(s);
        assertEq(s, "123");

        s = sd.IntToString(-123);
        console2.log(s);
        assertEq(s, "-123");
    }
}
