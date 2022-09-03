require('@nomiclabs/hardhat-ethers');
require('@nomiclabs/hardhat-etherscan');
require('@openzeppelin/hardhat-upgrades');

const {mnemonic, bscScan} = require('./env.json');

module.exports = {
  etherscan: {apiKey: bscScan},

  networks: {
    testnet: {
      url: 'https://data-seed-prebsc-1-s1.binance.org:8545',
      accounts: {mnemonic: mnemonic}
    },

    mainnet: {
      url: 'https://bsc-dataseed.binance.org/',
      accounts: {mnemonic: mnemonic}
    }
  },

  solidity: '0.8.9'
};
