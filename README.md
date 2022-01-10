# Blockchain Based Record Keeping Project

## Description
These are the smart contracts for a blockchain-based motor vehicle records keeping system.

#### How it Works
These smart contracts give users the ability to create a driver account. With this account, users have somewhere easily accessible and secure to store their license and registration information. Once their information is set, they have access to their records at all times.  


#### Stack 

	- Truffle-- Smart Contract Framework
	- Ganache-- Local Ethereum Blockchain
	
### Before You Begin

Prerequisites (attached are links on how to install them):

	1. Node.js and Node Package Manager: https://docs.npmjs.com/downloading-and-installing-node-js-and-npm
	2. Git: https://github.com/git-guides/install-git
	3. Solidity Compiler: https://docs.soliditylang.org/en/v0.8.10/installing-solidity.html
	4. Truffle: http://trufflesuite.com/docs/truffle/getting-started/installation
	5. Ganache: https://trufflesuite.com/ganache/

## How to Install

#### Step One

In your terminal change to a directory of your choice and clone the repo.

	$ cd <your directory name>
	$ git clone https://github.com/moshodi/dmvRecordsContracts.git
	
#### Step Two 

Once the repo is cloned, change to the repo's directory in the terminal.

	$ cd dmvRecordsContracts
	
Now your terminal is inside the project.

## Test The Smart Contracts

#### Compile The Contracts

	$ truffle compile

#### Get Your Local Ganache Blockchain Running 

Click QuickStart Ethereum

#### Migrate The Contracts To Ganache

	$ truffle migrate

#### Run the test scripts

	S truffle test

		
Your terminal should result in 5 Passing Tests:


    Contract: DriverFactory
      Creating an account and getting the account information
        ✓ Retrieves a user's account information (177ms)

    Contract: LicenseFactory
      Setting and Getting your license information
        ✓ Allows users to set their license information (238ms)
        ✓ Allows users to get their license information (179ms)

    Contract: RegistrationFactory
      Setting and Getting your license information
        ✓ Allows users to set their registration information (246ms)
        ✓ Allows users to get their registration information (133ms)


    5 passing (3s)
