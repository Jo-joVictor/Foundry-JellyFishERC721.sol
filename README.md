# JellyFish NFT Collection

An ERC721 NFT collection built with Solidity and Foundry featuring dynamic metadata that automatically cycles between three different states every 15 seconds, creating an animated NFT experience.

## Features

- **ERC721 Standard**: Full compliance with ERC721 NFT standard
- **Dynamic Metadata**: Automatically switches between 3 different metadata files every 15 seconds
- **Owner-only Minting**: Only contract owner can mint new tokens
- **IPFS Storage**: All metadata and images stored on IPFS via Pinata
- **Ownership Transfer**: Transferable contract ownership
- **Sequential Token IDs**: Tokens minted with incrementing IDs starting from 0
- **Safe Minting**: Uses OpenZeppelin's safe mint pattern

## Quick Start

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Installation

```bash
git clone <your-repo-url>
cd jellyfish-nft
forge install
```

### Environment Setup

Create a `.env` file:
```bash
PRIVATE_KEY=your_private_key
SEPOLIA_RPC_URL=your_sepolia_rpc_url
ETHERSCAN_API_KEY=your_etherscan_api_key
CONTRACT_ADDRESS=deployed_contract_address
```

## Usage

### Deploy Contract

```bash
# Deploy to local anvil
forge script script/DeployJellyFishNFT.s.sol --rpc-url http://localhost:8545 --broadcast

# Deploy to Sepolia testnet
forge script script/DeployJellyFishNFT.s.sol --rpc-url $SEPOLIA_RPC_URL --broadcast --verify
```

### Mint NFT

```bash
# Using mint script
forge script script/MintJellyFishNFT.s.sol --rpc-url $SEPOLIA_RPC_URL --broadcast

# Using cast directly
cast send <CONTRACT_ADDRESS> "mint(address)" <RECIPIENT_ADDRESS> --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY
```

### Interact with Contract

```bash
# Check total supply
cast call <CONTRACT_ADDRESS> "totalSupply()(uint256)" --rpc-url $SEPOLIA_RPC_URL

# Check owner of token
cast call <CONTRACT_ADDRESS> "ownerOf(uint256)(address)" <TOKEN_ID> --rpc-url $SEPOLIA_RPC_URL

# Get token URI (changes every 15 seconds)
cast call <CONTRACT_ADDRESS> "tokenURI(uint256)(string)" <TOKEN_ID> --rpc-url $SEPOLIA_RPC_URL

# Check balance of address
cast call <CONTRACT_ADDRESS> "balanceOf(address)(uint256)" <ADDRESS> --rpc-url $SEPOLIA_RPC_URL

# Transfer ownership
cast send <CONTRACT_ADDRESS> "transferOwnership(address)" <NEW_OWNER> --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY
```

## Contract Architecture

### Core Contract

- **JellyFishNFT.sol**: Main ERC721 contract with dynamic metadata

### Inheritance Structure

```
JellyFishNFT
├── ERC721 (OpenZeppelin)
└── Ownable (OpenZeppelin)
```

### Key Functions

- `mint(address to)`: Mint new NFT to specified address (owner only)
- `totalSupply()`: Returns total number of minted tokens
- `tokenURI(uint256 tokenId)`: Returns dynamic metadata URI that cycles every 15 seconds
- `ownerOf(uint256 tokenId)`: Returns owner of specific token
- `balanceOf(address owner)`: Returns number of tokens owned by address
- `transferOwnership(address newOwner)`: Transfer contract ownership
- `transferFrom(address from, address to, uint256 tokenId)`: Transfer NFT ownership

### Deployment Scripts

- **DeployJellyFishNFT.s.sol**: Deploys the NFT contract
- **MintJellyFishNFT.s.sol**: Mints NFT to deployer address

## Testing

Run the complete test suite:

```bash
# Run all tests
forge test

# Run with verbose output
forge test -vvv

# Run specific test
forge test --match-test test_Mint

# Generate coverage report
forge coverage
```

### Test Coverage

- **Initialization**: Contract name, symbol, and initial supply
- **Minting**: Successful mint and token ownership
- **Access Control**: Only owner can mint
- **Input Validation**: Reverts on zero address minting
- **Ownership Transfer**: Transfer and verify new owner can mint

## NFT Details

**JellyFish NFT (JELLY)**
- Name: JellyFish
- Symbol: JELLY
- Standard: ERC721
- Token ID: Sequential starting from 0
- Metadata: Dynamic, stored on IPFS

