## `ZombieFeeding`



Contract that adds game features to CryptoZombies


### `setKittyContractAddress(address _address)` (external)



A function to change the address of CryptoKitties


### `_triggerCooldown(struct ZombieFactory.Zombie _zombie)` (internal)



A function that triggers a cooldown


### `_isReady(struct ZombieFactory.Zombie _zombie) → bool` (internal)



A function the tells if a zombie cooldown is over


### `_feedAndMultiply(uint256 _zombieId, uint256 _targetDna, string _species)` (internal)



A public function that allows a zombie to feed an another lifeform


### `feedOnKitty(uint256 _zombieId, uint256 _kittyId)` (public)






