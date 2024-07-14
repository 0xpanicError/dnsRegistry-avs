require("dotenv").config();
const { ethers } = require("ethers");

var rpcBaseAddress = "";
var privateKey = "";

function init() {
  rpcBaseAddress = process.env.OTHENTIC_CLIENT_RPC_ADDRESS;
  privateKey = process.env.PRIVATE_KEY;
}

async function sendTask(proofOfTask, taskDefinitionId) {
  var wallet = new ethers.Wallet(privateKey);
  var performerAddress = wallet.address;
  proofOfTask.toString();
  const data = ethers.hexlify(ethers.toUtf8Bytes("hello world"));
  console.log("checking type of data");
  console.log(typeof data, data);
  const message = ethers.AbiCoder.defaultAbiCoder().encode(
    ["string", "bytes", "address", "uint16"],
    [proofOfTask, data, performerAddress, taskDefinitionId]
  );
  const messageHash = ethers.keccak256(message);
  const sig = wallet.signingKey.sign(messageHash).serialized;

  const jsonRpcBody = {
    jsonrpc: "2.0",
    method: "sendTask",
    params: [proofOfTask, data, taskDefinitionId, performerAddress, sig],
  };
  try {
    console.log(`Sending API request to ${rpcBaseAddress}...`);
    const provider = new ethers.JsonRpcProvider(rpcBaseAddress);
    const response = await provider.send(
      jsonRpcBody.method,
      jsonRpcBody.params
    );
    console.log("API response:", response);
  } catch (error) {
    console.error("Error making API request:", error);
  }
}

module.exports = {
  init,
  sendTask,
};
