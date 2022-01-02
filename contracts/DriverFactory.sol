// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;

contract DriverFactory {

    event DriverSet(
        address walletAddress,
        uint userId,
        string firstName,
        string middleInitial,
        string lastName,
        string sex,
        string height,
        string eyes
    );

    event DriverGotten(
        address walletAddress,
        uint userId,
        string firstName,
        string middleInitial,
        string lastName,
        string sex,
        string height,
        string eyes
    );

    mapping (uint => address) public driverToOwner; // maps user account Id to a wallet address
    mapping (address => uint) public userAccountsCount; // assures user only are able to create one account

    // mapping (uint => address) public insuranceToOwner;
    struct Driver {
        address walletAddress;
        string firstName;
        string middleInitial;
        string lastName;
        string sex;
        string height;
        string eyes;
        string addressLineOne;
        string city;
        string state;
        string zip;
    }

    //Driver database
    Driver[] public drivers;

    // Create a Driver Account
    function setDriver(
        string memory _first,
        string memory _midInit,
        string memory _last,
        string memory _sx,
        string memory _ht,
        string memory _eyeColor,
        string memory _addressLineOne,
        string memory _city,
        string memory _state,
        string memory _zip
        ) public {
        require(userAccountsCount[msg.sender] == 0, "Users can only create one profile!");
        drivers.push(
            Driver(
                msg.sender,
                _first,
                _midInit,
                _last,
                _sx,
                _ht,
                _eyeColor,
                _addressLineOne,
                _city,
                _state,
                _zip
            )) - 1;
        driverToOwner[drivers.length - 1] = msg.sender;
        userAccountsCount[msg.sender]++;
        emit DriverSet(
            msg.sender,
            drivers.length - 1,
            _first,
            _midInit,
            _last,
            _sx,
            _ht,
            _eyeColor
        );
    }
    // Get Driver's Account By its unique identifier
    function _getDriver(uint _userId) internal returns (
        address,
        string storage,
        string storage,
        string storage,
        string storage,
        string storage,
        string storage,
        string storage,
        string storage,
        string storage,
        string storage
    ){
        require(driverToOwner[_userId] == msg.sender, "Not your account");
        emit DriverGotten(
            driverToOwner[_userId],
            _userId,
            drivers[_userId].firstName,
            drivers[_userId].middleInitial,
            drivers[_userId].lastName,
            drivers[_userId].sex,
            drivers[_userId].height,
            drivers[_userId].eyes
        );
        return (
            driverToOwner[_userId],
            drivers[_userId].firstName,
            drivers[_userId].middleInitial,
            drivers[_userId].lastName,
            drivers[_userId].sex,
            drivers[_userId].height,
            drivers[_userId].eyes,
            drivers[_userId].addressLineOne,
            drivers[_userId].city,
            drivers[_userId].state,
            drivers[_userId].zip
        );
    }
}