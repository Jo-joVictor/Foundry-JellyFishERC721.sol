# 🐙 Dynamic JellyFish NFT

A dynamic NFT that changes its metadata every 15 seconds!

## Features
- ⚡ ERC721 NFT with dynamic tokenURI
- 🔄 Cycles through 3 different images every 15 seconds
- 📍 Deployed on Sepolia testnet
- ✅ Verified on Etherscan

## Contract Address
`0xB03120E2eAB687E8fd745bA272958C6FbdEEC280` (Sepolia)

## Usage
```bash
# Deploy
forge script script/DeployJellyFishNFT.s.sol --broadcast

# Mint  
forge script script/MintJellyFishNFT.s.sol --broadcast

### 3. **Git Commands**
```bash
# Initialize if needed
git init

# Add files
git add .

# Commit
git commit -m "🐙 Add dynamic JellyFish NFT with time-based metadata cycling"

# Push to GitHub
git remote add origin https://github.com/yourusername/foundry-dynamic-nft.git
git branch -M main
git push -u origin main