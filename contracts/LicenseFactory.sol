// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;
import "./driverfactory.sol";
import "./InsuranceFactory.sol";
import "./RegistrationFactory.sol";
import "./InsuranceFactory.sol";
contract LicenseFactory is DriverFactory {
  event LicenseAdded(uint licenseId, string licenseNumber, string class);
  struct License {
    string licenseType;
    string licenseNumber;
    uint issued;
    uint exp;
    string class;
    string end;
    string restr;
  }
  License[] public licenses;
  function _setLicense (
    uint _userId,
    string memory _licType,
    string memory _licNum,
    string memory _licIssued,
    uint memory _licExp,
    string memory _licClass,
    string memory _licEnd,
    string memory _licRestr
    ) private {
    require(driverToOwner[_userId] == msg.sender, "Not your account");
    uint id = licenses.push(License(_licType, _licNum, _licIssued, _licExp, _licClass, _licClass, _licEnd, _licRestr)) - 1;
    licenseNumToId[_licNum] == id;
    licenseToOwner[_licNum] == msg.sender;
    ownerLicenses[msg.sender].push(_licNum);
  }
  function _getLicenses (uint _userId) private returns (string[]) {
    require(driverToOwner[_userId] == msg.sender, "Error");
    return ownerLicenses[msg.sender];
  }

  function _getLicense (uint _userId, string _licNum) private {
    require(driverToOwner[_userId] == msg.sender, "Error");
    uint index = licenseNumToId[_liceNum];
    string[] licNums = _getLicenses(_userId);
    for (i = 0; licNums.length - 1; i++) {
      if (licNums[i] == _licNum) {
        return (
          licenses[index].licenseType,
          licenses[index].licenseNumber,
          licenses[index].issued,
          licenses[index].exp,
          licenses[index].class,
          licenses[index].end,
          licenses[index].restr,
        );
        break;
      } else {
        continue;
      }
    }
  }

}
