// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Migrations {
  // keep tracking who is deploying this as sender
  address public owner = msg.sender;
  uint public last_completed_migration;

  // 限制 owner 是msg.sender for security
  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _; // continue running the fuction
  }

  // take an integer to keep track of completions
  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }

  // function allows to upgrade new address
  function upgrade(address new_address) public restricted{
    Migrations upgraded = Migrations(new_address);
    upgraded.setCompleted(last_completed_migration);
  }
}
