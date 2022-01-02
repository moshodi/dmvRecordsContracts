// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;
import "./LicenseFactory.sol";

contract InsuranceFactory is LicenseFactory {

    Insurance[] public insurances;

    event InsuranceAdded(uint driverId, string vehicleIdNumber, uint carYear, string carMake, string carModel);

    //vehicle id number map to wallet address
    mapping (string => address) public vinToOwner;


    //assures vehicle id number is insured
    mapping (string => bool) public vehicleInsured;

    struct Insurance {
        uint driverId;
        uint policyNumber;
        uint effectiveDate;
        uint expirationDate;
        uint year;
        string make;
        string model;
        string vehicleIdNumber;
    }

    // modifier isInsurance(string memory _vin) {
    // }

    modifier isInsured(string memory _vin) {
        require(vehicleInsured[_vin] == true, "Vehicle not insured");
        _;
    }

    function setInsurance(
        uint _driverId,
        string memory _licenseNum,
        uint _policyNumber,
        uint _effectiveDate,
        uint _expirationDate,
        uint _year,
        string memory _make,
        string memory _model,
        string memory _vehicleIdNumber
    ) public {
        require(driverToOwner[_driverId] == msg.sender, "Not your account");
        require(licenseToOwner[_licenseNum] == msg.sender, "not your license");
        require(licenseAdded[_licenseNum] == true, "Not licensed");
        require(vehicleInsured[_vehicleIdNumber] != true, "vehicle already insured");
        insurances.push(Insurance(
            _driverId,
            _policyNumber,
            _effectiveDate,
            _expirationDate,
            _year,
            _make,
            _model,
            _vehicleIdNumber
        ));
        vinToOwner[_vehicleIdNumber] = msg.sender;
        vehicleInsured[_vehicleIdNumber] = true;
        emit InsuranceAdded(_driverId, _vehicleIdNumber, _year, _make, _model);
    }

    function _getInsurance(uint _driverId, string memory _vin) private isAccount(_driverId) view returns (
        uint,
        uint,
        uint,
        uint,
        uint,
        string memory,
        string memory,
        string memory
    ) {
        // require insuranceToOwner[_vin] == msg.sender
        for (uint i = 0; i < insurances.length; i++) {
            if (keccak256(abi.encodePacked(insurances[i].vehicleIdNumber)) == keccak256(abi.encodePacked(_vin))) {
                return (
                    insurances[i].driverId,
                    insurances[i].policyNumber,
                    insurances[i].effectiveDate,
                    insurances[i].expirationDate,
                    insurances[i].year,
                    insurances[i].make,
                    insurances[i].model,
                    insurances[i].vehicleIdNumber
                );
            } else {
                continue;
            }
        }
    }

}
