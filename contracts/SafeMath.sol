// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint a, uint b) internal pure returns (uint) {
        uint c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint a, uint b, string memory errMsg) internal pure returns (uint) {
        require(a >= b, errMsg);

        uint c = a - b;
        return c;
    }

    function sub(uint a, uint b) internal pure returns (uint) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function mul(uint a, uint b) internal pure returns (uint) {
        if (a == 0) {
            return 0;
        }

        uint c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint a, uint b, string memory errMsg) internal pure returns (uint) {
        require(b != 0, errMsg);

        uint c = a / b;
        return c;
    }

    function div(uint a, uint b) internal pure returns (uint) {
        return div(a, b, "SafeMath: division by 0");
    }

    function mod(uint a, uint b, string memory errMsg) internal pure returns (uint) {
        require(b != 0, errMsg);
        return a % b;
    }

    function mod(uint a, uint b) internal pure returns (uint) {
        return mod(a, b, "SafeMath: modulo by 0");
    }
}