pragma solidity ^0.4.16;

/// @title Voting with delegation.

contract Ballot {

  // new complex type. will be used for variables later
  // It will represent a single voter.
  struct Voter {
    uint weight;  // weight is accumulated by delegation
    bool voted;  // if true, that person already voted
    address delegate;  // person delegated to
    uint vote;  //index of the voted proposal  
  }













}
