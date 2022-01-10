const RegistrationFactory = artifacts.require("RegistrationFactory");

contract("RegistrationFactory", accounts => {
    // driver account variables
    let factory;
    let firstNm = "John";
    let midInit = "A";
    let lastNm = "Smith";
    let dob = 010522;
    let sex = "Male";
    let height = "5 ft 9";
    let eyes = "blk";
    let street = "1 Hope Rd";
    let city = "Denver";
    let state = "Colorado";
    let zip = "80024";
    let driverId = 0;
    // license info variables
    let licenseNum = "0x0000000000000";
    let issued = 010122;
    let expired = 010125;
    let cl = "D";
    let end = "NONE";
    let restr = "NONE";
    // registration info variables
    let plateNum = "A1A1A1";
    let vin = "0 x0x0x0x0x0x0x0x0x";
    let goodThru = 010123;
    let make = "Honda";
    let year = "2009";
    let carType = "4 Dr.";
    let model = "Accord";
    let color = "Black";

    before(async() => {
        factory = await RegistrationFactory.new();
    });

    describe("Setting and Getting your license information", async() => {
        before("Create driver account and set license information using accounts[0]", async() => {
            await factory.setDriver(firstNm, midInit, lastNm, dob, sex, height, eyes, street, city, state, zip, {
                from: accounts[0]
            });
            await factory.setLicense(driverId, licenseNum, issued, expired, cl, end, restr, {
                from: accounts[0]
            });
        })

        it("Allows users to set their registration information", async() => {
            const result = await factory.setRegistration(driverId, licenseNum, plateNum, vin, goodThru, make, year, carType, model, color, {
                from: accounts[0]
            });
            assert.equal(result.receipt.status, true);
            assert.equal(result.logs[0].args.plateNumber, plateNum);
            assert.equal(result.logs[0].args.licenseNumber, licenseNum);
        })

        it("Allows users to get their registration information", async() => {
            const getResult = await factory.getRegistration(driverId, plateNum, {
                from: accounts[0]
            });
            assert.equal(getResult.receipt.status, true);
            assert.equal(getResult.logs[0].args.plateNumber, plateNum);
            assert.equal(getResult.logs[0].args.carYear, year);
            assert.equal(getResult.logs[0].args.carMake, make);
            assert.equal(getResult.logs[0].args.carModel, model);
            assert.equal(getResult.logs[0].args.carColor, color);
        })
    })
})