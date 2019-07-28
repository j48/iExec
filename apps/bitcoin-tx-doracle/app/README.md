Bitcoin Tx Doracle using blockchain.info API
-----

App
-----
when given a bitcoin transaction hash as input 
`0e7d19dd60fe948c6008957275f30f94b8715fed1cf45d6864ded789c2febe51`

returns Bitcoin transaction hash as ID (bytes32) along with transfer amount in sats and transaction timestamp (packed uint256)
`0x0e7d19dd60fe948c6008957275f30f94b8715fed1cf45d6864ded789c2febe51000000000000000000000000000000000000000000000001f2ed64005d3b7183`

Usage
-----
`docker run -v /tmp/iexec_out:/iexec_out j048/app-bitcoin-tx-doracle:latest b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da`
or
`docker run -v /tmp/iexec_out:/iexec_out j048/app-bitcoin-tx-doracle:latest TXHASHAMT b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da`


Smart Contract
-----
stores Bitcoin transaction hash as ID(bytes32) along with iExec oracle call ID(bytes32), transfer amount(uint256) in sats, and transaction timestamp(uint256) in unix time

creates transaction Receipt Event Log of TxUpdated with values txHash, oracleCallID, amount, time

to access stored values for transaction use mapping function txHash(bytes32 of Bitcoin transaction hash)

`txHash(0x0e7d19dd60fe948c6008957275f30f94b8715fed1cf45d6864ded789c2febe51)`

to verify:
https://www.blockchain.com/btc/tx/0e7d19dd60fe948c6008957275f30f94b8715fed1cf45d6864ded789c2febe51
