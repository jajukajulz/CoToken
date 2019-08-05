//pragma solidity ^0.5.0; //solidity version
pragma solidity ^0.4.24;

//import "../node_modules/zeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

/**
 * @dev Implementation of ERC20 fungible and ownable token based on the curve f(x) = 0.01x + 0.2 , x ∈ ℕ..
 * where x is token supply
 * Uses Ether as the reserve currency.
 */
contract CoToken is ERC20Basic, Ownable {


    /**
    *  @dev state variables
    */
    string public name;
    string public symbol;
    uint32 public decimals;
    uint256 public MAX_SUPPLY;
    uint256 public currentSupply_x; //x in f(x)

    /**
    * @dev Contract constructor.
    */
    constructor () public {
        symbol = "COTokenSymbol";
        name = "CO";
        decimals = 5;
        MAX_SUPPLY = 100;
        currentSupply_x = 0;
        owner = msg.sender;
    }

    /**
    * @dev A function to calculate the price for the purchase of n CO tokens based on the curve f(x) = 0.01x + 0.2 , x ∈ ℕ.
    * @param _n number of tokens to be purchased.
    */
    function buyPrice(uint256 _n) internal view returns(uint) {
        uint256 _new_currentSupply_x = currentSupply_x.add(_n);
        uint256 _purchasePrice = (0.01 * _new_currentSupply_x) + 0.2;
        return _purchasePrice;
    }

    /**
    * @dev A function to calculate the price for the sale of n CO tokens based on the curve on the curve f(x) = 0.01x + 0.2 , x ∈ ℕ.
    * @param _n number of tokens to be sold.
    */
    function sellPrice(uint256 _n) internal view returns(uint) {
        uint256 _new_currentSupply_x = currentSupply_x.sub(_n);
        uint256 _sellPrice = (0.01 * _new_currentSupply_x) + 0.2;
        return _sellPrice;
    }

    /**
    * @dev A function to creates tokens if the correct current price is transferred to the contract. The price is determined by the buyPrice function.
    * @param _n number of tokens to be purchased.
    */
    function mint(uint256 _n) internal {
        uint256 _purchasePrice = this.buyPrice(_n);
        require(msg.value == _purchasePrice, "Must send correct purchase price to buy tokens.");
        balances[msg.sender] = balances[msg.sender].add(_n);
        currentSupply_x = currentSupply_x.add(_n);
        emit Transfer(0x0, msg.sender, _n);
    }


    /**
    * @dev A function that can only be called by the owner (i.e., only the owner can sell tokens back to the curve and withdraw the funds). The price is
determined by the sellPrice function.
    * @param _n number of tokens to be sold back to the curve.
    */
    function burn(uint256 _n) internal {
        require(msg.sender == owner, "only the owner can sell tokens back to the curve and withdraw the funds");
        uint256 _sellPrice = this.sellPrice(_n);
        balances[msg.sender] = balances[msg.sender].sub(_n, "ERC20: burn amount exceeds balance");
        currentSupply_x = currentSupply_x.sub(_n);
        emit Transfer(owner, 0x0, _n);
    }

    /**
    * @dev A destroy function that destructs the contract (see selfdestruct ). This function can only be called by the owner and it can only
be called if all CO tokens belong to the owner .
    */
    function destroy() public pure returns(uint) {
        return 0;
    }
}
