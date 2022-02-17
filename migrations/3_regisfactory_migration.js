const RegistrationFactory = artifacts.require("RegistrationFactory");

module.exports = function(deployer) {
    deployer.deploy(RegistrationFactory);
};