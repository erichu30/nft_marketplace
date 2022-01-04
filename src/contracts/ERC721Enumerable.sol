// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import './interfaces/IERC721Enumerable.sol';

contract ERC721Enumerable is ERC721, IERC721Enumerable{

    uint256[] private _allTokens;
    // mapping from tokenId to position in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to list of all owner token ids
    mapping(address => uint256[]) private _ownedTokens; 

    // mapping from token ID to index of the owner tokens list 
    mapping(uint256 => uint256) private _ownedTokensIndex;

    constructor(){
        _registerInterface(bytes4(keccak256('totalSupply(bytes4)')^
        keccak256('tokenByIndex(bytes4)')^keccak256('tokenOfOwnerByIndex(bytes4)')));
    }
    
    // return the total supply of the _allTokens array
    function totalSupply() public override view returns (uint256){
        /// @notice Count NFTs tracked by this contract
        /// @return A count of valid NFTs tracked by this contract, where each one of
        ///  them has an assigned and queryable owner not equal to the zero address
        return _allTokens.length;
    }

    // override the virtual function from _mint function in ERC721.sol
    function _mint(address to, uint256 _tokenId) internal override(ERC721){
        super._mint(to, _tokenId); // use super to use the overrided function
        
        // 1. add token to owner
        // 2. add token to totalsupply (allTokens)
        _addTokensToAllTokenEnumeration(_tokenId);
        _addTokensToOwnerEnumeration(to, _tokenId);
    }

    
    function _addTokensToOwnerEnumeration(uint256 tokenId) private {
        _addTokensToAllTokenEnumeration(tokenId);
    }

    // add tokens to the _allTokens array and set theposition of token index
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        // add token corresponding to its position 
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to , uint256 tokenId) private {
        // 1. add address and token id to the _ownedTokens
        // 2. ownedTokensIndes token set to address of ownerTokens position
        // 3. execute it with minting
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    // return token by index
    function tokenByIndex(uint256 index) public override view returns (uint256) {
        /// @notice Enumerate valid NFTs
        /// @dev Throws if `_index` >= `totalSupply()`.
        /// @param _index A counter less than `totalSupply()`
        /// @return The token identifier for the `_index`th NFT,
        ///  (sort order not specified)
        
        require(index < _allTokens.length, 'the index is out of bounds');
        return _allTokens[index];
    }

    // returm token by owner index
    function tokenOfOwnerByIndex(address owner, uint256 index) public override view returns (uint256) {
        /// @notice Enumerate NFTs assigned to an owner
        /// @dev Throws if `_index` >= `balanceOf(_owner)` or if
        ///  `_owner` is the zero address, representing invalid NFTs.
        /// @param _owner An address where we are interested in NFTs owned by them
        /// @param _index A counter less than `balanceOf(_owner)`
        /// @return The token identifier for the `_index`th NFT assigned to `_owner`,
        ///   (sort order not specified)

        require(index < balanceOf(owner), 'owner index is out of bounds');
        return _ownedTokens[owner][index];
    }
}