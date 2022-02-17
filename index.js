// importing web3
const Web3 = require('web3');

// importing the json file for a smart contract (DriverFactory)
const DriverContract = require('./build/contracts/DriverFactory.json');

const init = async() => {
    const web3 = new Web3('https://ropsten.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161'); //ropsten test net web3 instance

    //metamask access (new version of metamask)
    // const web3 = new Web3(window.ethereum);
    // window.ethereum.enable(); //asks user to give wallet access to the DApp

    //metamask access (old version of metamask)
    // const web3 = new Web3(window.web3.currentProvider);

    //connected to the blockchain!

    // const id = await web3.eth.net.getId();
    // console.log(id);
    const deployedNetwork = DriverContract.networks["5777"];
    console.log(deployedNetwork);
    const contract = new web3.eth.Contract(DriverContract.abi, deployedNetwork.address);
    console.log(deployedNetwork.address)
    console.log(contract);

}

init();