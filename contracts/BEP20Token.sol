// SPDX-License-Identifier: GPL-3.0-or-later
/// @author Vũ Đắc Hoàng Ân
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "./BEP20Upgradable.sol";

contract BEP20Token is Initializable, BEP20Upgradable, OwnableUpgradeable, PausableUpgradeable, UUPSUpgradeable {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /// @dev update here for new token
    function initialize() public initializer {
        __BEP20_init_unchained("Citrine", "CTTK");
        __Ownable_init_unchained();
        __Pausable_init_unchained();
        __UUPSUpgradeable_init();

        _mint(msg.sender, 10000000000 * 10 ** decimals());
    }

    function decimals() public pure override returns (uint8) {
        return 10;
    }

    function getOwner() public view override returns (address) {
        return owner();
    }

    function mint(address to, uint amount) public onlyOwner returns (bool) {
        _mint(to, amount);
        return true;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint amount) internal override whenNotPaused {
        super._beforeTokenTransfer(from, to, amount);
    }

    function _authorizeUpgrade(address) internal override onlyOwner {}
}
