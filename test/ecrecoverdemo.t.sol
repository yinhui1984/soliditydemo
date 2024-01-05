// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "src/ecrecoverdemo.sol";

contract EcrecoverDemoTest is Test {
    EcrecoverDemo ecd;

    function setUp() public {
        vm.createSelectFork("theNet");

        ecd = new EcrecoverDemo();
    }

    function testRecover() public {
        (address alice, uint256 alicePrivateKey) = makeAddrAndKey("alice");
        bytes32 hash = keccak256(abi.encodePacked("hello world"));
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(alicePrivateKey, hash);
        address addr = ecd.RecoverFromMessage("hello world", v, r, s);
        console2.logAddress(addr);
        assertTrue(addr == alice);

        addr = ecd.RecoverFromMessage("hello world!!", v, r, s);
        console2.logAddress(addr);
        assertTrue(addr != alice);
    }
}
