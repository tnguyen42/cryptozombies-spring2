// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./ZombieFactory.sol";

abstract contract KittyInterface {
	function getKitty(uint256 _id)
		external
		view
		virtual
		returns (
			bool isGestating,
			bool isReady,
			uint256 cooldownIndex,
			uint256 nextActionAt,
			uint256 siringWithId,
			uint256 birthTime,
			uint256 matronId,
			uint256 sireId,
			uint256 generation,
			uint256 genes
		);
}

/**
 * @title ZombieFeeding
 * @author Thanh-Quy Nguyen
 * @dev Contract that adds game features to CryptoZombies
 */
contract ZombieFeeding is ZombieFactory {
	KittyInterface kittyContract;

	/**
	 * @dev A function to change the address of CryptoKitties
	 * @param _address The new address of CryptoKitties
	 */
	function setKittyContractAddress(address _address) external onlyOwner {
		kittyContract = KittyInterface(_address);
	}

	/**
	 * @dev A function that triggers a cooldown
	 * @param _zombie A reference to a zombie from the zombies array
	 */
	function _triggerCooldown(Zombie storage _zombie) internal {
		_zombie.readyTime = uint32(block.timestamp + cooldownTime);
	}

	/**
	 * @dev A function the tells if a zombie cooldown is over
	 * @param _zombie A reference to a zombie from the zombies array
	 */
	function _isReady(Zombie storage _zombie) internal view returns (bool) {
		return (_zombie.readyTime <= block.timestamp);
	}

	/**
	 * @dev A public function that allows a zombie to feed an another lifeform
	 * @param _zombieId The id of the zombie to bed fed
	 * @param _targetDna The DNA of the target
	 */
	function _feedAndMultiply(
		uint256 _zombieId,
		uint256 _targetDna,
		string memory _species
	) internal {
		require(
			msg.sender == zombieToOwner[_zombieId],
			"Only the owner of the zombie can feed it"
		);

		Zombie storage myZombie = zombies[_zombieId];
		require(_isReady(myZombie), "The cooldown time hasn't passed");

		_targetDna = _targetDna % dnaModulus;
		uint256 newDna = _targetDna + myZombie.dna;

		if (keccak256(bytes(_species)) == keccak256(bytes("kitty"))) {
			newDna = newDna - (newDna % 100) + 99;
		}
		_createZombie("NoName", newDna);
		_triggerCooldown(myZombie);
	}

	function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
		uint256 kittyDna;

		(, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
		_feedAndMultiply(_zombieId, kittyDna, "kitty");
	}
}
