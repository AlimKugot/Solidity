pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Token
 * @dev token with commision
 */
contract Token {

    //by default
    uint256 commision = 5; 
    
    uint256 supply = 0;
    mapping (address => uint256) private balances;
    mapping (address => mapping(address => uint256)) private allowed;
   
   
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    /**
     * @dev Change commision
     * 
     * @param _commision your new value between 0 and 100
     */
    function setCommision(uint256 _commision) public returns(bool success) {
        if (_commision >= 0 && _commision <= 100) {
            commision = _commision;
            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Count of success supplies
     */
    function totalSupply() public view returns (uint256 total) {
        return supply;
    }
    
    
    /**
     * @dev Check balance of some _owner
     * 
     * @param _owner to check his balance
     */
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }


    /**
     * @dev transfer to someone with commision
     * 
     * @param _to send ethereum
     * @param _value count of ethereum
     */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= (_value + commision);
            balances[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        } else { 
            return false; 
        }
    }
 

    /**
     *  @dev transfer from someone to someone with commision
     * 
     * @param _from to reduce value
     * @param _to to increase value
     * @param _value ethereum
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        if (balances[_from] >= _value && _value > 0) {
            balances[_from] -= (_value + commision);
            balances[_to] += _value;
            allowed[_from][msg.sender] -= _value;
            emit Transfer(_from, _to, _value);
            return true;
        } else {
            return false;
        }
    }


    /**
     *  @dev Approve delegate to withdraw tokens
     */
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }


    /**
     *  @dev Get number of token approved with withdrawal
     */
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}