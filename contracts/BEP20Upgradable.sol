// SPDX-License-Identifier: GPL-3.0-or-later
/// @author Vũ Đắc Hoàng Ân
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "./interface/IBEP20.sol";

contract BEP20Upgradable is Initializable, ContextUpgradeable, IBEP20 {
    string private _name;
    string private _symbol;
    uint private _totalSupply;
    uint[45] private __gap;

    mapping(address => uint) private _balances;
    mapping(address => mapping(address => uint)) private _allowances;

    function __BEP20_init(string memory token, string memory symbols) internal onlyInitializing {
        __BEP20_init_unchained(token, symbols);
    }

    function __BEP20_init_unchained(string memory token, string memory symbols) internal onlyInitializing {
        _name = token;
        _symbol = symbols;
    }

    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    /// @dev override to select a different value for {decimals}
    function decimals() public view virtual override returns (uint8) {
        return 8;
    }

    function totalSupply() public view override returns (uint) {
        return _totalSupply;
    }

    /// @dev override to return Ownable contract's owner() or implement yourself
    function getOwner() public view virtual override returns (address) {
        return address(0);
    }

    function transfer(address to, uint amount) public override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    function approve(address spender, uint amount) public override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint amount) public override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint) {
        return _allowances[owner][spender];
    }

    function balanceOf(address account) public view override returns (uint) {
        return _balances[account];
    }

    function increaseAllowance(address spender, uint addedValue) public returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint subtractedValue) public returns (bool) {
        address owner = _msgSender();
        uint currentAllowance = allowance(owner, spender);

        require(currentAllowance >= subtractedValue, "BEP20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    function burn(uint amount) public returns (bool) {
        _burn(_msgSender(), amount);
        return true;
    }

    function burnFrom(address account, uint amount) public returns (bool) {
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);

        return true;
    }

    function _transfer(address from, address to, uint amount) internal virtual {
        require(from != address(0), "BEP20: transfer from the zero address");
        require(to != address(0), "BEP20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint fromBalance = _balances[from];
        require(fromBalance >= amount, "BEP20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }

        _balances[to] += amount;
        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    function _mint(address account, uint amount) internal virtual {
        require(account != address(0), "BEP20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    function _burn(address account, uint amount) internal virtual {
        require(account != address(0), "BEP20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint accountBalance = _balances[account];
        require(accountBalance >= amount, "BEP20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }

        _totalSupply -= amount;
        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    function _approve(address owner, address spender, uint amount) internal virtual {
        require(owner != address(0), "BEP20: approve from the zero address");
        require(spender != address(0), "BEP20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _spendAllowance(address owner, address spender, uint amount) internal virtual {
        uint currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint).max) {
            require(currentAllowance >= amount, "BEP20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /// @dev Hook this is called before any transfer, include minting and burning
    function _beforeTokenTransfer(address from, address to, uint amount) internal virtual {}

    /// @dev Hook this is called after any transfer, include minting and burning
    function _afterTokenTransfer(address from, address to, uint amount) internal virtual {}
}
