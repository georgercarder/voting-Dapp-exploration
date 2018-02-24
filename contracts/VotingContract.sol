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

  /// Delegate your vote to the voter 'to'.
  function delegate(address to) public {
    // assigns reference
    Voter storage sender = voters[msg.sender];
    require(!sender.voted);

    // Self-delegation is not allowed.
    require(to != msg.sender);

    // Forward the delegation as long as
    // 'to' also delegated.
    // In general, such loops are very dangerous,
    // because if they run too long, they might
    // need more gas than is available in a block.
    // In this case, the delegation will not be execuded,
    // but in other situations, such loops might
    // cause a contract to get 'stuck' completely.
    while (voters[to].delegate != address(0)) {
      to = voters[to].delegate;

      // We found a loop in the delegation, not allowed.
      require(to != msg.sender);
    }  

    // Since 'sender' is a reference, this
    // modifies 'voters[msg.sender].voted'
    sender.voted = true;
    sender.delegate = to;
    Voter storage delegate = voters[to];
    if (delegate.voted) {
      // If the delegate already voted,
      // directly add to the number of votes
      proposals[delegate.vote].voteCount += sender.weight;
    } else {
      // If the delegate did not vote yet,
      // add to her weight.
      delegate.weight += sender.weight;
    }
  }

}
