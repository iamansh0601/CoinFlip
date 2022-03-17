# CoinFlip
This is smart contract which implements a Coin-Flip betting game, where betting is done on the result of a of a coin.
Mapping is used to maintain balances of the users and and array of struct is uded to maintain records of the user.
Mapping with the name of id is used to assosciate every address with a uique id which is actually indexof the array where the record of that user is stored to allow the user access their records.
This Smart contract has function named as "placeBet" Which is public in nature. So the user can place their bets by providing amount of bet and their bet. 
When function placeBet is called by user. This function first checks whether the person has any undecide bet or not, if yes then then new bet is not allowed otherwise bet is processed. Then it checks whether the account address of user is already present in the records or not. That is if the person if a new entry or has been a player previously.
If the person id new entry then a balance of 100 is provided to him so that he can place his bets. Then it checks that whether bet amount placed by user is avaialble in the balance of that user, if not then bet is not processed.
But if required balance is there, then a new entry in the record array is made which contans user address, id, amount of bet, bet. Balance of the user is deducted by the bet amount. and id equal  to the index of the record is mapped to its address so that when user click on id he can get the index using which he can acces his records.
If it is not a new entry then all the operations are same except that a new entry is not created but its previous entry is modified.
Then there is a function "rewardBet" is provided with a modifier "OnlyAfterSomeTime" which is designed such that  it gives 1 minute window where all bets can be placed and then after that time window only rewardBet can be called.
Once it is called it comapress the bet of each user in record to the winning bet. Winneres are reward and losers are not given anything.
But after that both of them are free to to take part in next bet and can place bets again by deploying the code again.
