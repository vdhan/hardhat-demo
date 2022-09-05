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
npx hardhat console --network localhost
npx hardhat test
```

Upgrade contract

```shell
npx hardhat run --network localhost scripts/upgrade.js
```

Deploy testnet

```shell
npx hardhat run --network testnet scripts/deploy.js
```

Proxy address: 0x3b0c224538e323616Ba25344E3eDF81c9B71f014
Contract address: 0x139072bEbfF70bD0fa38251aE6f6827c075CeFDD

Verify contract

```shell
npx hardhat verify --network testnet {contract-address}
```