# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

## For deploying local:

```shell
pnpm install
npx hardhat compile
npx hardhat node
```

Open other terminal tab

```shell
npx hardhat run --network localhost scripts/deploy.js
npx hardhat test
npx hardhat console --network localhost
npx hardhat run --network localhost scripts/index.js
```

Upgrade contract

```shell
npx hardhat run --network localhost scripts/upgrade.js
```

Deploy testnet

```shell
npx hardhat run --network testnet scripts/deploy.js
npx hardhat console --network testnet
```

Address: 0x2d68d08D2B1309f762B8933e880F354aB5Db301e

Verify contract

```shell
npx hardhat verify --network testnet {contract-address}
```