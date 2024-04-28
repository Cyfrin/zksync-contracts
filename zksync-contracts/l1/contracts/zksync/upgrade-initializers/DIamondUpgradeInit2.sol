// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "../Config.sol";
import "../facets/Mailbox.sol";
import "../libraries/Diamond.sol";
import "../../common/libraries/L2ContractHelper.sol";
import "../../common/L2ContractAddresses.sol";

interface IOldContractDeployer {
    function forceDeployOnAddress(
        bytes32 _bytecodeHash,
        address _newAddress,
        bytes calldata _input
    ) external payable returns (address);
}

/// @author Matter Labs
contract DiamondUpgradeInit2 is MailboxFacet {
    function forceDeploy2(
        bytes calldata _upgradeDeployerCalldata,
        bytes calldata _upgradeSystemContractsCalldata,
        bytes[] calldata _factoryDeps
    ) external payable returns (bytes32) {
        // 1. Update bytecode for the deployer smart contract
        _requestL2Transaction(
            L2_FORCE_DEPLOYER_ADDR,
            L2_DEPLOYER_SYSTEM_CONTRACT_ADDR,
            0,
            _upgradeDeployerCalldata,
            72000000,
            REQUIRED_L2_GAS_PRICE_PER_PUBDATA,
            _factoryDeps,
            true,
            address(0)
        );

        // 2. Redeploy other contracts by one transaction
        _requestL2Transaction(
            L2_FORCE_DEPLOYER_ADDR,
            L2_DEPLOYER_SYSTEM_CONTRACT_ADDR,
            0,
            _upgradeSystemContractsCalldata,
            72000000,
            REQUIRED_L2_GAS_PRICE_PER_PUBDATA,
            _factoryDeps,
            true,
            address(0)
        );

        return Diamond.DIAMOND_INIT_SUCCESS_RETURN_VALUE;
    }
}
