require('@nomicfoundation/hardhat-chai-matchers');
const {loadFixture} = require('@nomicfoundation/hardhat-network-helpers');
const {expect} = require('chai');

describe('BEP20 Token', function () {
  async function fixture() {
    const totalSupply = 1000000000000000000n;
    const Token = await ethers.getContractFactory('BEP20Token');
    const token = await upgrades.deployProxy(Token, {kind: 'uups'});

    const [owner, addr1, addr2] = await ethers.getSigners();
    return {token, totalSupply, owner, addr1, addr2};
  }

  it('Initial coin', async function () {
    const {token, totalSupply, owner} = await loadFixture(fixture);

    expect(await token.balanceOf(owner.address)).to.equal(totalSupply);
    expect(await token.totalSupply()).to.equal(totalSupply);
  });

  it('Should send coin dirrectly', async function () {
    const {token, owner, addr1} = await loadFixture(fixture);
    const amount = 2000;
    let balance1start = await token.balanceOf(owner.address);
    let balance2start = await token.balanceOf(addr1.address);
    balance1start = (balance1start - amount).toString();
    balance2start = (balance2start + amount).toString();

    await token.transfer(addr1.address, amount);

    expect(await token.balanceOf(owner.address)).to.equal(balance1start);
    expect(await token.balanceOf(addr1.address)).to.equal(balance2start);
  });

  it('Should send coin correctly', async function () {
    const {token, owner, addr2} = await loadFixture(fixture);
    const amount = 1000;
    let balance1start = await token.balanceOf(owner.address);
    let balance2start = await token.balanceOf(addr2.address);
    balance1start = (balance1start - amount).toString();
    balance2start = (balance2start + amount).toString();

    await token.increaseAllowance(owner.address, 5000);
    await token.transferFrom(owner.address, addr2.address, amount);

    expect(await token.balanceOf(owner.address)).to.equal(balance1start);
    expect(await token.balanceOf(addr2.address)).to.equal(balance2start);
  });
});
