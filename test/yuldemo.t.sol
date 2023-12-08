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

    function testShr() public {
        uint256 result = demo.Shr(0, 2);
        assertTrue(result == 2, "result should be 2");

        result = demo.Shr(1, 2);
        assertTrue(result == 1, "result should be 1");

        result = demo.Shr(2, 2);
        assertTrue(result == 0, "result should be 0");
    }

    function testSar() public {
        int256 result = demo.Sar(0, 2);
        assertTrue(result == 2, "result should be 2");

        result = demo.Sar(1, 2);
        assertTrue(result == 1, "result should be 1");

        result = demo.Sar(2, 2);
        assertTrue(result == 0, "result should be 0");

        result = demo.Sar(1, -2);
        assertTrue(result == -1, "result should be -1");

        result = demo.Sar(2, -2);
        assertTrue(result == -1, "result should be -1");

        result = demo.Sar(5, -2);
        assertTrue(result == -1, "result should be -1");
    }

    function testKeccak256() public {
        bytes32 result = demo.Keccak256("hello world", 11);
        bytes32 result2 = keccak256("hello world");
        bytes32 result3 = demo.Keccak256_2("hello world");

        assertTrue(result == result2, "result should be equal");
        assertTrue(result == result3, "result should be equal");
    }

    function testMload() public {
        bytes memory str = "hello world";
        // 对于动态数组（或字符串），其内存布局为：[length, data...] ，其中 length 为数组长度（32个字节，256位），data 为数组数据。
        // mload()读取前32个字节，即读取length
        uint256 result = demo.Mload_GetLength(str);
        assertTrue(result == 11, "result should be 11");

        // offset为32，即从data开始读取,读取长度为32个字节
        bytes32 result2 = demo.Mload(str, 32);
        // 使用 abi.encodePacked 来动态生成期望的 bytes32 值
        bytes32 expected = bytes32(abi.encodePacked(str));
        assertTrue(result2 == expected, "Incorrect data read from memory");
    }

    function testMstore() public {
        bytes memory str = "hello world";
        demo.Mstore(str, 32, bytes32(abi.encode("hello WORLD")));
        console2.logString(string(str));

        // 不应该相等，调用demo.Mstore时传入的是字符串的副本
        assertTrue(
            keccak256(str) != keccak256("hello WORLD"),
            "result should not be equal"
        );
    }

    function testMstore_local() public {
        bytes memory str = "hello world";
        assembly {
            mstore(add(str, 32), "hello WORLD")
        }
        console2.logString(string(str));
        // 应该相等，直接修改了字符串的内存
        assertTrue(
            keccak256(str) == keccak256("hello WORLD"),
            "result should not be equal"
        );
    }

    function testMstore8() public {
        bytes memory str = "hello world";
        assembly {
            mstore8(add(str, 32), 0x48) //0x48 'H'
        }
        console2.logString(string(str));
        assertTrue(
            keccak256(str) == keccak256("Hello world"),
            "result should be equal"
        );
    }

    function testSload() public {
        // normal value
        demo.SetV0(100);
        uint256 result = demo.GetV0();
        assertTrue(result == 100, "result should be 100");
        uint256 result2 = demo.Sload(0);
        assertTrue(result2 == 100, "result should be 100");

        //mapping
        demo.SetMap1Value(address(this), 300);
        result = demo.GetMap1Value(address(this));
        assertTrue(result == 300, "result should be 300");

        uint256 slotOfThisValueInMapping = uint256(
            keccak256(abi.encodePacked(address(this), uint256(1)))
        );

        result2 = demo.Sload(slotOfThisValueInMapping);
        console2.logUint(result2);
        // why?
        // assertTrue(result2 == 300, "result should be 300");
    }

    function testSstore() public {
        demo.SetV0(100);
        uint256 result = demo.GetV0();
        assertTrue(result == 100, "result should be 100");
        demo.Sstore(0, 200);
        uint256 result2 = demo.GetV0();
        assertTrue(result2 == 200, "result should be 200");
    }

    // function testMsize() public view {
    //     bytes32 result = demo.Msize();
    //     console2.logString(string(abi.encodePacked(result)));
    // }

    function testCaller() public {
        address result = demo.Caller();
        console2.logAddress(result);
        assertTrue(result == address(this), "result should be equal");

        (, bytes memory data) = address(demo).delegatecall(
            abi.encodeWithSignature("Caller()")
        );
        address result2 = abi.decode(data, (address));
        assertTrue(result2 != address(this), "result should not be equal");
        assertTrue(result2 == msg.sender, "result should be equal");
    }

    function testCalldataload() public {
        bytes32 result = demo.Calldataload(4);
        // 为什么等于4
        // result := calldataload(4) 刚好跳过函数选择器的4个字节，读取第一个参数的前32个字节
        assertTrue(uint256(result) == 4, "should equal to the first argument");
    }

    function testCalldatacopy() public {
        // 我们会将本函数的函数选择器存到result中
        bytes memory result = new bytes(4);
        assembly {
            // add(result, 32) 跳过result内存布局中的前32个字节，即跳过length，直接指向数据区
            // calldata的前4个字节是函数选择器
            calldatacopy(add(result, 32), 0, 4)
        }

        // 错误的方式：
        // bytes4 result;
        // assembly {
        //     calldatacopy(result, 0, 4)
        // }

        // 正确的方式
        // bytes4 result;
        // assembly {
        //     let ptr := mload(0x40)
        //     calldatacopy(ptr, 0, 4)
        //     result := mload(ptr)
        // }

        assertTrue(
            bytes4(result) == this.testCalldatacopy.selector,
            "should equal to this function's selector"
        );
    }
}
