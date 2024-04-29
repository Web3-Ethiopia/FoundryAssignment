// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

library rarityGen{
    function generateRandgedRarityIndex(
        address addr
    ) public view returns (uint8) {
        uint256 rand = uint256(
            keccak256(abi.encodePacked(block.timestamp, addr, block.difficulty))
        ) % 100;
        return uint8(rand + 1);
    }

    function generateRandgedRarityIndex2(
        address addr
    ) internal view returns (uint8) {
        uint256 rand = uint256(
            keccak256(abi.encodePacked(block.timestamp, addr, block.difficulty))
        ) % 100;
        return uint8(rand + 1);
    }
}