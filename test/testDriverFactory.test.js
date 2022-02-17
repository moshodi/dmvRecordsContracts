const DriverFactory = artifacts.require("DriverFactory");

contract("DriverFactory", accounts => {
    let factory;
    let firstNm = "John";
    let midInit = "A";
    let lastNm = "Smith";
    let dob = 010522
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
            //
        })
    })


})