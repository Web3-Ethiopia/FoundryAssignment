contract SingularNFTMaker is ERC721URIStorage, Ownable {
    address creator = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    uint256 public constant MINT_PRICE = 1 gwei;
    mapping(address => uint8) private approvedAddresses;
    mapping(address whiteListedAddress => uint8 index) private rarityIndex;
    mapping(uint256 tokenId => uint256 tokenPrice) private pricesOfNfts;
    uint8[] private rarity;
    string[] private nftURIs;
    uint8[] private rangedRarity;
    uint256 private lastTokenId = 1;

    constructor(
        string memory nftName,
        string memory nftSymbol,
        uint8[] memory _rarity,
        string[] memory _nftURIs
    ) payable ERC721(nftName, nftSymbol) Ownable(msg.sender) {
        if (msg.value < MINT_PRICE) {
            payable(msg.sender).transfer(msg.value);
            assert(false);
        }

        require(
            rarity.length == nftURIs.length,
            "Rarity and nftURI need to have the same length"
        );
        uint8 sum = 0;
        for (uint256 i = 0; i < _rarity.length; i++) {
            require(_rarity[i] > 0, "Rarity values must be greator than zero");
            sum = sum + _rarity[i];
            rangedRarity.push(sum);
        }

        require(
            sum == uint8(100),
            string.concat(
                "Sum of rarities must equal 100, got:",
                Strings.toString(sum)
            )
        );

        require(payable(creator).send(MINT_PRICE), "Failed to transfer funds");
        rarity = _rarity;
        nftURIs = _nftURIs;
        // _mint(msg.sender, lastTokenId);
        // _setTokenURI(lastTokenId, nftTokenURI);
    }
    // M9
    // M2 F2

    // https://gateway.pinata.cloud/ipfs/QmWQbcyPiNHgWRqPUe1YTP476p9Y1qVomjME3tyDzNAkEe

    function whiteListAddresses(address[] memory addresses) public onlyOwner {
        for (uint256 index = 0; index < addresses.length; index++) {
            if (addresses[index] != address(0)) {
                approvedAddresses[addresses[index]] = approvedAddresses[addresses[index]]+1;
                rarityIndex[addresses[index]] = getRarityIndex(
                    generateRandgedRarityIndex(addresses[index])
                );
            }
        }
    }

    function isApproved(address nftOwner) public view returns (bool) {
        return approvedAddresses[nftOwner]>0;
    }

    function mintNew(address nftOwner) public payable returns (bool) {
        require(
            approvedAddresses[nftOwner]>0,
            "You have not been approved as an owner"
        );
        console.log(msg.sender);
        console.log(owner());
        require(
            payable(owner()).send(getMintPrice(nftOwner)),
            "Failed to transfer required funds"
        );
        uint256 currentTokenId = lastTokenId + 1;
        uint8 nftRarityIndex = rarityIndex[nftOwner];
        _mint(nftOwner, currentTokenId);
        _setTokenURI(currentTokenId, nftURIs[nftRarityIndex]);
        lastTokenId = currentTokenId;
        approvedAddresses[nftOwner] = approvedAddresses[nftOwner]-1;
        delete rarityIndex[nftOwner];
        return true;
    }

    function getMintPrice(address nftOwner) public view returns (uint256) {
        return MINT_PRICE / rarityIndex[nftOwner];
    }

    function generateRandgedRarityIndex(
        address addr
    ) private view returns (uint8) {
        uint256 rand = uint256(
            keccak256(abi.encodePacked(block.timestamp, addr, block.difficulty))
        ) % 100;
        return uint8(rand + 1);
    }

    function getRarityIndex(
        uint8 _rangedIndex
    ) private returns (uint8 _rarityIndex) {
        require(_rangedIndex > 0, "Randged Index must be greater than zero");
        for (uint256 i = 0; i < rangedRarity.length; i++) {
            if (_rangedIndex <= rangedRarity[i]) {
                return uint8(i);
            }
        }
        return uint8(rangedRarity.length - 1);
    }

    function setNftPrice(uint256 price,uint256 tokenId)public view returns (bool){
        require(_ownerOf(tokenId)==msg.sender,"You are not the owner of the NFT");
        pricesOfNfts[tokenId] = price;
        return true;
    }

    function getNftPrice(uint256 tokenId)public view returns(uint256){
        require(pricesOfNfts[tokenId]>0,"Nft Not for sale");
        return pricesOfNfts[tokenId];
    }

    function buyNft(uint256 tokenId) public payable returns(bool) {
        uint256 priceofNft = pricesOfNfts[tokenId];
        require(priceofNft > 0, "Nft Not for sale");
        require(msg.value < priceofNft, "Invalid Price");
        _transfer(ownerOf(tokenId), msg.sender, tokenId);
        payable(seller).transfer(msg.value); 
        pricesOfNfts[tokenId] = 0; 
        return true;
     
}