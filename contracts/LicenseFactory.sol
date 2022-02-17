// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;
pragma experimental ABIEncoderV2;
import "./DriverFactory.sol";

contract LicenseFactory is DriverFactory {

    event LicenseAdded(address walletAddress, string licenseNumber);
    event LicenseListReturned(address walletAddress, License[] licenseNumber);
    mapping (address => License[]) licenses;

    struct License {
        string licenseNumber;
        uint issued;
        uint exp;
        string cl;
        string end;
        string restr;
    }

    function setLicense(
        string memory _licNum,
        uint _licIssued,
        uint _licExp,
        string memory _licClass,
        string memory _licEnd,
        string memory _licRestr
    ) public registered {
        emit LicenseAdded(msg.sender, _licNum);
        licenses[msg.sender].push(License(
            _licNum,
            _licIssued,
            _licExp,
            _licClass,
            _licEnd,
            _licRestr
        ));
    }

    function getLicense() public registered returns (License[] memory) {
        emit LicenseListReturned(msg.sender, licenses[msg.sender]);
        return licenses[msg.sender];
    }
}
