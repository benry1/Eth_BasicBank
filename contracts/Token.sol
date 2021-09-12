// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
	//Add Minter Variable
	address public minter;

	//Add Minter Changed Event
	event MinterChanged(address indexed from, address to);

	constructor() payable ERC20("FunTimes Test Token", "FTT") {
		minter = msg.sender;
	}

	function swapMinter(address newAccount) public returns (bool) {
		require(msg.sender == minter, "Only owner can update mint status");

		minter = newAccount;

		emit MinterChanged(msg.sender, newAccount); //Emit an "Event" stored on blockchain
		return true;
	}

	function mint(address account, uint256 amount) public {
		require(msg.sender == minter, "Only owner can mint.");
		_mint(account, amount);
	}
}