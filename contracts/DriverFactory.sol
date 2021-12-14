// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;
import "./InsuranceFactory.sol";
import "./RegistrationFactory.sol";
import "./InsuranceFactory.sol";
import "./LicenseFactory.sol";
contract DriverFactory {
    event DriverAdded(uint userId, string firstName, string middleInitial, string lastName);
    mapping (uint => address) public driverToOwner;
    mapping (address => uint) public driverCount; // assures user only are able to create one account
    mapping (string => address) public licenseToOwner; //maps license number with addresses
    mapping (string => uint) public licenseNumToId; //maps license id in licenses array to licensenumber confirms license existance
    mapping (address => string[]) public ownerLicenses; // possible ownership of multiple licenses
    mapping (uint => string) public registrationLicenseNum; //maps registration to drivers license
    // mapping (uint => address) public insuranceToOwner;
    struct Driver {
        string firstName;
        string middleInitial;
        string lastName;
        string sex;
        string height;
        string eyes;
        string homeAddress;
    }
    Driver[] public drivers;
    function _setDriver(
        string memory _first,
        string memory _midInit,
        string memory _last,
        string memory _sx,
        string memory _ht,
        string memory _eyeColor,
        string memory _profileAddress
        ) internal {
        require(driverCount[msg.sender] == 0, "Users can only create one profile!");
        uint id = drivers.push(Driver(_first, _midInit, _last, _sx, _ht, _eyeColor, _profileAddress)) - 1;
        driverToOwner[id] = msg.sender;
        driverCount[msg.sender]++;
    }

    function getDriver(uint _userId) public view {
        require(driverToOwner[_userId] == msg.sender, "");
        return (
          drivers[_userId].firstName,
          drivers[_userId].middleInitial,
          drivers[_userId].lastName,
          drivers[_userId].sex,
          drivers[_userId].height,
          drivers[_userId].eyes,
          drivers[_userId].homeAddress
            );
    }
}
