// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EunoiaBridge is ERC20, ERC20Burnable, ERC20Snapshot, Ownable {
    constructor() ERC20("EunoiaBridge", "EB") {
        _mint(msg.sender, 20000000000 * 10 ** decimals());
    }

    function snapshot() public onlyOwner {
        _snapshot();
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Snapshot)
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function multiTransfer(address[] memory accounts, uint256[] memory amounts) public returns (bool) {

        require(accounts.length == amounts.length, "ERC20: lengths of two arrays are not equal");

        for(uint i = 0; i < accounts.length; i++) {
            _transfer(msg.sender, accounts[i], amounts[i]);
        }
        return true;
    }
}
