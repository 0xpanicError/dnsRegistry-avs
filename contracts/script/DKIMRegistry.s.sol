// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {IAttestationCenter} from "../src/IAttestationCenter.sol";
import {DKIMRegistry} from "../src/DKIMRegistry.sol";
import {AvsLogic} from "../src/AvsLogic.sol";

// forge script DKIMRegistryScript --rpc-url $L2_RPC --private-key $PRIVATE_KEY --broadcast -vvvv --verify --etherscan-api-key $L2_ETHERSCAN_API_KEY --chain $L2_CHAIN --verifier-url $L2_VERIFIER_URL --sig="run(address)" $ATTESTATION_CENTER_ADDRESS
contract DKIMRegistryScript is Script {
    DKIMRegistry public dkimRegistry;

    function setUp() public {}

    function run(address attestationCenter) public {
        vm.startBroadcast();
        AvsLogic avsLogic = new AvsLogic(attestationCenter);
        dkimRegistry = new DKIMRegistry(address(avsLogic));
        avsLogic.setDKIMRegistry(address(dkimRegistry));
        IAttestationCenter(attestationCenter).setAvsLogic(address(avsLogic));
        vm.stopBroadcast();
    }
}
