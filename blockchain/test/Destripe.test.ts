import { time, loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Destripe", function () {
  async function deployFixture() {
    const DestripeCoin = await ethers.getContractFactory("DestripeCoin");
    const destripeCoin = await DestripeCoin.deploy();

    await destripeCoin.waitForDeployment();

    const DestripeCollection = await ethers.getContractFactory("DestripeCollection");
    const destripeCollection = await DestripeCollection.deploy();

    await destripeCollection.waitForDeployment();
    const collectionAddress = await destripeCollection.getAddress();

    const Destripe = await ethers.getContractFactory("Destripe");
    const coinAddress = await destripeCoin.getAddress();
    const destripe = await Destripe.deploy(coinAddress, collectionAddress);

    await destripe.waitForDeployment();
    const destripeAddress = await destripe.getAddress();

    await destripeCollection.setAuthorizedContract(destripeAddress);

    const [owner, otherAccount] = await ethers.getSigners();

    await destripeCoin.mint(otherAccount.address, ethers.parseEther("1"));

    return { destripe, destripeAddress, destripeCoin, coinAddress, destripeCollection, collectionAddress, owner, otherAccount };
  }

  it('Should do', async () => {
    const { destripe, destripeAddress, destripeCoin, otherAccount } = await loadFixture(deployFixture);
  })
});
