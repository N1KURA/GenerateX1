# GenerateX1
This contract is an ERC-20 token with some additional features. The contract inherits the standard ERC-20 protocol from OpenZeppelin, 
which allows it to use all its basic functions, such as `transfer`, `balanceOf`, `approve` and others.

In addition, the contract contains the `autoMint` function, which allows the user to automatically create new tokens at his own expense. 
The function `mintRandomAmount` randomly generates and adds tokens in the specified range to the owner.

The `receiveETH` function allows the contract to receive ether, which is then transferred to the contract owner's balance. In return, 
the contract sends a certain number of tokens to the payer if the contract owner has enough tokens in the balance.

The `withdrawETH` function allows the contract owner to withdraw ether from the contract to his address.

The `withdrawTokens` function allows the contract owner to withdraw any other ERC-20 tokens that have been sent to the contract 
address to his address.

In general, this contract can perform the basic functions of an ERC-20 token and also allows its owner to add new tokens and 
withdraw ether and other tokens from the contract.
