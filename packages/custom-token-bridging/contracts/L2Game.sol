// SPDX-License-Identifier: Apache-2.0

pragma solidity ^0.6.11;

import "@openzeppelin/contracts/token/ERC20/ERC20Capped.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract L2Game is Ownable {
    ERC20Capped L2BotzToken;

    uint public bookieBalance;
    
    // what the game keeps if user loses
    mapping (address => uint) userBets;

    // what they get if user wins
    mapping (address => uint) userPayouts;
     
    // owner is the server
    constructor(address l2BotzToken_) public {
        L2BotzToken = ERC20Capped(l2BotzToken_);
    }

    // modifier bettingPaused() {
    //     require(beeting)
    // }


    // batched by the server
    // this contract needs to get approval of L2Token to move funds
    function bet(address[] calldata addresses, uint[] calldata amounts, uint[] calldata payouts) public onlyOwner {
        require(addresses.length == amounts.length && addresses.length > 0, "bad length");

        for (uint i; i < addresses.length; i++) {
            bool ret = L2BotzToken.transferFrom(addresses[i], address(this), amounts[i]);
            require(ret, "transfer failed");

            userBets[addresses[i]] += amounts[i];
        }

    } 

    function payouts() public onlyOwner {

    }
}
