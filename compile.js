const solc = require("solc");
const fs = require("fs");
const path = require("path");

const contractsDir = path.resolve(__dirname, "contracts");
const outputDir = path.resolve(contractsDir, "build");

if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

const contracts = ["ERC20.sol", "ERC721.sol", "ERC1155.sol"];

contracts.forEach((contractFile) => {
  const filePath = path.resolve(contractsDir, contractFile);
  const baseName = path.parse(contractFile).name; 

  if (!fs.existsSync(filePath)) {
    console.log(`Error: Contract file ${contractFile} not found!`);
    return;
  }

  const source = fs.readFileSync(filePath, "utf8");

  const input = {
    language: "Solidity",
    sources: {
      [contractFile]: {
        content: source,
      },
    },
    settings: {
      outputSelection: {
        "*": {
          "*": ["abi", "evm.bytecode"],
        },
      },
    },
  };

  const findImports = (importPath) => {
    try {
      const fullPath = path.resolve("node_modules", importPath);
      return {
        contents: fs.readFileSync(fullPath, "utf8"),
      };
    } catch (e) {
      return { error: "File not found: " + importPath };
    }
  };

  try {
    const output = JSON.parse(
      solc.compile(JSON.stringify(input), { import: findImports })
    );

    if (output.errors) {
      for (const error of output.errors) {
        console.warn(error.formattedMessage);
      }
    }

    if (!output.contracts || !output.contracts[contractFile]) {
      console.log(`Error: Compilation failed for ${contractFile}`);
      return;
    }

    const compiledContracts = output.contracts[contractFile];

    for (const name in compiledContracts) {
      const contract = compiledContracts[name];
      const abi = contract.abi;
      const bin = contract.evm.bytecode.object;

      fs.writeFileSync(
        path.resolve(outputDir, `${baseName}.abi.json`),
        JSON.stringify(abi, null, 2)
      );
      fs.writeFileSync(
        path.resolve(outputDir, `${baseName}.bin.json`),
        bin
      );
    }

    console.log(`Compiled: ${contractFile}`);
  } catch (err) {
    console.error(`Error compiling ${contractFile}:`, err);
  }
});

console.log("Compilation finished!");
