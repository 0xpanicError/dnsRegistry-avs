"use strict";
const { Router } = require("express");
const ethers = require("ethers");
const dnsService = require("./dns.service");
const dalService = require("./dal.service");

const router = Router();

async function performTask(domain) {
    console.log(`Perform task: domain: ${domain}`);
    try {
        const result = await dnsService.getDnsPubKey(domain);
        console.log("DNS result:", result);
        const proofOfTask = ethers.keccak256(ethers.toUtf8Bytes(result.toString()));
        const taskDefinitionId = 0;
        await dalService.sendTask(proofOfTask, taskDefinitionId);
    } catch (error) {
        console.log(error);
        return null;
    }
}

module.exports = { router, performTask };
