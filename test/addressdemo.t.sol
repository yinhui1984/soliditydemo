// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/adderssdemo.sol";

contract AddressDemoTest is Test {
    AddressDemo ad;
    ContractCanNotReceiveEther notReceiveEther;
    ContractCanReceiveEther canReceiveEther;
    ContractSelfDestruct csd;

    function setUp() public {
        vm.createSelectFork("theNet");

        ad = new AddressDemo();
        notReceiveEther = new ContractCanNotReceiveEther();
        canReceiveEther = new ContractCanReceiveEther();
        csd = new ContractSelfDestruct();

        vm.deal(address(this), 100 ether);
        vm.deal(address(csd), 100 ether);
    }

    function testConvertAddressToUint() public view {
        address addr = 0x1234567890123456789012345678901234567890;
        uint u = ad.ConvertAddressToUint(addr);
        console2.logUint(u);
    }

    function testConvertUintToAddress() public view {
        address addr = 0x1234567890123456789012345678901234567890;
        uint u = ad.ConvertAddressToUint(addr);
        address addr1 = ad.ConvertUintToAddress(u);
        console2.logAddress(addr1);
        // assertEq(addr1, addr);
    }

    function testSendEther() public {
        address payable addr = payable(address(canReceiveEther));
        console2.log("before transfer", address(this).balance);
        console2.log("before transfer", addr.balance);
        //addr.transfer(1 ether);
        ad.SendEther{value: 1 ether}(addr);
        console2.log("after transfer", addr.balance);
        console2.log("after transfer", address(this).balance);
    }

    function testFailCanNotSendEther() public {
        address payable addr = payable(address(notReceiveEther));
        console2.log("before transfer", addr.balance);
        addr.transfer(1 ether);
        console2.log("after transfer", addr.balance);
    }

    function testForceSendEther() public {
        address payable addr = payable(address(notReceiveEther));
        console2.log("before transfer", addr.balance);
        csd.Destroy(addr);
        console2.log("after transfer", addr.balance);
    }
}
