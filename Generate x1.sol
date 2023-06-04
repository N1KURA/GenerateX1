// SPDX-License-Identifier: MIT
//
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract N1KURA_history is ERC20 {
    address payable owner;
    uint256 public minMintAmount = 0.00001 * 10 ** 18;
    uint256 public maxMintAmount = 1 * 10 ** 18;

    constructor() ERC20("Generate x1", "x1") {
        _mint(msg.sender, 1 * 10 ** 18);
        owner = payable(msg.sender);
    }

    function transfer(address _to, uint256 _value) public override returns (bool success) {
        require(balanceOf(msg.sender) >= _value, "Insufficient balance");
        require(_to != address(0), "Invalid recipient address");

            _transfer(msg.sender, _to, _value);

        mintRandomAmount();

        return true;
    }


    function autoMint(uint256 _value) public {
        require(balanceOf(msg.sender) >= _value, "Insufficient balance");
            _mint(msg.sender, _value);
    }

    function mintRandomAmount() public {
        uint256 amountToMint = random(minMintAmount, maxMintAmount);
            _mint(msg.sender, amountToMint);
    }

    function random(uint256 minValue, uint256 maxValue) private view returns (uint256) {
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, blockhash(block.number - 1))));
        return (randomNumber % (maxValue - minValue)) + minValue;
    }

    function receiveETH() external payable {
        uint256 tokenAmount = 1 * 10 ** decimals();
        require(msg.value > 0, "Insufficient ETH sent");
        require(msg.sender == address(this), "ETH must be sent to the contract address");
        require(address(this).balance >= msg.value, "Insufficient contract balance");
        require(balanceOf(owner) >= tokenAmount, "Insufficient tokens in contract balance");

        owner.transfer(msg.value);

            _transfer(owner, msg.sender, tokenAmount);

        emit Transfer(owner, msg.sender, tokenAmount);
    }

    function withdrawETH(uint amount) external {
        require(msg.sender == owner, "You do not own the contract");
        require(address(this).balance >= amount, "Insufficient funds in the contract balance");
        owner.transfer(amount);
    }

    function withdrawTokens(address _tokenContract, uint256 _amount) public {
        require(msg.sender == owner, "You do not own the contract");

        ERC20 token = ERC20(_tokenContract);
        require(token.totalSupply() > 0, "Invalid token address");
        require(token.balanceOf(address(this)) >= _amount, "Insufficient tokens in contract balance");
        require(token.transfer(msg.sender, _amount), "Token transfer failed");
    }
}