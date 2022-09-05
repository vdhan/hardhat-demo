const {ethers, upgrades} = require('hardhat');

async function main() {
  const CONTRACT = 'BEP20Token'; // Contract for deploying
  console.log(`${CONTRACT} deploying...`);

  const Contract = await ethers.getContractFactory(CONTRACT);
  const smartContract = await upgrades.deployProxy(Contract, {kind: 'uups'});
  console.log(`Contract deployed to address: ${smartContract.address}`);
}

main().then(() => process.exit(0)).catch(error => {
  console.error(error);
  process.exit(1);
});
