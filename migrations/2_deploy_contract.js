const CoToken = artifacts.require("./CoToken.sol");

module.exports = async function(deployer) {
  await deployer.deploy(CoToken)
  const erc20 = await CoToken.deployed()
};