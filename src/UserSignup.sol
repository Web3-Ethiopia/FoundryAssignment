// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {console} from "forge-std/Test.sol";

contract UserSignup {
    struct User {
        uint256 id;
        string name;
        string email;
        address[3] ActiveGiftCards;
        address caller;
    }

    mapping(address => User) public users;
    mapping(uint256 => address) public userIdToAddress; // Mapping user id to account address
    uint256 public nextUserId;

    event UserSignedUp(uint256 id, string name, string email);

    function signup(string memory name, string memory email) public {
        require(bytes(name).length > 0, "Name is required");
        require(bytes(email).length > 0, "Email is required");
        require(users[msg.sender].id == 0 || users[msg.sender].id == 1, "User already signed up");
        address[3] memory arrayToUse = [address(10), address(20), address(30)];
        // console.log(users[msg.sender].id);
        nextUserId++;
        users[msg.sender] = User(nextUserId, name, email, arrayToUse, msg.sender);
        userIdToAddress[nextUserId] = msg.sender;

        emit UserSignedUp(nextUserId, name, email);
    }

    function getUserById(uint256 id) public view returns (address) {
        require(users[userIdToAddress[id]].id != 0, "User doesnt exist");
        return userIdToAddress[id];
    }

    function getUserID() public view returns (uint256) {
        return nextUserId;
    }

    function getUserByAddress(address userAddress) public view returns (User memory) {
        return users[userAddress];
    }

    function getActiveGiftCardsForUser(address userAddress) public view returns (address[3] memory) {
        return users[userAddress].ActiveGiftCards;
    }

    function setUserEmail(address userAddress, string memory _email) public returns (bool) {
        users[userAddress].email = _email;
        return true;
        // require(users[userAddress].email,"Email not updated");
    }

    function addActiveGiftCard(address userAddress, address _newGiftCard) public returns (bool) {
        users[userAddress].ActiveGiftCards[2] = _newGiftCard;
    }
}
