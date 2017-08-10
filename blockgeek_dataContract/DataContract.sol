pragma solidity ^0.4.13;

contract DataContract {
   
   struct Customer{
        uint id;
        string name;
        uint dateOfBirth;
        uint social;
        uint status;

    }
    
    uint constant active = 1;
    uint constant pending = 2;
    uint constant deleted = 3;
    
    mapping (uint => Customer) customers;
    
    uint public count = 0;
    
    function createCustomer(uint id, string name, uint dateOfBirth, uint social){
        customers[count] = Customer(id, name, dateOfBirth, social, pending);
        count++;
    
    }
    
    function getCustomer(uint index) constant returns (uint id, string name, uint dateOfBirth, uint social, uint status){
    
        id = customers[index].id;
        name = customers[index].name;
        dateOfBirth = customers[index].dateOfBirth;
        social = customers[index].social;
        status = customers[index].status;

    }
    
    function getCustomerById(uint id) constant returns (uint idRet, string name, uint dateOfBirth, uint social, uint status){
        for (var i=0; i<count; i++){
            if (customers[i].id == id) {
                idRet = customers[i].id;
                name = customers[i].name;
                dateOfBirth = customers[i].dateOfBirth;
                social = customers[i].social;
                status = customers[i].status;
                return;
            }
    
        }

    }
   function updateCustomer(uint index, string name) {
        if (index > count) throw;
        customers[index].name = name;
    
    }
    
    function updateCustomerStatus(uint index, uint status) {
        if (index > count) throw;
            customers[index].status = status;
    }
    
}