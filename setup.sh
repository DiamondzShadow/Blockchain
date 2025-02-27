#!/bin/bash

# Update package list and install Node.js and npm
sudo apt update
sudo apt install -y nodejs npm

# Install Yarn
sudo npm install -g yarn

# Create project directory
mkdir -p diamondz-shadow
cd diamondz-shadow

# Initialize project and install dependencies
yarn init -y
yarn add @eth-optimism/core-utils@0.12.0 @eth-optimism/contracts@0.6.0 alchemy-sdk@3.6.3 dotenv@16.0.3 ethers@5.7.2 express@4.18.2 googleapis@118.0.0
yarn add -D @types/express@4.17.17 @types/node@18.15.11 ts-node@10.9.1 typescript@5.0.4

# Create tsconfig.json
cat > tsconfig.json << EOL
{
  "compilerOptions": {
    "target": "es2020",
    "module": "commonjs",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules"]
}
EOL

# Create src directory and necessary files
mkdir -p src
touch src/DiamondToken.ts src/consensus.ts src/chain.ts src/server.ts src/block.ts src/transaction.ts

# Create .env file for environment variables
cat > .env << EOL
YOUTUBE_API_KEY=your_youtube_api_key_here
PORT=3000
L1_RPC_URL=https://sepolia.infura.io/v3/your_infura_project_id
ALCHEMY_API_KEY=your_alchemy_api_key_here
DEPLOYER_ADDRESS=your_deployer_address_here
EOL

echo "Setup complete. Please update the .env file with your actual API keys and addresses."

