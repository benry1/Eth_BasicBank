# Eth_BasicBank

Exploring Solidity and Smart Contracts.

*System Setup*

Required:
Truffle
NodeJS, NPM, Web3
Ganache (Test Blockchain)

1. Download repository
2. "npm install" to get all internal dependencies
3. Download and run Ganache. Choose QuickStart

*Runbook*

--Deploying Contracts--
1. Ensure Ganache is running
2. In command line, cd into project directory
  2a. "truffle test" to find any compilation or logic issues
  2b. "truffle migrate" to deploy contracts to Ganache network
  

--Interact with Contracts--
1. In a new terminal, "truffle console" (This is a JS console)
2. const dbank = await dbank.deployed()
3. Now can access dbank methods. Syntax:
  3a. dbank.deposit({value: integervalue, from: useraddress})
