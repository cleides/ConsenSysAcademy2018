pragma solidity ^0.4.1;

contract C1 {
    
    uint x; //creates a glogal variable called x, it is an unsigned integer 256 bits.
    
    constructor() 
    public {
        x = 10;
    }
    // Now one can call this function to change x, lets say to 4, instead of 10.
    // Now use a transaction to call the setX function (a transaction costs gas)
    function setX(uint _x)  // This function is called a setter. 
    public
    returns(bool) {
        x = _x;
        return true;
    }
    
    function getX()  // this function is called a getter. It does not cost gas.
    public
    view
    returns(uint) {
        return x;
    }
}

contract C2 {
    
    function f2(address addrC1) 
    public
    view
    returns(uint) {
        C1 contractOne;             // declare variable of type C1
        contractOne = C1(addrC1);   // cast addrC1 to be of type C1.
        
        uint x = contractOne.getX(); // call the .getX function of C1
        return x;                    // return the value we got above.
    }
    
}
