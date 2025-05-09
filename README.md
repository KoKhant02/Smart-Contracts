# 📜 Smart Contracts

This repository documents my journey building, compiling, and interacting with Ethereum token standards — ERC-20, ERC-721, and ERC-1155 — on the **Sepolia** testnet. Contracts are written in Solidity, compiled with `solc`, and automatically converted into Go bindings using `abigen`.

---

## 🔹 ERC-20 Tokens  
### [ImpireZas (IZ)](https://sepolia.etherscan.io/token/0x8a3ed52ab81eebdb99a3205a52e5fbf692cb416e)  
Standard fungible token implementation on the Sepolia testnet.

---

## 🔸 ERC-721 (NFT) Contracts  
### [MeowjestyNFT (MJ)](https://sepolia.etherscan.io/token/0x2163138fad4ad344269fb373359ac43e32967a42)  
Non-fungible token (NFT) smart contract deployed to Sepolia.

---

## 🔺 ERC-1155 (Multi-Token) Contracts  
### [VariantVerse (VVT)](https://sepolia.etherscan.io/token/0x759d5e77ea5ae00614c93fa531e5b22797aef8fd)  
Multi-token standard supporting both fungible and non-fungible assets.

---

## ✨ Workflow

### 1. Contract Development
- Contracts are written in Solidity and placed under:  
```

/contracts/
├── ERC20.sol
├── ERC721.sol
└── ERC1155.sol

````

### 2. Compilation & Output Generation
- Use a custom `compile.js` script to:
- Compile contracts with `solc`.
- Automatically save output ABI and BIN in `/contracts/build`:
  ```
  build/
    ├── ERC20.abi.json
    ├── ERC20.bin.json
    ├── ERC721.abi.json
    ├── ERC721.bin.json
    ├── ERC1155.abi.json
    └── ERC1155.bin.json
  ```
- Output file names match the contract filenames (e.g., `ERC20.sol` ➝ `ERC20.abi.json`).

### 3. Go Bindings with abigen
- `abigen` is used to generate Go bindings for each contract:
- Inputs: `.abi.json` and `.bin.json`
- Output: Go files under `/contracts/go/`
  ```
  go/
    ├── ERC20.go
    ├── ERC721.go
    └── ERC1155.go
  ```
- Command used:
  ```bash
  abigen --bin=build/ERC20.bin.json --abi=build/ERC20.abi.json --pkg=contracts --out=go/ERC20.go
  ```

### 4. Go Integration
- Generated Go files are used in a Go backend project to interact with deployed smart contracts.
- Functions include minting, querying balances, and other contract interactions via Web3 clients.

---

## 🛠️ Tools & Technologies

- **Solidity** – Language for smart contracts  
- **solc** – Solidity compiler used via `compile.js`  
- **abigen** – Go-Ethereum tool for generating Go contract bindings  
- **Remix IDE** – Used during initial contract development  
- **Go** – Backend API interacting with smart contracts  

---

## 🌐 Deployment Network

All contracts are deployed to the **Sepolia** Ethereum testnet.

---

## 📌 How to Use

- View contracts via the Etherscan links above.
- Run the `compile.js` script to regenerate build outputs.
- Use `abigen` to regenerate Go files as needed.
- Integrate Go bindings into your Go project to interact with Ethereum smart contracts.

---

## 🚀 Future Plans

- Expand deployments to other networks (e.g., Polygon, Base).
- Add support for upgradeable contracts.
- Automate full CI/CD pipeline for contract deployment + Go binding generation.

---

📁 **Current Structure**:
````

contracts/
├── ERC20.sol
├── ERC721.sol
├── ERC1155.sol
├── build/
│   ├── ERC20.abi.json
│   ├── ERC20.bin.json
│   └── ...
└── go/
├── ERC20.go
└── ...

````

---

📬 Feel free to star or fork the repo if you find it useful!
