pragma solidity ^0.5.16;

contract Election {
    struct Candidate { // Model a Candidate
        uint id;
        string name;
        uint voteCount;
    }

    mapping(address => bool) public voters; // Store accounts that have voted
    mapping(uint => Candidate) public candidates; // Store and fetch candidates
    uint public candidatesCount; // Store Candidates count

    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender], 'User have already voted');
        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, 'Candidate is not valid');
        voters[msg.sender] = true; // record that voter has voted
        candidates[_candidateId].voteCount++; // update candidate vote Count
    }
}
