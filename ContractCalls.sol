pragma solidity ^0.4.15;

contract C1 {
  uint public num;
  address public sender;

    //Sets C2's num and shows C1 address in C2.
  function callSetNum(address c2, uint _num) public {
    if(!c2.call(bytes4(keccak256("setNum(uint256)")), _num)) // ! is the not operator.
      revert(); // C2's num is set 
  }
  
  //Sets C2's num and shows C1 address in C2.
  function c2setNum(address _c2, uint _num) public{
      C2 c2 = C2(_c2);
      c2.setNum(_num);
  }

  //does not change C2's num and stored address.
  function callcodeSetNum(address c2, uint _num) public {
    if(!c2.callcode(bytes4(keccak256("setNum(uint256)")), _num)) 
     revert(); // C1's num is set
  }
  // 
  function delegatecallSetNum(address c2, uint _num) public {
    if(!c2.delegatecall(bytes4(keccak256("setNum(uint256)")), _num)) 
     revert(); // C1's num is set 
  }
}

contract C2 {
  uint public num;
  address public sender;

  function setNum(uint _num) public {
    num = _num;
    sender = msg.sender;
    // msg.sender is C1 if invoked by C1.callcodeSetNum
    // msg.sender is C3 if invoked by C3.f1()

  }
}

contract C3 {
    function f1(C1 c1, C2 c2, uint _num) public {
        c1.delegatecallSetNum(c2, _num);
    }
}
