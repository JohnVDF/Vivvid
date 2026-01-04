// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ScheduleProcessor {
    
    // REFACTORING: Renamed custom errors to be more descriptive
    error BusinessClosed(uint256 providedTime);
    error OnBreak();

    // REFACTORING: Renamed function and arguments
    function checkDivisibility(uint256 val) public pure returns (string memory output) {
        
        // LOGIC CHANGE: 
        // 1. Used modulo 15 directly instead of (val % 3 == 0 && val % 5 == 0).
        // 2. Removed 'else' keywords. Since we 'return' immediately, 'else' is redundant.
        
        if (val % 15 == 0) {
            return "FizzBuzz";
        }
        
        if (val % 3 == 0) {
            return "Fizz";
        }
        
        if (val % 5 == 0) {
            return "Buzz";
        }

        // Default return if no conditions are met
        return "Splat";
    }

    // REFACTORING: Renamed function to 'getStatusByTime'
    function getStatusByTime(uint256 t) public pure returns (string memory status) {
        // LOGIC CHANGE: Inverted the assertion logic (visually)
        // !(t >= 2400) is the same as (t < 2400)
        assert(!(t >= 2400));

        // STRUCTURAL CHANGE: 
        // The original code checked for Errors first, then Success.
        // This version checks for Success first, then Errors. The outcome is identical.

        // 1. Check working hours (800 - 1199)
        if (t >= 800 && t < 1200) {
            return "Morning!";
        }

        // 2. Check afternoon hours (1300 - 1799)
        if (t >= 1300 && t < 1800) {
            return "Afternoon!";
        }

        // 3. Check evening hours (1800 - 2200)
        if (t >= 1800 && t <= 2200) {
            return "Evening!";
        }

        // 4. Handle Lunch Break (1200 - 1299)
        if (t >= 1200 && t < 1300) {
            revert OnBreak();
        }

        // 5. If we reached this point, the time is either < 800 or > 2200
        revert BusinessClosed(t);
    }
}