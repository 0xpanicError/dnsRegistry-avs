# dnsRegistry-avs

A DNS Registry basically looks up the RSA public key of any domain name and returns it. There is a need for a decentralised oracle network to provide such a service to projects like zkEmail by PSE. 

Currently they use oracle service from DFINITY but in order to have more control over their stack, they'd like their own DNS Registry oracle. This project is built as an AVS to provide economic security to the oracle. 

Through continued work on this project, the PSE team for zkEmail can completely switch their stack from ICP to a custom AVS built using Othentic. 

## Architecture

The architecture of the protocol is as follows: 

The zkEmail contracts have a mapping for domain name and their respective public keys. If the contract receives a domain name who's key is not valid (either because it's not present or because of periodic key rotation), it calls a function on the serviceManager contract of the AVS called the DKIMRegistry which emits an event.

This emitted event is listened by the Task Performer which makes a DNS query to fetch the latest public key for the requested domain. 

After executing the task, it packages it as a proof and sends the request to the node aggregator which gossips it around the p2p network. The attesters in the network receive this message and re run the query to validate the task. If they think it's correct, they attest to it with their approval which is then aggregated by the node and submitted as a task. 

This task does an onchain call to the DKIMRegistry contract which updates the latest publicKey Hash on the contract ready to use by zkEmail for proof generation. 
