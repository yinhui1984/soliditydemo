// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/modifierdemo.sol";

contract ModifierDemoTest is Test {
    ModifierDemo md;

    function setUp() public {
        vm.createSelectFork("theNet");
        vm.deal(address(this), 100 ether);
        md = new ModifierDemo{value: 1 ether}();
    }

    function testWithdrawOwner() public {
        assertTrue(address(md.owner()) == address(this));
        console2.logUint(address(md).balance);
        console2.logUint(address(this).balance);
        md.withdraw();
        console2.logUint(address(md).balance);
        console2.logUint(address(this).balance);
        assertTrue(address(md).balance == 0);
    }

    function testFailWithdrawNotOwner() public {
        (address alice, ) = makeAddrAndKey("alice");
        vm.startPrank(alice);
        md.withdraw();
        vm.stopPrank();
    }

    receive() external payable {}
}

contract ModifierWithNoReentrancyDemoTest is Test {
    ModifierWithNoReentrancyDemo mrd;

    function setUp() public {
        vm.createSelectFork("theNet");
        vm.deal(address(this), 100 ether);
        mrd = new ModifierWithNoReentrancyDemo();
    }

    function testWithdraw() public {
        mrd.deposit{value: 1 ether}();
        console2.logUint(address(mrd).balance);
        mrd.withdraw();
        console2.logUint(address(mrd).balance);
        assertTrue(address(mrd).balance == 0);
    }

    function testFailWithdraw() public {
        (address alice, ) = makeAddrAndKey("alice");
        vm.deal(alice, 1 ether);
        vm.startPrank(alice);
        mrd.deposit{value: 1 ether}();
        vm.stopPrank();

        mrd.deposit{value: 1 ether}();

        console2.logUint(address(mrd).balance);
        mrd.withdraw();
        console2.logUint(address(mrd).balance);
    }

    receive() external payable {
        if (address(mrd).balance > 100) {
            mrd.withdraw();
        }
    }
}


