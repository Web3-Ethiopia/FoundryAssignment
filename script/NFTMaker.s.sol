import {Script, console} from "forge-std/Script.sol";
import {SingularNFTMaker} from "../src/NFTMaker.sol";

contract NFTMakerScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("BNB_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        SingularNFTMaker mainContract;
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

        mainContract = new SingularNFTMaker{value: 1000000}("M1", "M2 F9", rarityArray, uriArray);
        address[] memory whiteListedAddresses = new address[](2);
        whiteListedAddresses[0] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        whiteListedAddresses[1] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;

        mainContract.whiteListAddresses(whiteListedAddresses);

        // uint256 mint_price = mainContract.getMintPrice(whiteListedAddresses[0]);

        // mainContract.mintNew{value: mint_price}(whiteListedAddresses[0]);

        vm.stopBroadcast();
    }
}
