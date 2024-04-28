# zksync-contracts

A minimal repo that is a copy of the npm package [@matterlabs/zksync-contracts](https://www.npmjs.com/package/@matterlabs/zksync-contracts).

Everyday at 3AM, the latest version of the package is updated here, this way, you can use the zkSync contracts with foundry without having to use npm/yarn. This also makes other third party packages like Brownie and Ape easier to work with. 

## Usage

### Foundry

1. Run this in your projects root directory.

```bash
forge install cyfrin/zksync-contracts --no-commit
```

2. Then, update your `foundry.toml` to include the following in the `remappings`.

```
remappings = [
  '@matterlabs/zksync-contracts/=lib/zksync-contracts/',
]
```

