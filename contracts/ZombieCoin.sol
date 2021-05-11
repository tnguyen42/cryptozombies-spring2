// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ZombieCoin is ERC20 {
	constructor(uint256 initialSupply) public ERC20("ZombieCoin", "ZC") {
		_mint(msg.sender, initialSupply);
	}
}