// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

contract YulDemoContract {
    function Stop() public pure {
        assembly {
            stop()
            // unreachable code
            //revert(0, 0)
        }
    }

    function Add(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        assembly {
            let s := add(a, b)
            result := s
        }
        return result;
    }

    function Sub(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        assembly {
            let s := sub(a, b)
            result := s
        }
        return result;
    }

    function Mul(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        assembly {
            let s := mul(a, b)
            result := s
        }
        return result;
    }

    function Div(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        assembly {
            let s := div(a, b)
            result := s
        }
        return result;
    }

    function Sdiv(int256 a, int256 b) public pure returns (int256) {
        int256 result;
        assembly {
            let s := sdiv(a, b)
            result := s
        }
        return result;
    }

    function Mod(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        assembly {
            let s := mod(a, b)
            result := s
        }
        return result;
    }

    function Smod(int256 a, int256 b) public pure returns (int256) {
        int256 result;
        assembly {
            let s := smod(a, b)
            result := s
        }
        return result;
    }

    function Exp(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        assembly {
            let s := exp(a, b)
            result := s
        }
        return result;
    }

    function Not(uint256 a) public pure returns (uint256) {
        uint256 result;
        assembly {
            let s := not(a)
            result := s
        }
        return result;
    }

    function Lt(uint256 a, uint256 b) public pure returns (bool) {
        bool result;
        assembly {
            let s := lt(a, b)
            result := s
        }
        return result;
    }

    function Slt(int256 a, int256 b) public pure returns (bool) {
        bool result;
        assembly {
            let s := slt(a, b)
            result := s
        }
        return result;
    }

    function Eq(uint256 a, uint256 b) public pure returns (bool) {
        bool result;
        assembly {
            let s := eq(a, b)
            result := s
        }
        return result;
    }

    function Byte(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        assembly {
            let s := byte(a, b)
            result := s
        }
        return result;
    }

    function Shr(uint256 a, uint256 b) public pure returns (uint256) {
        uint256 result;
        assembly {
            let s := shr(a, b)
            result := s
        }
        return result;
    }

    function Sar(uint256 a, int256 b) public pure returns (int256) {
        int256 result;
        assembly {
            let s := sar(a, b)
            result := s
        }
        return result;
    }

    function Keccak256(
        bytes memory a,
        uint256 length
    ) public pure returns (bytes32) {
        bytes32 result;
        assembly {
            // 获取指向数组数据的指针，跳过长度前缀
            let dataPtr := add(a, 32)
            let s := keccak256(dataPtr, length)
            result := s
        }
        return result;
    }

    function Keccak256_2(bytes memory a) public pure returns (bytes32) {
        bytes32 result;
        assembly {
            let dataPtr := add(a, 32)
            let s := keccak256(dataPtr, mload(a))
            result := s
        }
        return result;
    }

    function Mload(
        bytes memory a,
        uint256 offset
    ) public pure returns (bytes32) {
        bytes32 result;
        assembly {
            let dataPtr := add(a, offset)
            let s := mload(dataPtr)
            result := s
        }
        return result;
    }

    function Mload_GetLength(bytes memory a) public pure returns (uint256) {
        uint256 result;
        assembly {
            let s := mload(a)
            result := s
        }
        return result;
    }

    function Mstore(bytes memory a, uint256 offset, bytes32 value) public pure {
        assembly {
            let dataPtr := add(a, offset)
            mstore(dataPtr, value)
        }
    }

    uint256 private value_0; // slot 0
    mapping(address => uint) map_1; // slot 1

    function SetV0(uint256 value) public {
        value_0 = value;
    }

    function GetV0() public view returns (uint256) {
        return value_0;
    }

    function Sload(uint256 slot) public view returns (uint256) {
        uint256 result;
        assembly {
            let s := sload(slot)
            result := s
        }
        return result;
    }

    function Sstore(uint256 slot, uint256 value) public {
        assembly {
            sstore(slot, value)
        }
    }

    function SetMap1Value(address key, uint256 value) public {
        map_1[key] = value;
    }

    function GetMap1Value(address key) public view returns (uint256) {
        return map_1[key];
    }

    function GetMap1Value2(address key) public view returns (uint256) {
        uint256 slot = uint256(keccak256(abi.encodePacked(key, uint256(1))));
        return Sload(slot);
    }

    function GetMap1Slot() public pure returns (uint256) {
        uint256 result;
        assembly {
            result := map_1.slot
        }
        return result;
    }

    // function Msize() public pure returns (bytes32) {
    //     bytes32 str = "hello world";
    //     bytes32 data;

    //     // 如果需要编译通过，需要在编译器设置优化选项为false
    //     // 比如在foundry.toml中设置：optimize = false
    //     assembly {
    //         let ptr := msize()
    //         mstore(ptr, str)
    //         data := mload(ptr)
    //     }

    //     return data;
    // }

    function Caller() public view returns (address) {
        address result;
        assembly {
            result := caller()
        }
        return result;
    }

    function Calldataload(uint256 p) public pure returns (bytes32) {
        bytes32 result;
        assembly {
            result := calldataload(p)
        }
        return result;
    }

    function CodeSize() public returns (uint256, uint256) {
        uint256 s1;
        uint256 s2;

        demoContractForCodeSize d = new demoContractForCodeSize();
        s1 = d.codeSizeCallInConstructor();
        s2 = d.GetCodeSize();

        return (s1, s2);
    }

    function ExtCodeSize() public returns (uint256, uint256) {
        uint256 s1;
        uint256 s2;
        demoContractForExtcodesize d = new demoContractForExtcodesize();
        s1 = d.extCodeSizeCallInConstructor();
        s2 = d.GetExtCodeSize();
        return (s1, s2);
    }

    function CallData(
        address addr,
        bytes memory data
    ) public returns (bytes memory) {
        bytes memory result;
        // 演示目的，不使用call的返回值，而通过下面获取返回值
        (bool ok, ) = addr.call(data);
        require(ok, "call failed");

        assembly {
            // 外部调用返回的数据大小,也就是上面的call返回值的长度
            let size := returndatasize()
            // 读取空闲指针位置
            result := mload(0x40)
            // 更新空闲指针位置。以便为返回数据分配足够的空间
            // add(size, 0x20): 首先，将返回数据的大小（size）与0x20（即32字节，这是EVM中单个存储槽的大小）相加。这是因为动态字节数组在内存中的布局是首先存储数组的长度（占用32字节），紧接着是数组的数据。
            // add(add(size, 0x20), 0x1f): 然后，将上一步的结果与0x1f（即31）相加。这实际上是为了计算接下来最近的32字节边界。由于Solidity的内存是以32字节为单位对齐的，这一步确保分配的内存符合这一要求。
            // and(add(add(size, 0x20), 0x1f), not(0x1f)): 接下来，使用and操作符和not(0x1f)（即取0x1f的位反）进行位操作。这实际上是将上一步的结果向下舍入到最接近的32的倍数。这是通过掩盖掉数值的最后五位（二进制中的31）来实现的，从而确保结果是32的倍数。
            // add(result, ...): 最后，将这个对齐后的大小值加到当前的空闲内存指针result上。这个操作更新了空闲内存指针，指向足够容纳返回数据（包括其长度）的内存区域的末尾。
            mstore(
                0x40,
                add(result, and(add(add(size, 0x20), 0x1f), not(0x1f)))
            )
            // 将返回数据的大小存储到返回数据的开头32个字节中
            mstore(result, size)
            // 将返回数据复制到返回数据的开头32个字节之后的位置
            returndatacopy(add(result, 0x20), 0, size)
        }

        return result;
    }

    function CallCode(address addrOfSimpleContract, uint256 value) public{
        bytes4 selector = bytes4(keccak256("setValue(uint256)"));
        bool success;
        assembly{
            let ptr := mload(0x40)
            mstore(ptr, selector)
            mstore(add(ptr, 0x4), value)
            success := callcode(
                gas(),
                addrOfSimpleContract,
                0,
                ptr,
                0x24,
                ptr,
                0
            )
        }

        require(success, "call code failed");
    }
}

contract demoContractForCodeSize {
    uint256 public codeSizeCallInConstructor;

    constructor() {
        codeSizeCallInConstructor = GetCodeSize();
    }

    function GetCodeSize() public pure returns (uint256) {
        uint256 result;
        assembly {
            result := codesize()
        }
        return result;
    }
}

contract demoContractForExtcodesize {
    uint256 public extCodeSizeCallInConstructor;

    constructor() {
        extCodeSizeCallInConstructor = GetExtCodeSize();
    }

    function GetExtCodeSize() public view returns (uint256) {
        uint256 result;
        address addr = address(this);
        assembly {
            result := extcodesize(addr)
        }
        return result;
    }
}

contract SimpleContract {
    uint256 private value;

    function getValue() public view returns (uint256) {
        return value;
    }

    function setValue(uint256 v) public {
        value = v;
    }
}
