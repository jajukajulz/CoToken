//pragma solidity ^0.5.0; //solidity version
pragma solidity ^0.4.24;

import "../node_modules/zeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol";

/**
 * @dev Implementation of ERC20 fungible and ownable token based on the curve f(x) = 0.01x + 0.2 , x ∈ ℕ..
 * Uses Ether as the reserve currency.
 */
contract CoToken is ERC20Basic {

    /**
    * @dev Contract constructor.
    */
    constructor () public {
    }

    /**
    * @dev A function to calculate the price for the purchase of n CO tokens based on the curve f(x) = 0.01x + 0.2 , x ∈ ℕ.
    */
    function buyPrice() external view returns(uint) {
        return 0;
    }

    /**
    * @dev A function to calculate the price for the sale of n CO tokens based on the curve on the curve f(x) = 0.01x + 0.2 , x ∈ ℕ.
    */
    function sellPrice() external view returns(uint) {
        return 0;
    }

    /**
    * @dev A function to creates tokens if the correct current price is transferred to the contract. The price is determined by the buyPrice function.
    */
    function mint() external view returns(uint) {
        return 0;
    }

    /**
    * @dev A function that can only be called by the owner (i.e., only the owner can sell tokens back to the curve and withdraw the funds). The price is
determined by the sellPrice function.
    */
    function burn() external view returns(uint) {
        return 0;
    }

    /**
    * @dev A destroy function that destructs the contract (see selfdestruct ). This function can only be called by the owner and it can only
be called if all CO tokens belong to the owner .
    */
    function destroy() public pure returns(uint) {
        return 0;
    }
}
