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
}
