const {ethers, upgrades} = require('hardhat');

async function main() {
  const CONTRACT = 'BEP20Token';
  const ADDRESS = '0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512'; // Contract address
  console.log(`${CONTRACT} upgrading to ${ADDRESS}`);

  const Contract = await ethers.getContractFactory(CONTRACT);
  await upgrades.upgradeProxy(ADDRESS, Contract, {kind: 'uups'});
  // await upgrades.forceImport(ADDRESS, Contract, {kind: 'uups'}); // If error, use this instead upgradeProxy
  console.log(`${CONTRACT} upgraded`);
}

main().then(() => process.exit(0)).catch(error => {
  console.error(error);
  process.exit(1);
});