## Dynamic Metadata System

### How It Works

The `tokenURI` function returns different metadata based on the current block timestamp:

```solidity
uint256 index = (block.timestamp / 15) % 3;
```

- **Every 15 seconds**: Metadata switches to next state
- **3 Total States**: Cycles through 3 different JSON files
- **Automatic Rotation**: No manual intervention required

### Metadata Files

Each metadata file points to different IPFS-stored content:

**State 1 (0-14 seconds):**
```
ipfs://bafkreifdmrhseuxj76q6fcgzwjedc2stp2uiny73z2jayqm2ia4ihvglgu
```

**State 2 (15-29 seconds):**
```
ipfs://bafkreihrmkvo5ihl4ejf7opofrsyzgddk6ollw64y23jjngolnguuozbpe
```

**State 3 (30-44 seconds):**
```
ipfs://bafkreie2zjw6pzo72gzmwgneoaqxgqooqgj2qrmwdvvntqm6aek4unrlvq
```

### Example Metadata Structure

```json
{
  "name": "JellyFish #1",
  "description": "This is the first NFT stored on IPFS via Pinata!",
  "image": "bafkreifdmrhseuxj76q6fcgzwjedc2stp2uiny73z2jayqm2ia4ihvglgu",
  "attributes": [
    { "trait_type": "Color", "value": "Green" }
  ]
}
```

## Security Features

- **Owner-only Minting**: Prevents unauthorized token creation
- **Zero Address Check**: Prevents minting to invalid addresses
- **Safe Minting**: Uses OpenZeppelin's `_safeMint` for recipient validation
- **Ownership Control**: Ownable pattern for privileged functions
- **Existence Validation**: Token URI only returns for existing tokens

## IPFS Integration

### Storage via Pinata

All metadata and images are stored on IPFS using Pinata:

1. Upload images to IPFS via Pinata
2. Create JSON metadata files referencing image CIDs
3. Upload metadata files to IPFS
4. Reference metadata CIDs in contract

### Metadata Directory Structure

```
IMGs/
├── 1.json
├── 2.json
└── 3.json
```

Each JSON file contains NFT metadata including name, description, image CID, and attributes.

## Gas Optimization

- Sequential token ID counter instead of array storage
- Efficient existence check using counter comparison
- Minimal on-chain storage with IPFS references
- OpenZeppelin's optimized ERC721 implementation

## Use Cases

- **Animated NFTs**: Create dynamic visual experiences
- **Time-based Art**: NFTs that change based on time
- **Evolving Collections**: Collections that transform over time
- **Interactive Displays**: NFTs that cycle through different states
- **Storytelling**: Sequential narrative through metadata changes

## Marketplace Compatibility

The dynamic metadata is compatible with major NFT marketplaces:

- **OpenSea**: Metadata updates when viewing
- **Rarible**: Supports dynamic tokenURI
- **LooksRare**: Compatible with ERC721 standard
- **Foundation**: Standard ERC721 support

Note: Marketplace caching may delay metadata updates. Some platforms cache for several hours.

## Deployed Contracts

### Sepolia Testnet
- **JellyFishNFT Contract**: `0xB03120E2eAB687E8fd745bA272958C6FbdEEC280`

## Customization

### Changing Animation Speed

Modify the division factor in `tokenURI`:

```solidity
// Change from 15 seconds to 30 seconds
uint256 index = (block.timestamp / 30) % 3;

// Change to 60 seconds (1 minute)
uint256 index = (block.timestamp / 60) % 3;
```

### Adding More States

Increase the modulo and add more conditions:

```solidity
uint256 index = (block.timestamp / 15) % 5; // 5 states

if (index == 0) {
    return "ipfs://...1";
} else if (index == 1) {
    return "ipfs://...2";
} else if (index == 2) {
    return "ipfs://...3";
} else if (index == 3) {
    return "ipfs://...4";
} else {
    return "ipfs://...5";
}
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add comprehensive tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Resources

- [Foundry Documentation](https://book.getfoundry.sh/)
- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/)
- [ERC721 Token Standard](https://eips.ethereum.org/EIPS/eip-721)
- [IPFS Documentation](https://docs.ipfs.tech/)
- [Pinata Documentation](https://docs.pinata.cloud/)
- [Solidity Documentation](https://docs.soliditylang.org/)
