import { Network, Alchemy } from "alchemy-sdk"
import { ethers } from "ethers"

class L2Operations {
  private alchemy: Alchemy

  constructor() {
    const settings = {
      apiKey: process.env.ALCHEMY_API_KEY,
      network: Network.MATIC_AMOY, // Using Polygon Amoy testnet
    }
    this.alchemy = new Alchemy(settings)
  }

  async getLatestBlockNumber(): Promise<number> {
    return await this.alchemy.core.getBlockNumber()
  }

  async createL2Address(): Promise<string> {
    const wallet = ethers.Wallet.createRandom()
    return wallet.address
  }

  async getL2Balance(address: string): Promise<string> {
    const balance = await this.alchemy.core.getBalance(address)
    return ethers.utils.formatEther(balance)
  }

  async sendL2Transaction(from: string, to: string, amount: string): Promise<string> {
    const tx = {
      to: to,
      value: ethers.utils.parseEther(amount),
    }

    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY!, this.alchemy.core.getProvider())
    const sentTx = await wallet.sendTransaction(tx)
    return sentTx.hash
  }
}

export const l2Operations = new L2Operations()

