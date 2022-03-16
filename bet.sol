pragma solidity 0.5.1;
contract CoinFlip{
    mapping(address => uint) public balance;
    mapping(address => uint) public busy_avail ; // either 0 or 1 o represents free and 1 represents busy
    struct userData{
        address user;
        uint bet;
        uint amount;
    }
    userData[] user_data;
    uint count = 0;

    //To allow a user to place a bet adn hence accept an amount as an integer and a bet as 0/1
    //Things to do when a bet is placed
    //Reduce the balance by bet amount of the player
    //Store the bet, the amount of bet and user in ststuct data type
    function placeBet(uint amount, uint bet) public {
       uint flag = 0; 
       uint pos =  0;
       address player = msg.sender;
       for(uint i=0;i<user_data.length;i++)
       {
           if((user_data[i].user) ==(player))
           {
               flag=1;
               pos= i;
               break;
           }
       }
       if(flag==0)
       {
           balance[player] = 100;
           busy_avail[player] = 0;
        if(amount<=balance[player] && busy_avail[player]==0 )
        {  
            balance[player] = balance[player] - amount;
            busy_avail[player] = 1;
            user_data[count] = userData(player,bet,amount);
        }
        count++;
       }
       else
       {
            if(amount<=balance[player] && busy_avail[player]==0 )
        {  
            balance[player] = balance[player] - amount;
            busy_avail[player] = 1;
            user_data[pos] = userData(player,bet,amount);
        }
       }
    }

    function rewardBets() public returns(uint) {
        uint w = 0;
        for(uint i= 0; i <user_data.length;i++)
        {
            if((user_data[i].bet) == w)
            {
                balance[user_data[i].user] = balance[user_data[i].user] + 2*(user_data[i].amount);
                busy_avail[user_data[i].user] = 0;
            }
        }
        return  balance[user_data[0].user];
    }
    //function showResults() public view returns(address[] memory) {
        //for(uint i= 0; i <user_data.length;i++)
          // return balance;
    //}
}
