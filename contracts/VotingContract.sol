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

  // A dynamically-sized array of 'Proposal' structs.
  Proposal[] public proposals;

  /// Create a new ballot to choose one of 'proposalNames'.
  function Ballot(bytes32[] proposalNames) public {
    chairperson = msg.sender;
    voters[chairperson].weight = 1;

    // For each of the provided proposal names,
    // create a new proposal object and add it
    // to the end of the array.
    for (uint i = 0; i < proposalNames.length; i++) {
      // 'Proposal({...})' creates a temp
      // Proposal object and 'proposals.push(...)'
      // appends it to the end of 'proposals'.
      proposals.push(Proposal({
        name: proposalNames[i],
        voteCount: 0
      }));
    }
  }

  // Give 'voter' the right to vote on the ballot.
  // May only be called by 'chairperson'.
  function giveRightToVote(address voter) public {
    // If the arg of 'require' evaluates to 'false'
    // it terminates and reverts all changes to
    // the state and to ether balances. It is often
    // a good idea to use this if functions are
    // called incorrectly. but watch out, this
    // will currently also consume all provided gas
    // (this is planned to change in the future).
    require((msg.sender == chairperson) && !voters[voter].voted && (voters[voter].weight == 0 ));
    voters[voter].weight = 1;  
  }



}
