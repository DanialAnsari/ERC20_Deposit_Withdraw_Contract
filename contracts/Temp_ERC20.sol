pragma solidity ^0.6.0;

import "./ERC20.sol";
import "./Ownable.sol";


contract Temp_ERC20 is ERC20,Ownable{

    mapping (address=>uint) private balance;

    mapping (address=>uint) private timeSet;

function initialize0() public initializer {
        initialize();
        initialize3();

}
function deposit_token(uint _token,uint _min) public {
        
        deposit2Contract(_token* (10**18));
        balance[msg.sender]+=_token* (10**18);
        timeSet[msg.sender]=now + (_min * 1 minutes);
}

function withdraw_token() public {
        
        require(timeSet[msg.sender]<=now,"There is still some time left before you can withdraw your contract");
        require(balance[msg.sender]>0,"You do not have any tokens Deposited in this contract");
        withdrawFromContract(balance[msg.sender]);
        balance[msg.sender]=0;
}

function updateTime(uint _min) onlyOwner public {
    require(balance[msg.sender]>0,"You have no tokens in this contract to set timer off");
    timeSet[msg.sender]=now +(_min * 1 minutes);
}
}