require('@nomiclabs/hardhat-ethers');
require('@nomiclabs/hardhat-etherscan');
require('@openzeppelin/hardhat-upgrades');
require('hardhat-gas-reporter');

const {mnemonic, bscScan, coinMarketCap, reportGas} = require('./env.json');

module.exports = {
  etherscan: {apiKey: bscScan},

  networks: {
    testnet: {
      url: 'https://data-seed-prebsc-1-s1.binance.org:8545',
      accounts: {mnemonic: mnemonic},
      gasPrice: 5000000000
    },

    mainnet: {
      url: 'https://bsc-dataseed.binance.org/',
      accounts: {mnemonic: mnemonic},
      gasPrice: 5000000000
    }
  },

  solidity: {
    version: '0.8.9',
    settings: {
      optimizer: {
        enabled: true
      }
    }
  },

  gasReporter: {
    enabled: reportGas ? true : false,
    currency: 'VND',
    token: 'BNB',
    gasPrice: 5,
    coinmarketcap: coinMarketCap
  }
};
