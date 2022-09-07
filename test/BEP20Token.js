require('@nomicfoundation/hardhat-chai-matchers');
const {loadFixture} = require('@nomicfoundation/hardhat-network-helpers');
const {expect} = require('chai');

describe('BEP20 Token', function () {
  async function fixture() {
    const totalSupply = 100000000000000000000n;
    const amount = 1000n;
    const Token = await ethers.getContractFactory('BEP20Token');
    const token = await upgrades.deployProxy(Token, {kind: 'uups'});

    const [owner, addr1, addr2] = await ethers.getSigners();
    return {token, totalSupply, amount, owner, addr1, addr2};
  }

  it("Should put coins in owner's account", async function () {
    const {token, totalSupply, owner} = await loadFixture(fixture);

    expect(await token.balanceOf(owner.address)).to.equal(totalSupply);
    expect(await token.totalSupply()).to.equal(totalSupply);
  });

  it('Should send coin dirrectly', async function () {
    const {token, amount, owner, addr1} = await loadFixture(fixture);
    const fromBalance = BigInt(await token.balanceOf(owner.address));
    const toBalance = BigInt(await token.balanceOf(addr1.address));

    await token.transfer(addr1.address, amount);

    expect(await token.balanceOf(owner.address)).to.equal(fromBalance - amount);
    expect(await token.balanceOf(addr1.address)).to.equal(toBalance + amount);
  });

  it('Should send coin correctly', async function () {
    const {token, amount, owner, addr2} = await loadFixture(fixture);
    const fromBalance = BigInt(await token.balanceOf(owner.address));
    const toBalance = BigInt(await token.balanceOf(addr2.address));

    await token.increaseAllowance(owner.address, 5000);
    await token.transferFrom(owner.address, addr2.address, amount);

    expect(await token.balanceOf(owner.address)).to.equal(fromBalance - amount);
    expect(await token.balanceOf(addr2.address)).to.equal(toBalance + amount);
  });

  it('Mint emits an event', async function () {
    const {token, amount, addr1} = await loadFixture(fixture);

    await expect(token.mint(addr1.address, amount)).to.emit(token, 'Transfer')
      .withArgs('0x0000000000000000000000000000000000000000', addr1.address, amount);
  });

  it('Non owner can not mint', async function () {
    const {token, amount, addr1, addr2} = await loadFixture(fixture);

    await expect(token.connect(addr1).mint(addr2.address, amount)).to.be.reverted;
  });
});
