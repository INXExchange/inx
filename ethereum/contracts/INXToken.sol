import "./StandardToken.sol";

pragma solidity ^0.4.8;

contract INXToken is StandardToken {

    /* Display variables */
    string public name;
    uint8 public decimals;
    string public symbol;
    string public version = "H0.1";

    function INXToken(
        uint256 _initialAmount,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol
        ) public {
        balances[msg.sender] = _initialAmount;  // Give the owner the total supply for distribution
        totalSupply = _initialAmount;
        name = _tokenName;
        decimals = _decimalUnits;
        symbol = _tokenSymbol;
    }

    function transferOwnership(address _newOwner) onlyOwner returns(bool success) {
      owner = _newOwner;
      success = true;
    }

    /* Approves _spender and then calls the receiving contract */
    /// @notice Approves '_spender' and then calls the recipient contract 
    /// @param _spender The address of the account able to transfer the tokens
    /// @param _value The amount of tokens to be approved for transfer
    /// @param _extraData any further information for the recipient contract
    /// @return Whether the approval was successful or not
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        /* The following calls receiveApproval() on the contract to be notified. This crafts the function signature manually
        such that msg.sender doesn't have to include a contract in here just for this. */
        require(_spender.call(bytes4(bytes32(keccak256("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData));
        return true;
    }
}
