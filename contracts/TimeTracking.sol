// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract TimeTracking {
    address public owner;

    struct DailyWork {
        uint256 date;
        uint256 hoursWorked;
    }

    mapping(address => DailyWork[]) public dailyWorks;

    event WorkLogged(address indexed user, uint256 indexed date, uint256 hoursWorked);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function logWork(uint256 hoursWorked) public {
        require(hoursWorked > 0, "Hours worked must be greater than 0");

        // Use the current timestamp as the date
        uint256 date = block.timestamp;

        dailyWorks[msg.sender].push(DailyWork(date, hoursWorked));
        emit WorkLogged(msg.sender, date, hoursWorked);
    }

    function getTotalHoursWorked() public view returns (uint256) {
        uint256 totalHours;

        for (uint256 i = 0; i < dailyWorks[msg.sender].length; i++) {
            totalHours += dailyWorks[msg.sender][i].hoursWorked;
        }

        return totalHours;
    }

    function getDailyWorksCount() public view returns (uint256) {
        return dailyWorks[msg.sender].length;
    }

    // Owner can transfer ownership to another address
    function transferOwnership(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}
