## `ZombieHelper`



Contract dedicated to additional Zombie functions

### `aboveLevel(uint256 _level, uint256 _zombieId)`






### `withdraw()` (external)



A function that allows the owner of the smart contract to withdraw all the ethers stored

### `setLevelUpFee(uint256 _fee)` (external)





### `levelUp(uint256 _zombieId)` (external)



A payable function that allows users to level up their zombies in exchange of a fee


### `changeName(uint256 _zombieId, string _newName)` (external)



A function that allows renaming of a zombie if its level is higher than 2


### `changeDna(uint256 _zombieId, uint256 _newDna)` (external)



A function that allows changing the DNA of a zombie if its level is higher than 20


### `getZombiesByOwner(address _owner) → uint256[]` (external)






