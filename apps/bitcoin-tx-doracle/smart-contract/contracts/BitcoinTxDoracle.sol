pragma solidity ^0.5.8;
pragma experimental ABIEncoderV2;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "iexec-doracle-base/contracts/IexecDoracle.sol";

contract BitcoinTxDoracle is Ownable, IexecDoracle{

	struct Tx
	{
		bytes32 oracleCallID;
		uint256 amount;
		uint256 time;
	}

	mapping(bytes32 => Tx) public txHash;
	
	event TxUpdated(
		bytes32 indexed txHash,
		bytes32 indexed oracleCallID,
		uint256 amount,
		uint256 time);

	// Use _iexecHubAddr to force use of custom iexechub, leave 0x0 for autodetect
	constructor(address _iexecHubAddr)
	public IexecDoracle(_iexecHubAddr)
	{}

	function updateEnv(
	  address _authorizedApp, 
	  address _authorizedDataset, 
	  address _authorizedWorkerpool, 
	  bytes32 _requiredtag, 
	  uint256 _requiredtrust)
	public onlyOwner
	{
		_iexecDoracleUpdateSettings(_authorizedApp, _authorizedDataset, _authorizedWorkerpool, _requiredtag, _requiredtrust);
	}

	function decodeResults(bytes memory results)
	public pure returns(bytes32, uint256)
	{ return abi.decode(results, (bytes32, uint256)); }

	function processResult(bytes32 _oracleCallID)
	public
	{
		bytes32       id;
		uint256       packedData;

		// Parse results
		(id, packedData) = decodeResults(_iexecDoracleGetVerifiedResult(_oracleCallID));

		// unpack data
		uint256   time = uint256(uint40(packedData>>0));
		uint256   data = uint256(uint216(packedData>>40));

		// Process results
		// always require newer time 
		require(txHash[id].time < time, "tx-exists");
		// there should only ever be 1 entry per tx
		emit TxUpdated(id, _oracleCallID, data, time);
		
		txHash[id].oracleCallID = _oracleCallID;
		txHash[id].amount       = data;
		txHash[id].time         = time;
	}

	}