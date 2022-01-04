// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './interfaces/IERC165.sol';

contract ERC165 is IERC165 {

    // byte4: 4 bytes long
    // hash table to keep track of contract fingerprint data of byte functions conversions
    mapping(bytes4 => bool) private _supportedInterfaces;

    constructor(){
        _registerInterface(bytes4(keccak256('supportsInterface(bytes4)')));
    }
    
    function supportsInterface(bytes4 interfaceID) external view override returns (bool){
        return _supportedInterfaces[interfaceID];
    }

    // register the interface
    function _registerInterface(bytes4 interfaceID) public{
        require(interfaceID != 0xffffffff, 'ERROR - ERC165: the interface is not valid.');
        _supportedInterfaces[interfaceID] = true;
    }

    // with keccak-256, we could transfer the interface into a fingerprint
    function calFingerprint() public view returns (bytes4){
        return bytes4(keccak256('supportsInterface(bytes4)'));
        //function supportsInterface value: 0x01ffc9a7
    }

}