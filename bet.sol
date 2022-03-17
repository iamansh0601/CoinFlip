
/* I was not able to implement Harmony VRF so i have chosen a result value by myself. */
pragma solidity 0.5.1;
contract CoinFlip{
    mapping(address=>uint) public balance; // mapping to store balance of each user
    /* mapping to find whether a person has undecided bet or not. 
       1 indicates he has a undecided bet while 0 indicates he is free to go for the bet.*/
         mapping(address=>uint) public busy;
    mapping(address=>uint) public _id; //Mapping to store id of the user with its address as key.
    uint public w; //to store result of the bet
    uint public peopleCount = 0; //to keep a count of the number of people participating in the bet.
    /*Line 11-15 is to ensure that our reward get block does not gets executed before 60 seconds
     after the code gets deployed for the first time*/
    uint openTime = block.timestamp; 
    modifier onlyAfterSomeTime(){
        require (block.timestamp>=openTime+60);
        _;
    }
    //Struct to store user's data like his address, and id to access his record, amount he has betted and his bet.
    struct Player{
        address user;
        uint id;
        uint amount;
        uint bet;
    }

    Player[] public record; // to keep an array of the record of each user
    //Function which allows user to place bets
    function placeBet(uint amount, uint bet) public{
        uint flag = 0 ;  // this variable is used to dtermine whether current user is new one or has been a part of the game previously
                         // flag = 0 means it is new but flag = 1 means he is previous user.
        uint pos = 0 ;   // this gives the id or index of the person if he was previously present.
        
        if(busy[msg.sender]!=1)  // to check if the curr user has no undecided bet
        {
        for(uint i=0;i<peopleCount;i++) // to check in the record we have maintained if the person with the same address has placed bet before
        {
            if((record[i].user) == msg.sender)
            {
               flag = 1;  // Current user is previously there
               pos = i;   // id or index of the user in the record.
               break;
            }
        }
        if(flag==0)  // if the user is new
        {
            balance[msg.sender] = 100;  //give him a new joinee token of 100
            if(amount<=balance[msg.sender]) // if the amount of bet is less than or eaual to the balance of user, then only bet can be placed
            {
            record.push(Player(msg.sender,peopleCount,amount,bet)); // to create a new entry in record
             balance[msg.sender] = balance[msg.sender] - amount;    // to update balance
            _id[msg.sender] = peopleCount;                          // to allocate an id
            busy[msg.sender] = 1;                                   // update its status as the user has an undecide bet now
            peopleCount = peopleCount+1;                            // update number of people in the record
            }
        }
        else{                                                      //if not a new user
             if(amount<=balance[msg.sender])
             {
            record[pos].amount = amount;                           // update the previous amount of bet 
            record[pos].bet = bet;                                 //update th bet
             balance[msg.sender] = balance[msg.sender] - amount;   //update the amount
             }
        }
       
       
    }
    }

    //This function gets the value of winnning bet and then updates the value of balances of each user depending on whether hey won or lose
    function rewardBet()public onlyAfterSomeTime { 
        /*I could not implemet harmony VRF so i have choosed a winning bet myself to try out 
        whether other parts of function work or not*/
        w=0;  
        // to check all records
        for(uint i = 0; i<peopleCount ;i++)
        {
           if( busy[record[i].user]==1) // to ensure that upon even calling the reward function multiple time value of the reward gets updated only once.
           {
           if(record[i].bet == w) //if bet of user is equal to winning bet.
           {
               balance[record[i].user] += 2* record[i].amount; //update the amount as per wiing criteria
               busy[record[i].user] = 0;  // update the staus so that user is now free to place another bet.
           }
           else
           {
                busy[record[i].user] = 0;  // if he loses just update the status that the result of his bet is decide and now he can place the nextrbet
           }
           }
        }
    }
}

    /* function vrf() public view returns (bytes32 result) {
    uint[1] memory bn;
    bn[0] = block.number;
    assembly { 
      let memPtr := mload(0x40)
      if iszero(staticcall(not(0), 0xff, bn, 0x20, memPtr, 0x20)) {
        invalid()
      }
      result := mload(memPtr)
     
    }
  }*/

