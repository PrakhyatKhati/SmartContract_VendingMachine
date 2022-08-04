// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract VendingMachine {
//Declaing variable
    address public owner;
    mapping (address =>uint256) public donutBalances;

//Define our constructure 
//set the owenr and initial balances 
    constructor(){
        // msg is a special global variable and here sender is the originator address.. afte the smart contract is deployed, so its the address of who deployed the contract.
        owner =msg.sender;
        //donate balances
        donutBalances[address(this)] = 100;
    }
    // view mean only read operation done by the function
    // we can use pure but it mean we cant do anythings
    //uint is the return type 
    function getVendingMachinebalance() public view returns (uint){
        // what are we saying here is to get the balance associate with this contract.
        return  donutBalances[address(this)];

    }
    // Now the restock function for the owner of the vending machine
    // this method will not return anything so we done need a return type.
    // we also need to restrick the restock function cause it need to revoked by the owner only.
    // require state.(condition,error)
    function restock (uint amount) public {
        require(msg.sender == owner,"Only the owner can restock this machine");
        donutBalances[address(this)]+=amount;

    }
    //purchase function 
    // amount of dounot about to purchase. 
    //payable to pay using ether
    function purchase(uint amount) public payable{
            //this require stated is used to check the need money to buy.
            require(msg.value >= amount *2 ether,"You must pay 2 ether per donut");
            // this require is need to check if we have sufficient donut.
            require(donutBalances[address(this)] >= amount,"Not enough donut");
            donutBalances[address(this)] -=amount;
            donutBalances[msg.sender] += amount;
     }


}
