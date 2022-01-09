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

    describe("Creating an account and getting the account information", async() => {
        before("Create driver account using accounts[0]", async() => {
            await factory.setDriver(firstNm, midInit, lastNm, sex, height, eyes, street, city, state, zip, {
                from: accounts[0]
            });
        })

        it("Retrieves a user's account information", async() => {
            const result = await factory.getAccountInfo(0, { from: accounts[0] });
            assert.equal(result.receipt.status, true);
            assert.equal(result.logs[0].args.userId, 0);
            assert.equal(result.logs[0].args.walletAddress, accounts[0]);
            assert.equal(result.logs[0].args.firstName, firstNm);
            assert.equal(result.logs[0].args.lastName, lastNm);
            assert.equal(result.logs[0].args.sex, sex);
        })
    })


})