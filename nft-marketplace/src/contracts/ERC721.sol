// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
a. nft to point to an address
b. keep track of token ids
c. keep track of token owner addresses to token ids
d. keep track of how many tokens an owner address has
e. create an event that emits a transfer log - contract address, where it is being minted to and the id
*/

contract ERC721 {
    
    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 indexed tokenId);

    mapping(uint256 => address) private _tokenOwner;
    mapping(address => uint256) private _ownedTokensCount;


    function balanceOf(address _owner) public view returns(uint256) {
        require(_owner != address(0),'owner query for non-existent address');
        return _ownedTokensCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0),'owner query for non-existent token');
        return owner;
    }


    //checks whether or not if the toekn already exists and is owned by another user
    function _exists(uint256 tokenId) internal view returns(bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _mint(address to, uint tokenId) internal {
        require(to != address(0), 'ERC721: minting to the zero address');
        require(!_exists(tokenId), 'Token already minted and owned by different user');
        // minting the token
        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }

}