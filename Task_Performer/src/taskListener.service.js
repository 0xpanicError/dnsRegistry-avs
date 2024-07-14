const ethers = require("ethers");
const taskController = require("./task.controller");
const dotenv = require("dotenv");
dotenv.config();

const rpcUrl = process.env.L2_RPC;
const provider = new ethers.JsonRpcProvider(rpcUrl);

const dkimRegistryAddress = process.env.DKIM_REGISTRY_ADDRESS;
const dkimRegistryAbi = [
  "function setDKIMPublicKeyHash(string, bytes32) public",
  "event DKIMPublicKeyHashSetUpRequest(string domainName, bytes32 publicKeyHash)",
];
const dkimRegistry = new ethers.Contract(
  dkimRegistryAddress,
  dkimRegistryAbi,
  provider
);

async function init() {
  setTimeout(async () => {
    await taskController.performTask("gmail.com");
  }, 8000);
  dkimRegistry.on("DKIMPublicKeyHashSetUpRequest", async (domain, hash) => {
    console.log(
      `DKIMPublicKeyHashToBeChanged event received: ${domain}, ${hash}`
    );
    await taskController.performTask(domain);
  });
}

module.exports = {
  init,
};
