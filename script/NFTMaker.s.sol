import {Script, console} from "forge-std/Script.sol";
import {SingularNFTMaker} from "../src/NFTMaker.sol";
import {SingularNFTMaker2} from "../src/NFTMaker2.sol";

contract NFTMakerScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("ANVIL_ACCOUNT1");

        vm.startBroadcast(deployerPrivateKey);
        SingularNFTMaker mainContract;
        SingularNFTMaker2 mainContract2;
        uint8[] memory rarityArray = new uint8[](7);
        rarityArray[0] = 2;
        rarityArray[1] = 8;
        rarityArray[2] = 10;
        rarityArray[3] = 10;
        rarityArray[4] = 10;
        rarityArray[5] = 10;
        rarityArray[6] = 50;

        string[] memory uriArray = new string[](7);
        uriArray[0] = "xyz.com";
        uriArray[1] = "xyz.com";
        uriArray[2] = "xyz.com";
        uriArray[3] = "xyz.com";
        uriArray[4] = "xyz.com";
        uriArray[5] = "xyz.com";
        uriArray[6] = "xyz.com";

        // mainContract = new SingularNFTMaker{value: 1 ether}("M1", "M2 F9", rarityArray, uriArray);
        mainContract2 = new SingularNFTMaker2{value: 1 ether}("M1", "M2 F9", rarityArray, uriArray);
        address[] memory whiteListedAddresses = new address[](2);
        whiteListedAddresses[0] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        whiteListedAddresses[1] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;

        // mainContract.whiteListAddresses2(whiteListedAddresses);
        mainContract2.whiteListAddresses(whiteListedAddresses);
        mainContract2.whiteListAddresses2(whiteListedAddreGsses);

        // uint256 mint_price = mainContract.getMintPrice(whiteListedAddresses[0]);

        // mainContract.mintNew{value: mint_price}(whiteListedAddresses[0]);

        vm.stopBroadcast();
    }
}

//forge script script/NFTMaker.s.sol:NFTMakerScript --rpc-url http://127.0.0.1:8545 --broadcast

// cast send 0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0 "whiteListAddresses(address[])" [0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC] --rpc-url http://127.0.0.1:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
