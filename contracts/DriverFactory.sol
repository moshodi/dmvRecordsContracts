// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;

contract DriverFactory {

    event DriverSet(
        address walletAddress,
        uint driverId,
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

    modifier isAccount(uint _driverId) {
        require(driverToOwner[_driverId] == msg.sender, "Not your account");
        _;
    }

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
    function _getDriver(uint _driverId) internal returns (
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
        require(driverToOwner[_driverId] == msg.sender, "Not your account");
        emit DriverGotten(
            driverToOwner[_driverId],
            _driverId,
            drivers[_driverId].firstName,
            drivers[_driverId].middleInitial,
            drivers[_driverId].lastName,
            drivers[_driverId].sex,
            drivers[_driverId].height,
            drivers[_driverId].eyes
        );
        return (
            driverToOwner[_driverId],
            drivers[_driverId].firstName,
            drivers[_driverId].middleInitial,
            drivers[_driverId].lastName,
            drivers[_driverId].sex,
            drivers[_driverId].height,
            drivers[_driverId].eyes,
            drivers[_driverId].addressLineOne,
            drivers[_driverId].city,
            drivers[_driverId].state,
            drivers[_driverId].zip
        );
    }
}