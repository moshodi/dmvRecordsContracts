// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;
import "./DriverFactory.sol";

contract LicenseFactory is DriverFactory {

    event LicenseAdded(address walletAddress, uint driverId, string licenseNumber);
    event LicenseListGotten(address walletAddress, uint driverId, uint licenseCount);
    event LicenseGotten(address walletAddress, uint driverId, string licenseNumber);


    mapping (string => address) public licenseToOwner; //maps license number with addresses
    // mapping (string => uint) public licenseNumToId; //maps license id in licenses array to licensenumber confirms license existance
    mapping (address => string[]) public ownerLicensesList; // possible ownership of multiple licenses

    mapping (string => bool) public licenseAdded;

    struct License {
        uint driverId;
        string licenseType;
        string licenseNumber;
        uint issued;
        uint exp;
        string cl;
        string end;
        string restr;
    }

    License[] public licenses;

    modifier isLicensed(uint _driverId, string memory _licNum) {
        require(driverToOwner[_driverId] == msg.sender, "Not your account");
        require(licenseAdded[_licNum] == true, "Not licensed");
        require(licenseToOwner[_licNum] == msg.sender, "Not your license");
        _;
    }

    function setLicense(
        uint _driverId,
        string memory _licType,
        string memory _licNum,
        uint _licIssued,
        uint _licExp,
        string memory _licClass,
        string memory _licEnd,
        string memory _licRestr
    ) public {
        require(driverToOwner[_driverId] == msg.sender, "Not your account");
        require(licenseAdded[_licNum] != true, "License added already");
        licenses.push(License(
            _driverId, _licType, _licNum, _licIssued, _licExp, _licClass, _licEnd, _licRestr)
        );
        licenseAdded[_licNum] = true;
        licenseToOwner[_licNum] = msg.sender;
        ownerLicensesList[msg.sender].push(_licNum);
        emit LicenseAdded(msg.sender, _driverId, _licNum);
    }

    function _getLicenseList(uint _driverId) internal returns (string[] memory) {
        require(driverToOwner[_driverId] == msg.sender, "Not your account");
        emit LicenseListGotten(msg.sender, _driverId, ownerLicensesList[msg.sender].length);
        return ownerLicensesList[msg.sender];
    }

    function _getLicense(uint _driverId, string memory _licNum) private returns (
        uint,
        string memory,
        string memory,
        uint,
        uint,
        string memory,
        string memory,
        string memory
    ){
        require(driverToOwner[_driverId] == msg.sender, "Not your account");
        require(licenseToOwner[_licNum] == msg.sender, "Not your license");
        for (uint i = 0; i < licenses.length; i++) {
            if (licenses[i].driverId == _driverId) {
                return (
                    licenses[i].driverId,
                    licenses[i].licenseType,
                    licenses[i].licenseNumber,
                    licenses[i].issued,
                    licenses[i].exp,
                    licenses[i].cl,
                    licenses[i].end,
                    licenses[i].restr
                );
            } else {
                continue;
            }
        }
        emit LicenseGotten(msg.sender, _driverId, _licNum);
    }
}
