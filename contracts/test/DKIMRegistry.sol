// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {DKIMRegistry} from "../src/DKIMRegistry.sol";
import {AvsLogic} from "../src/AvsLogic.sol";

contract DKIMRegistryTest is Test {
    DKIMRegistry public dkimRegistry;
    AvsLogic public avsLogic;

    function setUp() public {
        avsLogic = new AvsLogic(msg.sender);
        dkimRegistry = new DKIMRegistry(address(avsLogic));
    }

    function testAfterTaskSubmission() public {
        uint256[] memory operatorIds = new uint256[](3);
        avsLogic.afterTaskSubmission(
            0,
            msg.sender,
            "0xb3f88b911666b5220c3457c040126071610c728e411b7176333219181476270c",
            true,
            "tpSignature",
            [uint256(1), 2],
            operatorIds
        );
    }

    function testSetDKIMPublicKeyHash() public {
        dkimRegistry.setDKIMPublicKeyHash(
            "gmail",
            "0xb3f88b911666b5220c3457c040126071610c728e411b7176333219181476270c"
        );
        assertEq(
            dkimRegistry.dkimPublicKeyHashes("gmail"),
            "0xb3f88b911666b5220c3457c040126071610c728e411b7176333219181476270c"
        );
    }
}
