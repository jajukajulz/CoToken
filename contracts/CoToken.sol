//pragma solidity ^0.5.0; //solidity version
pragma solidity ^0.4.24;

import "../node_modules/zeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "../node_modules/zeppelin-solidity/contracts/ownership/Ownable.sol";
import "../node_modules/zeppelin-solidity/contracts/math/SafeMath.sol";


/**
 * @dev Implementation of ERC20 fungible and ownable token based on the curve f(x) = 0.01x + 0.2 , x ∈ ℕ..
 * where x is token supply
 * Uses Ether as the reserve currency.
 */
contract CoToken is ERC20, Ownable {
    using SafeMath for uint256;

    /**
    *  @dev state variables
    */
    mapping(address => uint256) internal _balances;
    string public name;
    string public symbol;
    uint32 public decimals;
    uint256 public MAX_SUPPLY;
    uint256 public currentSupply_x; //x in f(x)
    uint64  constant ETHER_WEI_CONST = 1000000000000000000;
    //uint64 constant PRICE = ((1) * ETHER_WEI_CONST)/2; //price in wei - THIS WORKS


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
    function buyPrice(uint256 _n) public view returns(uint) {
        uint256 _new_currentSupply_x = currentSupply_x.add(_n);
        uint256 _purchasePrice = (((1*ETHER_WEI_CONST)/100) * _new_currentSupply_x) + ((2*ETHER_WEI_CONST)/10);
        //uint256 _purchasePrice = ((1/100) * _new_currentSupply_x) + (2/10);
        return _purchasePrice;
    }


    /**
    * @dev A function to calculate the price for the sale of n CO tokens based on the curve on the curve f(x) = 0.01x + 0.2 , x ∈ ℕ.
    * @param _n number of tokens to be sold.
    */
    function sellPrice(uint256 _n) public view returns(uint) {
        uint256 _new_currentSupply_x = currentSupply_x.sub(_n);
        uint256 _sellPrice = (((1*ETHER_WEI_CONST)/100) * _new_currentSupply_x) + ((2*ETHER_WEI_CONST)/10);
        return _sellPrice;
    }

    /**
    * @dev A function to creates tokens if the correct current price is transferred to the contract. The price is determined by the buyPrice function.
    * @param _n number of tokens to be purchased.
    */
    function mint(uint256 _n) internal {
        uint256 _purchasePrice = this.buyPrice(_n);
        require(msg.value == _purchasePrice, "Must send correct purchase price to buy tokens.");
        _balances[msg.sender] = _balances[msg.sender].add(_n);
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
        _balances[msg.sender] = _balances[msg.sender].sub(_n);
        currentSupply_x = currentSupply_x.sub(_n);
        emit Transfer(owner, 0x0, _n);
    }

    /**
    * @dev A destroy function that destructs the contract (see selfdestruct ). This function can only be called by the owner and it can only
be called if all CO tokens belong to the owner .
    */
    function destroy() public onlyOwner {
        require(_balances[owner] == MAX_SUPPLY, "can only be called if all CO tokens belong to the owner");
        selfdestruct(owner);
    }
}
