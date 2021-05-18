const ZombieHelper = artifacts.require("ZombieHelper.sol");

module.exports = function (deployer, network) {
	return deployer
		.then(() => {
			console.log("Starting deploying ZombieHelper on " + network);
			return deployer.deploy(ZombieHelper);
		})
		.then(() => {
			console.log("ZombieHelper successfully deployed");
		});
};
