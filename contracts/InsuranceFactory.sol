// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;
import "./DriverFactory.sol";
import "./LicenseFactory.sol";

contract InsuranceFactory is DriverFactory, LicenseFactory {

    Insurance[] public insurances;

    event InsuranceAdded(uint driverId, uint vehicleIdNumber, uint carYear, string carMake, string carModel);

    mapping (string => address) public insuranceToOwner;
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
        require(licenseToOwner[_licNumber] == msg.sender, "not your license");
        require(licenseAdded[_licNum] == true, "Not licensed");
        require(vehicleInsured[_vin] != true, "vehicle already insured");
        insurances.push(Insurance(
            _driverId,
            _licenseNum,
            _policyNumber,
            _effectiveDate,
            _expirationDate,
            _year,
            _make,
            _model,
            _vehicleIdNumber
        ));
        insuranceToOwner[_vehicleIdNumber] = msg.sender;
        vehicleInsured[_vehicleIdNumber] = true;
        emit InsuranceAdded(_driverId, _vehicleIdNumber, _year, _make, _model);
    }

    function _getInsurance(uint _driverId, string memory _vin) private {
        require(driverToOwner[_driverId] = msg.sender, "Not your account");
        require(insuranceToOwner[_vin] = msg.sender, "Not your vehicle");
        for (i = 0; i < insurances.length; i++) {
            if (insurances[i].driverId == _driverId && insurances[i].vehicleIdNumber == _vin) {
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
