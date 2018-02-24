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

  // This is a type for a single proposal.
  struct Proposal {
    bytes32 name;  // short name (up to 32 bytes)
    uint voteCount; // number of accumulated votes
  }

  address public chairperson;

  // This declares a state variable that
  // stores a 'Voter' struct for each possible address.
  mapping(address => Voter) public voters;




}
