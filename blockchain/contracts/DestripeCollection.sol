// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DestripeCollection is ERC721, Ownable {
  uint256 private _tokenIds;
  address public authorizedContract;
  string public baseUri = "http://localhost:3000/nfts";

  constructor(address initialOwner) ERC721("DestripeCollection", "DSP") Ownable(initialOwner){}

  function setAuthorizedContract (address newAuthorizedContract) external onlyOwner {
    authorizedContract = newAuthorizedContract;
  }

  function setBaseURI (string calldata newUri) external onlyOwner {
    baseUri = newUri;
  }

  function _baseURI() internal view override returns (string memory) {
    return baseUri;
  }

  function tokenURI (uint tokenId) public view override (ERC721) returns (string memory) {
    return string.concat(_baseURI(), Strings.toString(tokenId), ".json");
  }

  function setApprovalForAll (address operator, bool approved) public virtual override (ERC721) onlyOwner {
    _setApprovalForAll(operator, msg.sender, approved);
  }

  function getLastTokenId() external view returns (uint) {
    return _tokenIds;
  }

  function burn(uint tokenId) external {
    require(msg.sender == authorizedContract || msg.sender == owner(), "Only the owner or authorized contract can burn.");
    _burn(tokenId);
  }

  function mint(address customer) external returns (uint) {
    require(msg.sender == authorizedContract || msg.sender == owner(), "Only the owner or authorized contract can mint.");
    uint256 tokenId = ++_tokenIds;
    _safeMint(customer, tokenId);
    _setApprovalForAll(customer, authorizedContract, true);
    return tokenId;
  }
}