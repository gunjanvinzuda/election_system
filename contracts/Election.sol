pragma solidity ^0.4.2;

contract Election{
    //Model candidate
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    //Fetch candidate
    mapping(uint => Candidate) public candidates;
    //keepng track of of a account has voted or not
    mapping(address => bool) public voted;
    //Candidates counts
    uint public candidatesCount;

    //voted event
    event votedEvent(
        uint indexed _candidateId
    );
    //Constructor
    function Election() public{
        addCandidate("Candidate1");
        addCandidate("Candidate2");
        
    }

    function addCandidate(string _name) private{
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public{
        //check if account hasn't voted before
        require(!voted[msg.sender]);
        //if _candidateId is a valid id
        require( _candidateId>0 && _candidateId<=candidatesCount );
        //store that the account has voted
        voted[msg.sender] = true;
        //increment vote of candidate
        candidates[_candidateId].voteCount++;
        //trigger event
        votedEvent(_candidateId);
    }
}
