// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.10;

contract AddressDemo {
    function ConvertAddressToUint(address addr) public pure returns (uint) {
        uint160 u = uint160(addr);
        return uint(u);
    }

    function ConvertUintToAddress(uint u) public pure returns (address) {
        bytes memory b = abi.encodePacked(u);
        bytes32 h = keccak256(b);
        uint uu = uint(h);
        uint160 u160 = uint160(uu);
        return address(u160);
    }

    function SendEther(address payable to) public payable {
        to.transfer(msg.value);
    }
}

contract ContractCanNotReceiveEther {
    receive() external payable {
        revert("can not receive ether");
    }
}

contract ContractCanReceiveEther {
    event LogReceiveEther(address sender, uint amount);

    receive() external payable {
        emit LogReceiveEther(msg.sender, msg.value);
    }
}

contract ContractSelfDestruct {
    function Destroy(address to) public {
        selfdestruct(payable(to));
    }
}
