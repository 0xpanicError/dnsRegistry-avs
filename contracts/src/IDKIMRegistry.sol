// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDKIMRegistry {
    function setDKIMPublicKeyHash(
        string memory domainName,
        string memory publicKeyHash
    ) external;
}
