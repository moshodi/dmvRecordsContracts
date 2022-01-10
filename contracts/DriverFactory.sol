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

    struct DriverName {
        string firstName;
        string middleInitial;
        string lastName;
    }

    struct DriverDetail {
        uint dob;
        string sex;
        string height;
        string eyes;
    }

    struct DriverAddress {
        string addressLineOne;
        string city;
        string state;
        string zip;
    }

    //Driver name database
    DriverName[] public driverNames;
    //Driver features database
    DriverDetail[] public driverDetails;
    //Driver address database
    DriverAddress[] public driverAddresses;

    modifier isAccount(uint _driverId) {
        require(driverToOwner[_driverId] == msg.sender, "Not your account");
        _;
    }

    // Create a Driver Account
    function setDriver(
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
        require(userAccountsCount[msg.sender] == 0, "Users can only create one profile!");
        driverNames.push(DriverName(_first, _midInit, _last));
        driverDetails.push(DriverDetail(_dob, _sx, _ht, _eyeColor));
        driverAddresses.push(DriverAddress(_addressLineOne, _city, _state, _zip));
        driverToOwner[driverNames.length - 1] = msg.sender;
        userAccountsCount[msg.sender]++;
        emit DriverSet(
            msg.sender,
            driverNames.length - 1,
            _first,
            _midInit,
            _last,
            _sx,
            _ht,
            _eyeColor
        );
    }
    // Get Driver's Account By its unique identifier
    function getDriverName(uint _driverId) internal view returns (address, string storage, string storage, string storage) {
        require(driverToOwner[_driverId] == msg.sender, "Not your account");
        return (
            driverToOwner[_driverId],
            driverNames[_driverId].firstName,
            driverNames[_driverId].middleInitial,
            driverNames[_driverId].lastName
        );
    }

    function getDriverDetails(uint _driverId) internal view returns (uint, string storage, string storage, string storage) {
        require(driverToOwner[_driverId] == msg.sender, "Not your account");
        return (
            driverDetails[_driverId].dob,
            driverDetails[_driverId].sex,
            driverDetails[_driverId].height,
            driverDetails[_driverId].eyes
        );
    }

    function getDriverAddress(uint _driverId) internal view returns (
        string storage,
        string storage,
        string storage,
        string storage
    ) {
        return (
            driverAddresses[_driverId].addressLineOne,
            driverAddresses[_driverId].city,
            driverAddresses[_driverId].state,
            driverAddresses[_driverId].zip
        );
    }

    function getAccountInfo(uint _driverId) public isAccount(_driverId) {
        getDriverName(_driverId);
        getDriverDetails(_driverId);
        getDriverAddress(_driverId);
        emit DriverGotten(
            driverToOwner[_driverId],
            _driverId,
            driverNames[_driverId].firstName,
            driverNames[_driverId].middleInitial,
            driverNames[_driverId].lastName,
            driverDetails[_driverId].sex,
            driverDetails[_driverId].height,
            driverDetails[_driverId].eyes
        );
    }
}