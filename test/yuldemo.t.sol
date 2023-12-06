// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/yuldemo.sol";

contract YulDemoTest is DSTest {
    YulDemoContract demo;

    function setUp() public {
        demo = new YulDemoContract();
    }

    function testStop() public view {
        demo.Stop();
    }

    function testAdd() public {
        // 正常
        uint256 result = demo.Add(1, 2);
        assertTrue(result == 3, "result should be 3");

        // 溢出
        result = demo.Add(
            0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
            1
        );
        console2.logUint(result);
        assertTrue(result == 0, "result should be 0");

        result = demo.Add(
            0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
            2
        );
        console2.logUint(result);
        assertTrue(result == 1, "result should be 1");
    }

    function testSub() public {
        // 正常
        uint256 result = demo.Sub(3, 2);
        assertTrue(result == 1, "result should be 1");

        // 溢出
        result = demo.Sub(1, 2);
        console2.logUint(result);
        assertTrue(
            result ==
                0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
            "result should be 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
        );
    }

    function testMul() public {
        // 正常
        uint256 result = demo.Mul(3, 2);
        assertTrue(result == 6, "result should be 6");

        // 溢出
        result = demo.Mul(
            0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
            2
        );
        console2.logUint(result);
        assertTrue(
            result <
                0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
            "result should be less than 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
        );
    }

    function testDiv() public {
        // 正常
        uint256 result = demo.Div(6, 2);
        assertTrue(result == 3, "result should be 3");

        // 向下取整
        result = demo.Div(5, 2);
        assertTrue(result == 2, "result should be 2");
    }

    function testDiv0() public view {
        // 除数为0, 返回0
        uint256 result = demo.Div(6, 0);
        console2.logUint(result);
    }

    function testSdiv() public {
        // 正常
        int256 result = demo.Sdiv(6, 2);
        assertTrue(result == 3, "result should be 3");

        // 向下取整
        result = demo.Sdiv(5, 2);
        assertTrue(result == 2, "result should be 2");

        // 负数
        result = demo.Sdiv(-5, 2);
        assertTrue(result == -2, "result should be -2");
    }

    function testSdiv0() public {
        // 除数为0, 返回0
        int256 result = demo.Sdiv(6, 0);
        assertTrue(result == 0, "result should be 0");
    }

    function testMod() public {
        uint256 result = demo.Mod(6, 2);
        assertTrue(result == 0, "result should be 0");

        result = demo.Mod(5, 2);
        assertTrue(result == 1, "result should be 1");
    }

    function testMod0() public {
        // 除数为0, 返回0
        uint256 result = demo.Mod(6, 0);
        assertTrue(result == 0, "result should be 0");
    }

    function testSmod() public {
        int256 result = demo.Smod(6, 2);
        assertTrue(result == 0, "result should be 0");

        result = demo.Smod(5, 2);
        assertTrue(result == 1, "result should be 1");

        result = demo.Smod(-5, 2);
        assertTrue(result == -1, "result should be -1");

        result = demo.Smod(-5, -2);
        assertTrue(result == -1, "result should be -1");

        result = demo.Smod(5, -2);
        assertTrue(result == 1, "result should be 1");
    }

    function testSmod0() public {
        // 除数为0, 返回0
        int256 result = demo.Smod(6, 0);
        assertTrue(result == 0, "result should be 0");
    }

    function testExp() public {
        uint256 result = demo.Exp(2, 3);
        assertTrue(result == 8, "result should be 8");

        result = demo.Exp(2, 0);
        assertTrue(result == 1, "result should be 1");

        result = demo.Exp(2, 1);
        assertTrue(result == 2, "result should be 2");

        //溢出
        result = demo.Exp(
            0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
            2
        );
        console2.logUint(result);
        assertTrue(
            result <
                0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
            "result should be less than 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
        );
    }

    function testNot() public {
        uint256 result = demo.Not(0);
        assertTrue(
            result ==
                0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff,
            "result should be 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"
        );

        result = demo.Not(1);
        assertTrue(
            result ==
                0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe,
            "result should be 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe"
        );
    }

    function testLt() public {
        bool result = demo.Lt(1, 2);
        assertTrue(result == true, "result should be true");

        result = demo.Lt(2, 1);
        assertTrue(result == false, "result should be false");

        result = demo.Lt(1, 1);
        assertTrue(result == false, "result should be false");
    }

    function testSlt() public {
        bool result = demo.Slt(1, 2);
        assertTrue(result == true, "result should be true");

        result = demo.Slt(2, 1);
        assertTrue(result == false, "result should be false");

        result = demo.Slt(1, 1);
        assertTrue(result == false, "result should be false");

        result = demo.Slt(-1, 1);
        assertTrue(result == true, "result should be true");

        result = demo.Slt(-1, -2);
        assertTrue(result == false, "result should be false");

        result = demo.Slt(-2, -1);
        assertTrue(result == true, "result should be true");
    }

    function testEq() public {
        bool result = demo.Eq(1, 2);
        assertTrue(result == false, "result should be false");

        result = demo.Eq(2, 1);
        assertTrue(result == false, "result should be false");

        result = demo.Eq(1, 1);
        assertTrue(result == true, "result should be true");
    }

    function testByte() public {
        uint256 result = demo.Byte(31, 0x1234567890abcdef);
        console2.logBytes1(bytes1(uint8(result)));
        assertTrue(result == 0xef, "result should be 0xef");

        result = demo.Byte(30, 0x1234567890abcdef);
        console2.logBytes1(bytes1(uint8(result)));
        assertTrue(result == 0xcd, "result should be 0xcd");

        result = demo.Byte(1, 0x1234567890abcdef);
        console2.logBytes1(bytes1(uint8(result)));
        assertTrue(result == 0x00, "result should be 0x00");

        result = demo.Byte(100, 0x1234567890abcdef);
        console2.logBytes1(bytes1(uint8(result)));
        assertTrue(result == 0x00, "result should be 0x00");
    }
}
