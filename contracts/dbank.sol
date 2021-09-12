// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Token.sol";

contract dBank {

	//Token Contract variable
	Token private token;
	uint private interestRate = 5000;

	//add mappings
	mapping(address => uint) public depositStart;
	mapping(address => uint) public etherBalanceOf;

	mapping(address => bool) public isDeposited;

	//add events
	event Deposit(address indexed user, uint etherValue, uint timeStart);
	event Withdraw(address indexed user, uint etherValue, uint depositTime, uint interest);

	//pass as constructor argument deployedd Token contract
	constructor(Token _token) {
		token = _token;
	}

	function deposit() payable public {
		require(isDeposited[msg.sender] == false, 'Deposit already in progress');
		require(msg.value>=1e16, "Deposit must be >= 0.01 ETH");

		etherBalanceOf[msg.sender] = etherBalanceOf[msg.sender] + msg.value;
		depositStart[msg.sender] = depositStart[msg.sender] + block.timestamp;

		isDeposited[msg.sender] = true;
		emit Deposit(msg.sender, msg.value, block.timestamp);
	}

	function withdraw() public {
		require(isDeposited[msg.sender] == true, 'No previous deposits!');

		uint userBalance = etherBalanceOf[msg.sender];
		uint depositTime = block.timestamp - depositStart[msg.sender];

		//TODO: Check hold time to determine interest. Mint interest
		uint interestPerSecond = interestRate * (etherBalanceOf[msg.sender] / 1e16);
		uint interest = interestPerSecond * depositTime;
		token.mint(msg.sender, interest);


		payable(msg.sender).transfer(userBalance);

		depositStart[msg.sender] = 0;
		etherBalanceOf[msg.sender] = 0;
		isDeposited[msg.sender] = false;

		emit Withdraw(msg.sender, userBalance, depositTime, 0);
	}
}
