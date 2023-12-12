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

    function CodeSize() public  returns (uint256, uint256) {
        uint256 s1;
        uint256 s2;

        demoContractForCodeSize d = new demoContractForCodeSize();
        s1 = d.codeSizeCallInConstructor();
        s2 = d.GetCodeSize();

        return (s1, s2);
    }

    function ExtCodeSize() public  returns (uint256, uint256) {
       uint256 s1;
         uint256 s2;
         demoContractForExtcodesize d = new demoContractForExtcodesize();
         s1 = d.extCodeSizeCallInConstructor();
         s2 = d.GetExtCodeSize();
        return (s1, s2);
    }

}

contract demoContractForCodeSize {

    uint256 public codeSizeCallInConstructor ;
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
uint256 public extCodeSizeCallInConstructor ;
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







