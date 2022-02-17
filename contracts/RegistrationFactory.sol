// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;
import "./LicenseFactory.sol";
contract RegistrationFactory is LicenseFactory {

  event VehicleAdded(address walletAddress, string licenseNumber, string plateNumber, string vin);
  event VehicleReturned(address walletAddress);

  mapping (address => Registration[]) registeredVehicles;

  struct Registration {
    string licenseNum;
    string plateNumber;
    string vin;
    uint goodThru;
    string make;
    uint256 year;
    string carType;
    string model;
    string color;
  }


  function setRegistration(
    string memory _licNumber,
    string memory _plateNumber,
    string memory _vin,
    uint _goodThru,
    string memory _make,
    uint _year,
    string memory _carType,
    string memory _model,
    string memory _color
    ) public registered {
      emit VehicleAdded(msg.sender, _licNumber, _plateNumber, _vin);
      registeredVehicles[msg.sender].push(Registration(
        _licNumber,
        _plateNumber,
        _vin,
        _goodThru,
        _make,
        _year,
        _carType,
        _model,
        _color
      ));
  }

  //Gets registration info
  function getRegisteredVehicles() public registered returns (
    Registration[] memory
  ){
    emit VehicleReturned(msg.sender);
    return registeredVehicles[msg.sender];
  }
}