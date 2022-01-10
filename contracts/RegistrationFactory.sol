// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "./LicenseFactory.sol";
contract RegistrationFactory is LicenseFactory {

  event RegistrationAdded(uint driverId, string licenseNumber, string plateNumber);
  event RegistrationGotten(string plateNumber, uint carYear, string carMake, string carModel, string carColor);

  //maps drivers id to the mapping of a license number to a plate number
  mapping (uint => mapping(string => string[])) public ownerLicReg;

  //Registrations details database
  RegistrationDetail[] public registrationDetails;
  //Registration features database
  CarFeature[] public carFeatures;

  struct RegistrationDetail {
    uint driverId;
    string plateNumber;
    string vin;
    uint goodThru;
  }

  struct CarFeature {
    uint driverId;
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
      registrationDetails.push(RegistrationDetail(_driverId, _plateNumber, _vin, _goodThru));
      carFeatures.push(CarFeature(_driverId, _make, _year, _carType, _model, _color));
      ownerLicReg[_driverId][_licNumber].push(_plateNumber);
      emit RegistrationAdded(_driverId, _licNumber, _plateNumber);
  }

  //Gets registration info
  function getRegistration(uint _driverId, string memory _plateNumber) public returns (
    string memory,
    string memory,
    uint,
    string memory,
    uint256,
    string memory,
    string memory,
    string memory
  )
  {
    require(driverToOwner[_driverId] == msg.sender, "Not your account");
    uint index;
    for (uint i = 0; i < registrationDetails.length; i++) {
      if (registrationDetails[i].driverId == _driverId &&
        keccak256(abi.encodePacked(registrationDetails[i].plateNumber)) == keccak256(abi.encodePacked(_plateNumber))) {
        uint index = i;
        emit RegistrationGotten(
          registrationDetails[index].plateNumber,
          carFeatures[index].year,
          carFeatures[index].make,
          carFeatures[index].model,
          carFeatures[index].color
        );
        return (
          registrationDetails[i].plateNumber,
          registrationDetails[i].vin,
          registrationDetails[i].goodThru,
          carFeatures[i].make,
          carFeatures[i].year,
          carFeatures[i].carType,
          carFeatures[i].model,
          carFeatures[i].color
        );
      } else {
        continue;
      }
    }
  }

  //Returns a driver's list of license plates
  function _getDriverCars(uint _driverId, string memory _licNum) internal view returns (string[] memory) {
    require(driverToOwner[_driverId] == msg.sender, "Not your Account");
    require (licenseToOwner[_licNum] == msg.sender, "Not your license");
    return ownerLicReg[_driverId][_licNum];
  }

}
