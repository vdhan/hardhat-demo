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

Contract address: 0xb46De0A4AD2Ef64b6008d554d9Cc3b9Bd8784252

Verify contract

```shell
npx hardhat verify --network testnet {contract-address}
```

Upgrade contract

```shell
npx hardhat run --network localhost scripts/upgrade.js
```