// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ZombieFactory
 * @author Thanh-Quy Nguyen
 * @dev Contract dedicated to the creation of new zombies as an extension of CryptoKitties
 */
contract ZombieFactory is Ownable {
	event NewZombie(uint256 zombieId, string name, uint256 dna);

	uint256 dnaDigits = 16;
	uint256 dnaModulus = 10**dnaDigits;
	uint256 cooldownTime = 1 days;

	struct Zombie {
		string name;
		uint256 dna;
		uint32 level;
		uint32 readyTime;
	}

	Zombie[] public zombies;

	mapping(uint256 => address) public zombieToOwner;
	mapping(address => uint256) public ownerZombieCount;

	/**
	 * @dev A function that creates new zombies with a given name and dna
	 * @param _name The name of the zombie to be created
	 * @param _dna The DNA of the zombie to be created
	 */
	function _createZombie(string memory _name, uint256 _dna) internal {
		zombies.push(
			Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime))
		);

		uint256 id = zombies.length - 1;
		zombieToOwner[id] = msg.sender;
		ownerZombieCount[msg.sender]++;

		emit NewZombie(id, _name, _dna);
	}

	/**
	 * @dev A function that will generate a random dna from a name
	 * @param _str A string from which the random dna will be generated
	 * @return A random dna made of 16 digits
	 */
	function _generateRandomDna(string memory _str)
		private
		view
		returns (uint256)
	{
		// keccak256(bytes(_str));
		uint256 rand = uint256(keccak256(bytes(_str)));
		return rand % dnaModulus;
	}

	/**
	 * @dev A public function that will create a new zombie from a given name
	 * @param _name The name of the zombie to be created
	 */
	function createRandomZombie(string memory _name) public {
		require(
			ownerZombieCount[msg.sender] == 0,
			"A user can only call this function once."
		);
		uint256 randDna = _generateRandomDna(_name);
		_createZombie(_name, randDna);
	}
}
