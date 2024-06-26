// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
        require(users[msg.sender].id == 0, "User already signed up");
        address[3] memory arrayToUse = [address(10), address(20), address(30)];

        nextUserId++;
        users[msg.sender] = User(nextUserId, name, email, arrayToUse, msg.sender);
        userIdToAddress[nextUserId] = msg.sender; // Map user id to account address

        emit UserSignedUp(nextUserId, name, email);
    }

    function getUserById(uint256 id) public view returns (address) {
        require(id > 0 && id <= nextUserId, "Invalid user id");
        return userIdToAddress[id];
    }

    function getUserByAddress(address userAddress) public view returns (uint256) {
        require(users[userAddress].id > 0, "User does not exist");
        return users[userAddress].id;
    }

    // function offChainComputerData(paramsOffchain){

    // }

    function getAllUsers() public view returns (User[] memory) {
        User[] memory userList = new User[](nextUserId);
        for (uint256 i = 1; i <= nextUserId; i++) {
            userList[i - 1] = users[userIdToAddress[i]];
        }
        return userList;
    }

    function getActiveGiftCardsForUser(address userAddress) public view returns (address[3] memory) {
        return users[userAddress].ActiveGiftCards;
    }
}
