library rarityGen{
    function generateRandgedRarityIndex(
        address addr
    ) internal view returns (uint8) {
        uint256 rand = uint256(
            keccak256(abi.encodePacked(block.timestamp, addr, block.difficulty))
        ) % 100;
        return uint8(rand + 1);
    }
}