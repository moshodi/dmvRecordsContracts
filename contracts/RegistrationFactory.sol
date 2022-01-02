// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./DriverFactory.sol";
import "./LicenseFactory.sol";
import "./InsuranceFactory.sol";
contract RegistrationFactory is DriverFactory, LicenseFactory, InsuranceFactory {

  event RegistrationAdded(uint driverId, string licenseNumber, string plateNumber);
  event RegistrationGotten(string plateNumber, uint carYear, string carMake, string carModel, string carColor);

  //maps drivers id to the mapping of a license number to a plate number
  mapping (uint => mapping(string => string[])) public ownerLicReg;

  //Registrations database
  Registration[] public registrations;

  struct Registration {
    uint driverId;
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

  function setRegistration(
    uint _driverId,
    string memory _licNumber,
    string memory _plateNumber,
    uint _titleId,
    string memory _vin,
    uint _goodThru,
    string memory _make,
    uint _year,
    string memory _carType,
    string memory _model,
    string memory _color
    ) public {
      require(driverToOwner[_driverId] == msg.sender, "Not your account");
      require(licenseToOwner[_licNumber] == msg.sender, "not your license");
      require(vehicleInsured[_vin] == true, "vehicle not insured");
      registrations.push(Registration(
        _driverId,
        _licNumber,
        _plateNumber,
        _titleId,
        _vin,
        _goodThru,
        _make,
        _year,
        _carType,
        _model,
        _color
      ));
      ownerLicReg[_driverId][_licNumber].push(_plateNumber);
      emit RegistrationAdded(_driverId, _licNumber, _plateNumber);
  }

  //Gets registration info
  function _getRegistration(uint _driverId, string memory _plateNumber) internal returns (
    string storage,
    uint256,
    string storage,
    uint,
    string storage,
    uint256,
    string storage,
    string storage,
    string storage
  )
  {
    require(driverToOwner[_driverId] == msg.sender, "Not your account");
    for (i = 0; i < registrations.length; i++) {
      if (registrations[i].driverId == _driverId && registration[i].plateNumber == _plateNumber) {
        return (
          registrations[i].plateNumber,
          registrations[i].titleId,
          registrations[i].vin,
          registrations[i].goodThru,
          registrations[i].make,
          registrations[i].year,
          registrations[i].carType,
          registrations[i].model,
          registrations[i].color
        );
      } else {
        continue;
      }
    }
  }

  //Returns a driver's list of license plates
  function _getDriverCars(uint _driverId, string _licNum) internal returns (string[]) {
    require(driverToOwner[_driverId] == msg.sender, "Not your Account");
    require (licenseToOwner[_licNum] == msg.sender, "Not your license");
    return ownerLicReg[_driverId][_licNum];
  }

}
