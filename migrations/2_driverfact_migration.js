const DriverFactory = artifacts.require("DriverFactory");

module.exports = function(deployer) {
    deployer.deploy(DriverFactory);
};