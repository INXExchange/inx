pragma solidity ^0.4.8;

import "./IToken.sol";

contract StandardToken is IToken {

    uint256 constant MAX_UINT256 = 2**256 - 1;

    /* Modifier prevents token holder transfers while trade is closed */
    modifier canTrade {
        assert(tradeOpened || msg.sender == owner);
        _;
    }


    function setTrade(bool _open) onlyOwner public returns (bool success) {
        tradeOpened = _open;
        return true;
    }


    function transfer(address _to, uint256 _value) public canTrade returns (bool success) {
        require(balances[msg.sender] >= _value && _to!=0x0);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }


    function transferFrom(address _from, address _to, uint256 _value) public canTrade returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value && _to!=0x0);
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        balances[_to] += _value;
        balances[_from] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }

    function balanceOf(address _owner) view public returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
    view public returns (uint256 remaining) 
    {
      return allowed[_owner][_spender];
    }

    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
}
