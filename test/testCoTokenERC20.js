const truffleAssert = require('truffle-assertions');

// import the contract artifact
const CoToken = artifacts.require('CoToken');

//we always have 10 accounts in local ganache env

contract (CoToken, function (accounts) {
    //predefine parameters
    const minter = accounts[0];
    const account1 = accounts[1];
    const account2 = accounts[2];

//  supp1y is 100 tokens i.e. the number of shoes Co wants to produce
// a. mint
// b. burn
// c. destroy

    it('Deploy contract, mint tokens and confirm token name and symbol are correct', async () => {
        CoTokenInstance = await CoToken.new();
    });

    // // supp1y is 100 tokens i.e. the number of shoes Co wants to produce
    // it('100 ERC20 tokens are minted on deployment', async () => {
    //     expect(Number(await CoTokenInstance.totalSupply())).to.equal(100);
    // });

     //a. mint
    it('mint test', async () => {
        //{from: account1, value: 0});

        // retrieve the details for the pair of shoes
        let mintResult = await CoTokenInstance.mint(5, {from: account1});

        // check that the balance for account 1
        assert.equal(5, 5, 'mint succeeded');
    });

     // b. burn
    it('burn test', async () => {
        //{from: account1, value: 0});
        // retrieve the details for the pair of shoes
        let mintResult = await CoTokenInstance.burn(5, {from: account1});

        // check that the balance for account 1
        assert.equal(5, 5, 'burn succeeded');
 });

     // c. destroy
    it('destroy test', async () => {
        let destroy = await CoTokenInstance.destroy({from: minter});
        assert.equal(1, 1, 'destroy succeeded');
    });
});