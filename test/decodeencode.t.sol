// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/decodeencode.sol";

contract Hack is Test {
    EncodeExample en;
    DecodeExample de;
    People people;

    function setUp() public {
        vm.createSelectFork("theNet");
        en = new EncodeExample();
        de = new DecodeExample();
        people = People("bob", 42);
    }

    function testString() public {
        bytes memory encoded = en.EncodeString("hello");
        string memory decoded = de.DecodeString(encoded);
        console2.log(decoded);
        assertEq(decoded, "hello");
    }

    function testBytes() public {
        bytes memory encoded = en.EncodeBytes("hello");
        string memory decoded = de.DecodeString(encoded);
        console2.log(decoded);
        assertEq(decoded, "hello");
    }

    function testStruct() public {
        bytes memory encoded = en.EncodeStruct(people);
        People memory decoded = de.DecodeStruct(encoded);
        console2.log(decoded.name);
        console2.log(decoded.age);
        assertEq(decoded.name, people.name);
        assertEq(decoded.age, people.age);
    }

    function testCall() public {
        bytes memory encoded = en.EncodeCallAdd();
        console2.logBytes(encoded);
        bytes memory b = abi.encodeWithSignature("Add(uint256,uint256)", 1, 2);
        console2.logBytes(b);
        assertEq(encoded, b);

        bytes memory b1 = abi.encodeWithSignature(
            "Add(uint256, uint256)", // 多了一个空格
            1,
            2
        );
        console2.logBytes(b1);
        string memory s = vm.toString(b);
        string memory s1 = vm.toString(b1);
        assertFalse(
            keccak256(abi.encodePacked(s)) == keccak256(abi.encodePacked(s1))
        );

        bytes memory c = abi.encodeWithSelector(en.Add.selector, 1, 2);
        console2.logBytes(c);
        assertEq(encoded, c);

        (bool success, bytes memory ret) = address(en).staticcall(encoded);
        assertEq(success, true);
        uint sum = abi.decode(ret, (uint256));
        console2.log(sum);
        assertEq(sum, 3);
    }

    function testPackedHelloWorld() public {
        bytes memory encoded = en.EncodePackedHelloWorld();
        console2.logBytes(encoded);
        (string memory a, string memory b) = de.DecodePackedHelloWorld(encoded);
        console2.log(a, b);
        assertEq(a, "hello");
        assertEq(b, "world");
    }
}
