# NFT_marketplace
A NFT marketplace written in solidity 0.8.0 and javascript that allow users mint NFT on website and check which NFTs they own

## Demo
https://youtu.be/KliWukDwKIg

## Dependency
Run ```npm install``` on the terminal to download the appropriate packages already defined in the package.json file

### Tools Installation before deployment
- Ganache
- Truffle (global installation)
- Metamask.io (hooked up on the browser, chrome version recommend)

## Deploy

- open Ganache with a new workspace
- connect Ganache to Metamask with
    - name: up to you
    - RPC URL: you may find it on top of ganache
    - chain id: default is 1337
- check the configuration in truffle-config.js
- import the private key of the address you may want to use into Metamask

- ```cd nft-marketplace```
- ```truffle init```
- ```truffle compile```
- ```truffle migrate```
    - if migrated, use ```truffle migrate --reset```
- ```npm run start```

## Others
For truffle tests and console please consult the official Truffle documentation for updates.

