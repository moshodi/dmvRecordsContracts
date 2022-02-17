const LicenseFactory = artifacts.require("LicenseFactory");

module.exports = function(deployer) {
    deployer.deploy(LicenseFactory);
};