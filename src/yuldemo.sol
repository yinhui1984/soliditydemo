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
}
