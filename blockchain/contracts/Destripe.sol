// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./INFTCollection.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

contract Destripe is ERC721Holder, Ownable {
  INFTCollection public nftCollection;
  IERC20 public acceptedToken;

  constructor(address tokenAddress, address nftAddress) Ownable(msg.sender) {
    acceptedToken = IERC20(tokenAddress);
    nftCollection = INFTCollection(nftAddress);
  }
}
