// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC165.sol';
import './interfaces/IERC721.sol';

contract ERC721 is ERC165, IERC721{

    // mapping from token ids to addresses
    mapping(uint256 => address) private _tokenOwner;

    // mapping from owner to numbers of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    // mapping from token ids to approved address
    mapping(uint256 => address) private _tokenApprovals;

    constructor(){
        _registerInterface(bytes4(keccak256('balanceOf(bytes4)')^
        keccak256('ownerOf(bytes4)')^keccak256('transferFrom(bytes4)')));
    }

    function _exists(uint256 tokenId) internal view returns(bool){
        // check if the owner address of this tokenId exist
        // which means that check if this token(id) exist or not
        address owner = _tokenOwner[tokenId];
        // return true if the address of owner is vaild
        return owner != address(0);
    }

    function balanceOf(address _owner) public view returns(uint256){
        /// @notice Count all NFTs assigned to an owner
        /// @dev NFTs assigned to the zero address are considered invalid, and this
        ///  function throws for queries about the zero address.
        /// @param _owner An address for whom to query the balance
        /// @return The number of NFTs owned by `_owner`, possibly zero
        require(_owner != address(0), "Owner address is not exist");
        return _OwnedTokensCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address){
        /// @notice Find the owner of an NFT
        /// @dev NFTs assigned to zero address are considered invalid, and queries
        ///  about them do throw.
        /// @param _tokenId The identifier for an NFT
        /// @return The address of the owner of the NFT
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "ERC721: tokenId is not exist");
        return owner;
    }

    function _mint(address to, uint tokenId)internal virtual{
        /*
            For minting function, we want to 
            1. nft point to a address
            2. keep track of token ids
            3. keep track of token ids and the address owns it
            4. keep track of how many tokens an owner address has
            5. create an event that emits a transfer log which is contract address, where it is being minted to, the id
        */

        // require that the address is not a invaild address(zero address)
        // require that the token have not ever been minted
        require(to != address(0), 'ERC721: minting to a zero address');
        require(!_exists(tokenId), 'ERC721: token already exist');

        // adding a new adress with tokenId for minting
        _tokenOwner[tokenId] = to;
        // keep track of that each address is minting and adding one if minted
        _OwnedTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }

    
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
        ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
        ///  THEY MAY BE PERMANENTLY LOST
        /// @dev Throws unless `msg.sender` is the current owner, an authorized
        ///  operator, or the approved address for this NFT. Throws if `_from` is
        ///  not the current owner. Throws if `_to` is the zero address. Throws if
        ///  `_tokenId` is not a valid NFT.
        /// @param _from The current owner of the NFT
        /// @param _to The new owner
        /// @param _tokenId The NFT to transfer

        // make sure the receiver address is valid
        require(_to != address(0), "ERROR_ERC721 - The address sending NFT is not valid");
        // make sure the NFT is owned by sender
        require(ownerOf(_tokenId) == _from, "ERROR_ERC721 - The NFT is not owned by the sender");

        // add token to new addresses
        _tokenOwner[_tokenId] = _to;
        // update the balance of sender
        _OwnedTokensCount[_from] -=1;
        // update the balance of receiver
        _OwnedTokensCount[_to] +=1;

        // transfer it
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public override {
        _transferFrom(_from, _to, _tokenId);
    }
}