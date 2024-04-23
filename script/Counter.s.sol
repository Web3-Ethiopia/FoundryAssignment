// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
// import {UserSignup} from "../src/GiftCardsOnCelo.sol";
import {SingularNFTMaker} from "../src/NFTMaker.sol";

contract CounterScript is Script {
    function setUp() public {
        vm.startBroadcast(0x01bf0aea4b950576246d8931986691082a36fb5956355c3af178ce0fec892c87);
        //     SingularNFTMaker mainContract;
        //    uint8[] memory rarityArray=new uint8[](7);
        //     rarityArray[0]=2;
        //     rarityArray[1]=3;
        //     rarityArray[2]=5;
        //     rarityArray[3]=10;
        //     rarityArray[4]=15;
        //     rarityArray[5]=30;
        //     rarityArray[6]=35;

        //     string[] memory uriArray=new string[](7);
        //     uriArray[0]="xyz.com";
        //     uriArray[1]="xyz.com";
        //     uriArray[2]="xyz.com";
        //     uriArray[3]="xyz.com";
        //     uriArray[4]="xyz.com";
        //     uriArray[5]="xyz.com";
        //     uriArray[6]="xyz.com";
        //     mainContract = new SingularNFTMaker{value:1 ether}("NFT2","N1",rarityArray,uriArray);
    }

    function run() public {
        uint8[] memory rarityArray = new uint8[](7);
        rarityArray[0] = 2;
        rarityArray[1] = 3;
        rarityArray[2] = 5;
        rarityArray[3] = 10;
        rarityArray[4] = 15;
        rarityArray[5] = 30;
        rarityArray[6] = 35;

        string[] memory uriArray = new string[](7);
        uriArray[0] = "xyz.com";
        uriArray[1] = "xyz.com";
        uriArray[2] = "xyz.com";
        uriArray[3] = "xyz.com";
        uriArray[4] = "xyz.com";
        uriArray[5] = "xyz.com";
        uriArray[6] = "xyz.com";
        // vm.broadcast();
        // vm.prank(msgSender);
        // vm.addr(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);
        SingularNFTMaker mainContract;

        mainContract = new SingularNFTMaker{value: 1 ether}("NFT2", "N1", rarityArray, uriArray);

        // vm.getDeployedCode("GiftCardsOnCelo.sol/UserSignup.json");
        address[] memory whiteListArray = new address[](2);
        whiteListArray[0] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        whiteListArray[1] = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        mainContract.whiteListAddresses(whiteListArray);
        uint256 price = mainContract.getMintPrice(whiteListArray[0]);
        vm.startBroadcast(0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d);
        // vm.addr(0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d);
        mainContract.mintNew{value: price}(whiteListArray[0]);
    }
}
