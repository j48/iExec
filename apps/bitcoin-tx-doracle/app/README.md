Bitcoin Transfer Verifier DOracle using blockchain.info API
-----

App
-----
given a valid bitcoin transaction hash as input:

'b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da'

returns bitcoin transaction hash as ID (bytes32) along with transfer amount in sats and transaction timestamp (packed bytes32)

`0xb6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da000000000000000000000000000000000000000000000001f2ed64005d3b7183`

Usage
-----
`docker run -v /tmp/iexec_out:/iexec_out j048/app-bitcoin-tx-doracle:latest b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da`

Smart Contract
-----
stores Bitcoin transaction hash as ID(bytes32) along with iExec oracle call ID(bytes32) with transfer amount in sats (last 27 bytes) and transaction timestamp in unix time (first 5 bytes) as a packed bytes32

creates transaction Receipt Event Log of TxUpdated with values txHash, oracleCallID, amount, timestamp

to access packed stored values for transaction use mapping function txData(bytes32 Bitcoin transaction hash)
to access unpacked stored values for transaction use mapping function getTxAmount(bytes32 Bitcoin transaction hash)

`txData(0xb6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da)`

returns

`0: bytes32: oracleCallID 0x0000000000000000000000000000000000000000000000000000000000000001`

`1: bytes32: packedData 0x000000000000000000000000000000000000000000000005f5e100004ece2e72`

`getTxAmount(0xb6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da)`

returns

`0: tuple(uint256,uint256): amount 100000000,1322135154`

to verify:
https://www.blockchain.com/btc/tx/b6f6991d03df0e2e04dafffcd6bc418aac66049e2cd74b80f14ac86db1e3f0da
