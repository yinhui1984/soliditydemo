// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/new_create_demo.sol";

contract NewDemoTest is Test {
    NewCreateDemo newDemo;
    HelloContract hello;
    HelloContractWithArgs helloWithArgs;

    function setUp() public {
        vm.createSelectFork("theNet");
        newDemo = new NewCreateDemo();
    }

    function testNewHelloContract() public {
        address helloAddr = newDemo.NewHelloContract();
        hello = HelloContract(helloAddr);
        console2.log(hello.hello());
    }

    function testCreateHelloContract() public {
        address helloAddr = newDemo.CreateHelloContract();
        hello = HelloContract(helloAddr);
        console2.log(hello.hello());
    }

    function testCreateHelloContractWithArgs() public {
        address helloAddr = newDemo.CreateHelloContractWithArgs(
            "Hello World With Args"
        );
        helloWithArgs = HelloContractWithArgs(helloAddr);
        console2.log(helloWithArgs.hello());
    }

    function testCreate2HelloContractWithArgs() public {
        string memory greetings = "Hello World With Args (Create2)";
        bytes32 salt = bytes32(keccak256(abi.encodePacked("my_salt")));

        address helloAddr = newDemo.Create2HelloContractWithArgs(
            greetings,
            salt
        );
        helloWithArgs = HelloContractWithArgs(helloAddr);
        console2.log(helloWithArgs.hello());

        console2.logAddress(helloAddr);

        bytes memory creationCodeWithArgs = abi.encodePacked(
            type(HelloContractWithArgs).creationCode,
            abi.encode(greetings)
        );

        address predictAddress = address(
            (
                uint160(
                    uint256(
                        keccak256(
                            abi.encodePacked(
                                bytes1(0xff),
                                // 注意这里地址是谁使用的create2，就是谁的地址
                                address(newDemo), 
                                salt,
                                keccak256(creationCodeWithArgs)
                            )
                        )
                    )
                )
            )
        );
        console2.logAddress(predictAddress);
        assertTrue(predictAddress == helloAddr);

        address helloAddrUpgraded = newDemo.Create2HelloContractWithArgs("[Upgraded] Hello World With Args (Create2)", salt);
        assertFalse(helloAddrUpgraded == helloAddr);
    }
}
