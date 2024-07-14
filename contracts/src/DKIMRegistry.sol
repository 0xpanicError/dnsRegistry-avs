// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IDKIMRegistry.sol";

// 0xd5813B8E4EF8B2B0971e7b616F6D241773596F89
contract DKIMRegistry is IDKIMRegistry {
    address public avsLogic;

    constructor(address _avsLogic) {
        avsLogic = _avsLogic;
    }

    event DKIMPublicKeyHashRegistered(string domainName, string publicKeyHash);
    event DKIMPublicKeyHashSetUpRequest(string domainName, string publicKeyHash);
    event DKIMPublicKeyHashRevoked(string domainName, string publicKeyHash);

    mapping(string => string) public dkimPublicKeyHashes;

    function setDKIMPublicKeyHash(
        string memory domainName,
        string memory publicKeyHash
    ) public {
        dkimPublicKeyHashes[domainName] = publicKeyHash;

        emit DKIMPublicKeyHashRegistered(domainName, publicKeyHash);
    }

    function setDKIMPublicKeyHashes(
        string memory domainName,
        string[] memory publicKeyHashes
    ) public {
        require(
            msg.sender == avsLogic,
            "DKIMRegistry: Only AVS Logic can set DKIM public key hashes"
        );
        for (uint256 i = 0; i < publicKeyHashes.length; i++) {
            setDKIMPublicKeyHash(domainName, publicKeyHashes[i]);
        }
    }

    function requestDKIMPublicKeyHashSetup(string memory domain) public {
        require(
            msg.sender == avsLogic,
            "DKIMRegistry: Only AVS Logic can request DKIM public key hash setup"
        );
        string memory publicKeyHash = dkimPublicKeyHashes[domain];

        emit DKIMPublicKeyHashSetUpRequest(domain, publicKeyHash);
    }

    function revokeDKIMPublicKeyHash(string memory domain) public {
        require(
            msg.sender == avsLogic,
            "DKIMRegistry: Only AVS Logic can revoke DKIM public key hashes"
        );
        string memory publicKeyHash = dkimPublicKeyHashes[domain];
        delete dkimPublicKeyHashes[domain];

        emit DKIMPublicKeyHashRevoked(domain, publicKeyHash);
    }
}
