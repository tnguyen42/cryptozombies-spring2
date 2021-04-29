const ZombieFactory = artifacts.require("ZombieFactory.sol");

module.exports = function (deployer, network) {
	return deployer
		.then(() => {
			console.log("Starting deploying ZombieFactory on " + network);
			return deployer.deploy(ZombieFactory);
		})
		.then(() => {
			console.log("ZombieFactory successfully deployed");
		});
};
