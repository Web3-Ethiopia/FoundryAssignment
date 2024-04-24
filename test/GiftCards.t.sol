// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {UserSignup} from "../src/UserSignup.sol";
import {IUserSignup} from "../src/packages/interfaces/IUserSignup.sol";

contract CounterTest is Test {
   
        UserSignup public signUpContract;
        IUserSignup public interfaceMain;
        
   

    function setUp() public {
        // vm.
        signUpContract = new UserSignup();
        interfaceMain = IUserSignup(address(signUpContract));
        // console.log(tx.origin);
    }

    // function testFuzz_addUser() public {
    //     // vm.prank(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);
    //     interfaceMain.signup("Rishabh", "rishabh.3172000@gmail.com");
    //     assert(signUpContract.getActiveGiftCardsForUser(msg.sender).length == 3);
    //     assert(signUpContract.getUserByAddress(0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496).id < 2);
    //     // assert(signUpContract.getUserById(1).caller==0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496);
    //     // vm.stopPrank();
    // }
    // address[] public userData;

    // / forge-config: default.fuzz.runs = 10000
    // / forge-config: default.fuzz.max-test-rejects = 50

    // function test_UserByID(address _randomSigners) public {
    //     // --- snip ---
    //     vm.startPrank(_randomSigners);
    //     interfaceMain.signup("OtherID", "rishabh.3172000@gmail.com");
    //     // console.log(_randomSigners);
    //     // interfaceMain.signup("OtherID2", "rishabh.3172000@gmail.com");
    //     // vm.startPrank(0x2e63dCfeFb818986d01ff5cfaE35905903A87913);
    //     // interfaceMain.signup("OtherID2", "rishabh.3172000@gmail.com");
    //     // string memory empty;
    //     assert(signUpContract.getUserByAddress(_randomSigners).id != 0);
    //     // vm.stopPrank();
    // }

    //20 tokens // 2% //0.2% -

    function invariantTest_sequentialIDs() public {
        
        // vm.prank(msg.sender);
        interfaceMain.signup("1", "rishabh.3172000@gmail.com");
        vm.startPrank(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);
        uint256 lastID = interfaceMain.getUserID() - 1;
        vm.startPrank(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
        console.log(lastID);


        // assert(lastID>0);
        for (uint256 i = 1; i <= lastID; i++) {
            console.log(i);
            address userAddress = interfaceMain.getUserById(i);
            console.log(userAddress);
            UserSignup.User memory OurUser = interfaceMain.getUserByAddress(userAddress);
            console.log(OurUser.id);

            assert(i == OurUser.id);
        }
    }

    // function run() public {
    //     // testFuzz_addUser();
    //     invariantTest_sequentialIDs();
    // }
}
