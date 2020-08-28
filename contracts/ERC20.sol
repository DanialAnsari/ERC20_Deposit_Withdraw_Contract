pragma solidity ^0.6.0;

import "./IERC20.sol";
import "./Initializable.sol";


contract ERC20 is IERC20,Initializable{
    uint256 total_supply;

    mapping(address => uint256) private _balance;

    mapping(address => uint256) approved_amount;

    mapping(address => mapping(address => uint256)) private _allowances;

    
    string private name;
    address contract_owner;

function initialize() public initializer {
        name = "Dan_Token";
        total_supply = 10000 * (10**18);
        _balance[msg.sender] = total_supply;
        contract_owner=msg.sender;
        
    }






    function totalSupply() external view override returns (uint256) {
        return total_supply;
    }

    function mint(uint256 amount) public  {
        require(msg.sender == contract_owner, "Only Owner can mint tokens");
        total_supply += amount;
    }

    function balanceOf(address account) external override view  returns (uint256) {
        return _balance[account];
    }

    function transfer(address recipient, uint256 amount)
        external override 
        returns (bool)
    {

        require(
            amount <= _balance[msg.sender],
            "Amount inputted is greater than amount sender has"
        );
        _balance[recipient] += amount;
        _balance[msg.sender] -= amount;

        emit Transfer(msg.sender, recipient, amount);
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external override  returns (bool) {
        require(
            amount <= _allowances[sender][msg.sender] || msg.sender==sender,
            "Amount inputted is greater than approved amount"
        );
        require(
            amount <= _balance[sender],
            "Inputted Sender does not have the requested amount of tokens"
        );
        _balance[recipient] += amount;
        _balance[sender] -= amount;
    }

    function allowance(address _owner, address spender)
        external
        view override 
        returns (uint256)
    {
        return _allowances[_owner][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
    }

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}
