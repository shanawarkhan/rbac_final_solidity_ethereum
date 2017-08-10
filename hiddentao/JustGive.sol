pragma solidity ^0.4.13;

contract SimpleAccessControl {
  address public creator;
//   uint public balance;
  mapping (address => bool) authorized;
  
  function AccessControl () {
    creator = msg.sender;
  }
  
  function authorize (address entity) {
    authorized[entity] = true;
  }
  
  function deauthorize (address entity) {
    authorized[entity] = false;
  }
  
  modifier isAuthorized {
    if (true != authorized[msg.sender]) {
      revert();
    }
    _;
  }
}


contract JustGive is SimpleAccessControl {
  
  uint256 startTime;
  uint256 endTime;
  uint256 minCap;
  address payee;

  mapping (address => uint256) contributions;

  function JustGive (
    uint256 _startTime,
    uint256 _endTime,
    uint256 _minCap,
    address _payee
  ) 
  
  SimpleAccessControl() {
    startTime = _startTime;
    endTime = _endTime;
    minCap = _minCap;
    payee = _payee;
  }
  
  // check that funding period is active
  modifier fundingActive () {
    assert(now >= startTime && now < endTime);
    _;
  }

  // check that funding period is over
  modifier fundingEnded () {
    assert(now > endTime);
    _;
  }
  
  // check that funding was successful
  modifier fundingSuccessful() {
    assert(this.balance >= minCap);
    _;
  }
  
  // check that funding was NOT successful
  modifier fundingNotSuccessful() {
    assert(this.balance < minCap);
    _;
  }
  
  // pay out contributions to payee
  function payout() external isAuthorized fundingEnded fundingSuccessful {
    payee.transfer(this.balance);    
  }

  // get refund of contributed ETH
  function refund() external fundingEnded fundingNotSuccessful {
    msg.sender.transfer(contributions[msg.sender]);    
  }

  // default function - contribute
//   function () payable fundingActive{
//     contributions[msg.sender] = contributions[msg.sender] + msg.balance;
//   }
}