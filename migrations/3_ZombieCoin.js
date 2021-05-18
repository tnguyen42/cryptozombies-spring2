const ZombieCoin = artifacts.require("ZombieCoin.sol");

module.exports = function (deployer, network) {
	return deployer
		.then(() => {
			console.log("Starting deploying ZombieCoin on " + network);
			return deployer.deploy(ZombieCoin, 10000000000);
		})
		.then(() => {
			console.log("ZombieCoin successfully deployed");
		});
};
