// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector{
    // array for storing the minted crypto-birdz(NFT)
    string[] public kryptoBirdz;

    // to check if the NFT is minted/exist or not
    mapping (string => bool) _kpyptoBirdExists;

    function mint(string memory _kpyptoBird) public{
        // make sure the NFT is not minted ever
        require(!_kpyptoBirdExists[_kpyptoBird]);
        // uint _id = KryptoBirdz.push(_kpyptoBird); 
        // only works in complier version 4 because push no longer return length
        kryptoBirdz.push(_kpyptoBird);
        uint _id = kryptoBirdz.length - 1;
        
        _mint(msg.sender, _id);
        
        // to make the NFT is minted/exist
        _kpyptoBirdExists[_kpyptoBird] = true;
    }
    
    // inherit all the interfaces that connect to ERC721Connector
    constructor() ERC721Connector('KryptoBird', 'KBIRDZ'){
        
    }
}