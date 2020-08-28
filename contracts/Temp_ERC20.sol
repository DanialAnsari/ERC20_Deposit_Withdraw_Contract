pragma solidity ^0.6.0;

import "./ERC20.sol";
import "./Ownable.sol";
import "./SafeMath.sol";


contract Temp_ERC20 is Ownable{
    using SafeMath for uint256;
    ERC20 public token;

    mapping (address=>uint) private balance;

    mapping (address=>uint) private timeSet;

function initialize0(ERC20 _add) public initializer {
        token=_add;
        initialize3();

}


function deposit_token(uint _token,uint _min) public {
        token.transferFrom(msg.sender,address(this),_token);
        balance[msg.sender]=SafeMath.add(balance[msg.sender],_token);
        timeSet[msg.sender]=SafeMath.add(now,_min*1 minutes); 
}

function withdraw_token() public {
        
        require(timeSet[msg.sender]<=now,"There is still some time left before you can withdraw your contract");
        require(balance[msg.sender]>0,"You do not have any tokens Deposited in this contract");
        token.transfer(msg.sender,balance[msg.sender]);
        balance[msg.sender]=0;

}

function updateTime(uint _min) onlyOwner public {
    require(balance[msg.sender]>0,"You have no tokens in this contract to set timer off");
    timeSet[msg.sender]=now +(_min * 1 minutes);
}
}