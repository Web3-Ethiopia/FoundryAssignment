// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../src/NFTMaker.sol";
import {Test, console} from "forge-std/Test.sol";

contract TestNFTMaker is Test {
    SingularNFTMaker public signUpContract;
    address public constant owner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    function setUp() public {
        // interfaceMain=IUserSignup(address(signUpContract));
        // vm.startPrank(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);
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

        vm.startPrank(owner);
        vm.deal(owner, 10 ether);

        signUpContract=new SingularNFTMaker{value: 1 ether}("NFT2", "N1", rarityArray, uriArray);
        // console.log(address(signUpContract));
    }

    function testWhiteList() public {
        
        // console.log(balanceOf(msg.sender));
        // address owner = msg.sender;

        
        // console.log(owner.balance);
        // SingularNFTMaker signUpContract = new SingularNFTMaker{value: 1 ether}("NFT2", "N1", rarityArray, uriArray);
        address[] memory whiteListArray = new address[](2);
        whiteListArray[0] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        whiteListArray[1] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;


        signUpContract.whiteListAddresses(whiteListArray);
        vm.startPrank(0x90F79bf6EB2c4f870365E785982E1f101E93b906);
        vm.deal(0x90F79bf6EB2c4f870365E785982E1f101E93b906, 10 ether);
        uint256 price=signUpContract.getMintPrice(whiteListArray[0]);
        
        (bool success) = signUpContract.mintNew{value:price}(whiteListArray[0]);
     
        assert(success);
    }

    function invariantWhitelistRemoval() public {
        address[] memory whiteListArray = new address[](4);
        whiteListArray[0] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        whiteListArray[1] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
        whiteListArray[2] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
        whiteListArray[3] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
        signUpContract.whiteListAddresses(whiteListArray);
        uint256 countBeforeMint=signUpContract.countApproved(whiteListArray[1]);
        console.log(countBeforeMint);
        uint256 mintPrice=signUpContract.getMintPrice(whiteListArray[1]);
        vm.startPrank(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        vm.deal(0x70997970C51812dc3A010C7d01b50e0d17dc79C8, 1000000000);
        signUpContract.mintNew{value:mintPrice}(whiteListArray[1]);
        assert(countBeforeMint-1==signUpContract.countApproved(whiteListArray[1]));
    }


    function invariantApprovedCanMint() public {
        address[] memory whiteListArray = new address[](2);
        whiteListArray[0] = 0x70997970C51812dc3A010C7d01b50e0d17dc79C8;
        whiteListArray[1] = 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC;
        

    }

    function testWhitelistFuzz(address[] memory _whitelistAddresses) public {
        signUpContract.whiteListAddresses(_whitelistAddresses);
        for(uint256 i=0; i<_whitelistAddresses.length; i++){
            if(_whitelistAddresses[i]!=address(0)){
            console.log(signUpContract.isApproved(_whitelistAddresses[i]));
            assertTrue(signUpContract.isApproved(_whitelistAddresses[i]));
            uint256 mintPrice=signUpContract.getMintPrice(_whitelistAddresses[i]);
            assertTrue(signUpContract.mintNew{value:mintPrice}(_whitelistAddresses[i]));
            }
           
        }

    } 
}
