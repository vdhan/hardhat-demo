require('@nomicfoundation/hardhat-chai-matchers');
const {loadFixture} = require('@nomicfoundation/hardhat-network-helpers');
const {expect} = require('chai');

describe('BEP20 Token', function () {
  async function fixture() {
    const totalSupply = 100000000000000000n;
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
});
