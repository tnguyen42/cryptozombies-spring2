// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * @title ZombieFactory
 * @author Thanh-Quy Nguyen
 * @dev Contract dedicated to the creation of new zombies as an extension of CryptoKitties
 */
contract ZombieFactory {
	event NewZombie(uint256 zombieId, string name, uint256 dna);

	uint256 dnaDigits = 16;
	uint256 dnaModulus = 10**dnaDigits;

	struct Zombie {
		string name;
		uint256 dna;
	}

	Zombie[] public zombies;

	/**
	 * @dev A function that creates new zombies with a given name and dna
	 * @param _name The name of the zombie to be created
	 * @param _dna The DNA of the zombie to be created
	 */
	function _createZombie(string memory _name, uint256 _dna) private {
		zombies.push(Zombie(_name, _dna));

		emit NewZombie(zombies.length - 1, _name, _dna);
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
		uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
		return rand % dnaModulus;
	}

	/**
	 * @dev A public function that will create a new zombie from a given name
	 * @param _name The name of the zombie to be created
	 */
	function createRandomZombie(string memory _name) public {
		uint256 randDna = _generateRandomDna(_name);
		_createZombie(_name, randDna);
	}
}
