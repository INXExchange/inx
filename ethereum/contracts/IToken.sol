// Interface contract for the full ERC 20 Token standard
// https://github.com/ethereum/EIPs/issues/20
pragma solidity ^0.4.8;

import "./Owned.sol";

contract IToken is Owned {
    /* the ERC-20 Standard function totalSupply() is replaced with the variable totalSupply.
    This automatically creates a getter function for the totalSupply. */
    uint256 public totalSupply;

    /* This initialised to false in order to prevent trade before ICO tokens have been transferred */
    bool public tradeOpened = false;

    /* Modifier prevents token holder transfers while trade is closed */
    modifier canTrade {
        assert(tradeOpened || msg.sender == owner);
        _;
    }

    /* @param _open Sets the state of token's tradability */
    function setTrade(bool _open) onlyOwner public returns (bool success);

    /// @param _owner The address from which the balance will be retrieved
    /// @return The balance of _owner
    function balanceOf(address _owner) public view returns (uint256 balance);

    /// @notice Sends `_value` tokens to `_to` from `msg.sender`
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transfer(address _to, uint256 _value) public returns (bool success);

    /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
    /// @param _from The address of the sender
    /// @param _to The address of the recipient
    /// @param _value The amount of token to be transferred
    /// @return Whether the transfer was successful or not
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);

    /// @notice `msg.sender` approves `_spender` to spend `_value` tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of tokens to be approved for transfer
    /// @return Whether the approval was successful or not
    function approve(address _spender, uint256 _value) public returns (bool success);

    /// @param _owner The address of the account owning tokens
    /// @param _spender The address of the account able to transfer the tokens
    /// @return Amount of remaining tokens allowed to spent
    function allowance(address _owner, address _spender) public view returns (uint256 remaining);

    /* Events to broadcast transfers or approvals for listeners */
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
