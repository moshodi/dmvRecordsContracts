const DriverFactory = artifacts.require("DriverFactory");

contract("DriverFactory", accounts => {
    let factory;
    let firstNm = "John";
    let midInit = "A";
    let lastNm = "Smith";
    let sex = "Male";
    let height = "5 ft 9";
    let eyes = "blk";
    let street = "1 Hope Rd";
    let city = "Denver";
    let state = "Colorado";
    let zip = "80024";

    before(async() => {
        factory = await DriverFactory.new();
    });

    it("Allows users to create a driver account", async() => {
        const result = await factory.setDriver(firstNm, midInit, lastNm, sex, height, eyes, street, city, state, zip, {
            from: accounts[0]
        });
        assert.equal(result.reciept.status, true);
        assert.equal(result.logs[0].args.walletAddress, accounts[0]);
        assert.equal(result.logs[0].args.driverId, 0);
    });
});