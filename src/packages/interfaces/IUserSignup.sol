// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../../UserSignup.sol";

interface IUserSignup {
    // mapping(address => User) users;
    // mapping(uint256 => address)  userIdToAddress;
    function users() external returns (uint256, string memory, string memory, address[3] memory, address);

    function getUserID() external returns (uint256 currentIDinQueue);

    function signup(string memory name, string memory email) external;

    function getUserById(uint256 id) external view returns (address);

    function getUserByAddress(address userAddress) external view returns (UserSignup.User memory);

    // function getAllUsers() external view returns (User[] memory);

    function getActiveGiftCardsForUser(address userAddress) external returns (address[] memory);
}
