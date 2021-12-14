// SPDX-License-Identifier: MIT
pragma solidity ^0.5.11;
import "./DriverFactory.sol";
import "./RegistrationFactory.sol";
import "./LicenseFactory.sol";
contract InsuranceFactory {
    Insurance[] public insurances;
    struct Insurance {
        uint256 policyNumber;
        uint256 effectiveDate;
        uint256 expirationDate;
        // Effective Date (date library)
        // Expiration Date (date library)
        uint year;
        string make;
        string model;
        string vehicleIdNumber;
        string insured;
    }
}
