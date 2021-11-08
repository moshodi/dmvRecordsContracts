// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./InsuranceFactory.sol";
import "./DriverFactory.sol";
contract RegistrationFactory {
  event RegistrationAdded(uint registrationId, uint year, string make, string model, string color);
  Registration[] public registrations;
  struct Registration {
    string plateNumber;
    uint256 titleId;
    string vin;
    uint goodThru;
    string make;
    uint256 year;
    string carType;
    string model;
    string color;
  }
  function _setRegistration (
    uint memory _userId,
    string memory _licNum,
    string memory _plateNum,
    uint memory _titId,
    string memory _viNum,
    uint memory expDate,
    string memory _mk,
    uint memory _vehicleYear,
    string memory _type,
    string memory _carModel,
    string memory _carColor
    ) private {
      require(driverToOwner[_userId] == msg.sender, "Error");
      require(licenseToOwner[_licNum] == msg.sender, "Must be your license");
      uint id = registrations.push(Registration(_plateNum, _titId, _viNum, _expDate, _mk, _vehicleYear, _type, _carModel, _carColor));
      registrationLicenseNum[id] = _licNum;
  }
  function getRegistration (
    uint memory _regId
  ) public {
    return (
      registrations[_regId].plateNumber,
      registrations[_regId].titleId,
      registrations[_regId].vin,
      registrations[_regId].goodThru,
      registrations[_regId].make,
      registrations[_regId].year,
      registrations[_regId].carType,
      registrations[_regId].model,
      registrations[_regId].color,
      registrationLicenseNum[_regId]
    );
  }

}
