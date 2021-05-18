// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./ZombieFeeding.sol";

/**
 * @title ZombieFactory
 * @author Thanh-Quy Nguyen
 * @dev Contract dedicated to additional Zombie functions
 */
contract ZombieHelper is ZombieFeeding {
	uint256 levelUpFee = 0.001 ether;

	modifier aboveLevel(uint256 _level, uint256 _zombieId) {
		require(
			zombies[_zombieId].level >= _level,
			"The zombie doesn't have the required level"
		);
		_;
	}

	/**
	 * @dev A function that allows the owner of the smart contract to withdraw all the ethers stored
	 */
	function withdraw() external onlyOwner {
		address payable _owner = payable(owner());
		_owner.transfer(address(this).balance);
	}

	function setLevelUpFee(uint256 _fee) external onlyOwner {
		levelUpFee = _fee;
	}

	/**
	 * @dev A payable function that allows users to level up their zombies in exchange of a fee
	 * @param _zombieId The zombie to be leveled up
	 */
	function levelUp(uint256 _zombieId) external payable {
		require(
			msg.value == levelUpFee,
			"The amount of ethers sent does not match the level up fee"
		);
		zombies[_zombieId].level++;
	}

	/**
	 * @dev A function that allows renaming of a zombie if its level is higher than 2
	 * @param _zombieId The ID of the zombie to be renamed
	 * @param _newName The new name to be given to the zombie
	 */
	function changeName(uint256 _zombieId, string calldata _newName)
		external
		aboveLevel(2, _zombieId)
	{
		require(
			msg.sender == zombieToOwner[_zombieId],
			"This zombie does not belong to the sender"
		);

		zombies[_zombieId].name = _newName;
	}

	/**
	 * @dev A function that allows changing the DNA of a zombie if its level is higher than 20
	 * @param _zombieId The ID of the zombie to have its DNA changed
	 * @param _newDna The new DNA to be given to the zombie
	 */
	function changeDna(uint256 _zombieId, uint256 _newDna)
		external
		aboveLevel(20, _zombieId)
	{
		require(
			msg.sender == zombieToOwner[_zombieId],
			"This zombie does not belong to the sender"
		);

		zombies[_zombieId].dna = _newDna;
	}

	function getZombiesByOwner(address _owner)
		external
		view
		returns (uint256[] memory)
	{
		uint256[] memory result = new uint256[](ownerZombieCount[_owner]);
		uint256 counter = 0;

		for (uint256 i = 0; i < zombies.length; i++) {
			if (zombieToOwner[i] == _owner) {
				result[counter] = i;
				counter++;
			}
		}

		return result;
	}
}
