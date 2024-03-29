# CoToken
Fixed supply ERC20 ownable token (fungible) priced using a token bonding curve. Bonding Curves are a method of continous token minting / burning. 

The Token

* Issuance: A fungible token called “CO”
* Supply: 100, this is the number of shoes Co wants to produce

The Bond

* Collateral: ETH, CO tokens are bought in ETH
* The Traded Asset or Objective: The shoes, 1 pair cost one “CO”

The Curve

* Curve function: f(x) = 0.01x + 0.2 , x ∈ ℕ where x is token supply
    * i.e. ∈ (mathematics) means that it is an element in the set of... i.e.x ∈ ℕ denotes that x is within the set of natural numbers. 
* Pricing: static pricing

Specialty
* Only Co is allowed to sell tokens back to the curve.


Every ERC20 compliant contract must implement the ERC20 interface(s) as below.
```
interface ERC20 {
        event Transfer(address indexed _from, address indexed _to, uint256 _value)
        event Approval(address indexed _owner, address indexed _spender, uint256 _value)
        function name() public view returns (string); //optional
        function symbol() public view returns (string); //optional
        function decimals() public view returns (uint8); //optional
        function totalSupply() public view returns (uint256);
        function balanceOf(address _owner) public view returns (uint256 balance);
        function transfer(address _to, uint256 _value) public returns (bool success);
        function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
        function approve(address _spender, uint256 _value) public returns (bool success);
        function allowance(address _owner, address _spender) public view returns (uint256 remaining);
    }
                                            
```
The interfaces are implemented in the `zeppelin-solidity` package and `CoToken` inherits from `ERC20Token` i.e. don't re-invent the wheel!
    
## Installation
1. Install Truffle globally. Truffle is the most popular smart contract development, testing, and deployment framework. 
```
$npm install -g truffle 
```

2. Start Ganache and Create a Workspace (or open an existing one). Since we are minting 100 tokens in the constructor, you will need to create a Ganache Workspace with the following parameters to avoid an out of gas exception.
```
Gas Limit 3294197972992 
Gas price 200000000000000
```

3. Install npm dependencies.
```
$ npm install
```

4. Confirm CoToken smart contract compiles successfully.
```
$truffle compile
```

5. Run tests for CoToken smart contract.
```
$truffe test
$truffle test --network development
```

6. Deploy CoToken smart contract to Ganache (assumes Ganache is running).

`truffle migrate` will run all migrations located within your project's migrations directory. If your migrations were previously run successfully, truffle migrate will start execution from the last migration that was run, running only newly created migrations. If no new migrations exists, `truffle migrate` won't perform any action at all. 
```
$truffle migrate
```

The --reset flag will force to run all your migrations scripts again. Compiling if some of the contracts have changed. You have to pay gas for the whole migration again. 
```
$truffle migrate --reset
```

The --all flag will force to recompile all your contracts. Even if they didn't change. It is more time compiling all your contracts, and after that it will have to run all your deploying scripts again.
```
$truffle migrate --compile-all --reset
```

If for some reason truffle fails to acknowledge a contract was modified and will not compile it again, delete the build/ directory. This will force a recompilation of all your contracts and running all your deploy scripts again.

7. Update `truffle-config.js` development network with NetworkID, Host and Port values from your local Blockchain in Ganache.


## Other
1. Access deployed contract from CLI
```
$ truffle console
$ CoToken.deployed().then(function(instance) { app = instance })
$ app.getNumberOfRegisteredShoes()
```

2. Add a new migration
```
$touch 2_deploy_contract.js
```

3. Create infura project  at https://infura.io (Infura gives you access to test network).
This project will give you an ID that you will use in `truffle-config.js`
infura means you do not have to sync an ether node or rinkeby node to deploy directly.

4. Get test ether from https://faucet.rinkeby.io/ (you will need to create an Ethereum rinkeby wallet on MetaMask then use the address on twitter).
e.g. 0x4B67D20a4F27d248aF0462C23F8C193f073517FB

5. Update `truffle-config.js` with rinkeby. This will deploy from the metamask accounts, by default account 0 so specify which one you want.

6. Deploy to rinkeby. 
```
$truffle migrate --network rinkeby --compile-all --reset
```

7. Check contract on rinkeby etherscan https://rinkeby.etherscan.io

