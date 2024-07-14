require("dotenv").config();
const dnsService = require("./dns.service");
const ethers = require("ethers");

async function validate(proofOfTask) {
  try {
    const result = await dnsService.getDnsPubKey("gmail.com");
    const isAprove =
      ethers.keccak256(ethers.toUtf8Bytes(result.toString())) == proofOfTask;
    return isAprove;
  } catch (error) {
    console.log(error);
    return null;
  }
}

module.exports = {
  validate,
};
