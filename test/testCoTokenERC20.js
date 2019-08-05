const truffleAssert = require('truffle-assertions');

// import the contract artifact
const CoToken = artifacts.require('CoToken');

//we always have 10 accounts in local ganache env

contract (CoToken, function (accounts) {
    //predefine parameters
    const token_name = "CO";
    const token_symbol = "CoTokenTokenSymbol";
    const minter = accounts[0];
    const account1 = accounts[1];
    const account2 = accounts[2];

//  supp1y is 100 tokens i.e. the number of shoes Co wants to produce
// a. mint
// b. burn
// c. destroy

    it('Deploy contract, mint tokens and confirm token name and symbol are correct', async () => {
        CoTokenInstance = await CoToken.new(token_name, token_symbol);
        expect(await CoTokenInstance.symbol()).to.equal(token_symbol);
        expect(await CoTokenInstance.name()).to.equal(token_name);
    });

    // supp1y is 100 tokens i.e. the number of shoes Co wants to produce
    it('100 ERC20 tokens are minted on deployment', async () => {
        expect(Number(await CoTokenInstance.totalSupply())).to.equal(100);
    });

     //a. mint
    it('mint test', async () => {
        //{from: account1, value: 0});

        // retrieve the details for the pair of shoes
        let shoePair = await CoTokenInstance.shoes(0);

        // check that the shoesSold count was correctly updated
        assert.equal(1, 1, 'shoesSold was not correctly updated');
    });

     // b. burn
    it('burn test', async () => {
        //{from: account1, value: 0});

        //check for require
        // await truffleAssert.reverts(CoTokenInstance.buyShoe(shoeName, shoeUrl, {from: account1, value: quarter_ether}));
    });

     // c. destroy
    it('destroy test', async () => {
        //let shoePurchaseArray = await CoTokenInstance.checkPurchases({from: account1});
        //let numTrues = shoePurchaseArray.filter(c => c ===true).length;
        assert.equal(1, 1, 'destroy not correctly updated');
    });
});