pragma solidity ^0.4.8;

contract Owned {

  address public owner;
  
  /* This modifier ensures functions that can only be executed by the contract's owner */
  modifier onlyOwner {
    assert(msg.sender == owner);
    _;
  }
  
  /* Sets the owner as the contract's deployer */
  function Owned() public { owner = msg.sender; }

}