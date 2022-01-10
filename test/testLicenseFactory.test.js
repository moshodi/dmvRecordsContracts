const LicenseFactory = artifacts.require("LicenseFactory");

contract("LicenseFactory", accounts => {
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




    before(async() => {
        factory = await LicenseFactory.new();
    });

    describe("Setting and Getting your license information", async() => {
        before("Create driver account using accounts[0]", async() => {
            await factory.setDriver(firstNm, midInit, lastNm, dob, sex, height, eyes, street, city, state, zip, {
                from: accounts[0]
            });
        })

        it("Allows users to set their license information", async() => {
            const result = await factory.setLicense(driverId, licenseNum, issued, expired, cl, end, restr, {
                from: accounts[0]
            });
            assert.equal(result.receipt.status, true);
            assert.equal(result.logs[0].args.driverId, driverId);
            assert.equal(result.logs[0].args.walletAddress, accounts[0]);
            assert.equal(result.logs[0].args.licenseNumber, licenseNum);
        })

        it("Allows users to get their license information", async() => {
            const getResult = await factory.getLicense(driverId, licenseNum, {
                from: accounts[0]
            });
            assert.equal(getResult.receipt.status, true);
            assert.equal(getResult.logs[0].args.walletAddress, accounts[0]);
            assert.equal(getResult.logs[0].args.driverId, driverId);
            assert.equal(getResult.logs[0].args.licenseNumber, licenseNum);
        })
    })
})