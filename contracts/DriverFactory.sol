// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;

contract DriverFactory {

    constructor() public {
        hasAccount[msg.sender] = false;
    }

    event DriverSet(
        address walletAddress,
        Account account
    );

    event DriverReturned(
        address walletAddress,
        Account account
    );

    mapping (address => Account) public account; // maps user account Id to a wallet address
    mapping (address => bool) public hasAccount; // assures user only are able to create one account



    struct Account {
        string firstName;
        string middleInitial;
        string lastName;
        uint dob;
        string sex;
        string height;
        string eyes;
        string addressLineOne;
        string city;
        string state;
        string zip;
    }

    modifier registered {
        require(hasAccount[msg.sender] == true, "Account must be created for this future");
        _;
    }

    function setAccount(
        string memory _first,
        string memory _midInit,
        string memory _last,
        uint _dob,
        string memory _sx,
        string memory _ht,
        string memory _eyeColor,
        string memory _addressLineOne,
        string memory _city,
        string memory _state,
        string memory _zip
        ) public {
        require(hasAccount[msg.sender] == false, "Users can only create one profile!");
        account[msg.sender] = Account(
            _first,
            _midInit,
            _last,
            _dob,
            _sx,
            _ht,
            _eyeColor,
            _addressLineOne,
            _city,
            _state,
            _zip
        );
        hasAccount[msg.sender] == true;
    }

    function getAccount() public registered returns (Account memory) {
        emit DriverReturned(msg.sender, account[msg.sender]);
        return account[msg.sender];
    }
}