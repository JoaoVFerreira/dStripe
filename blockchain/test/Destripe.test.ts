import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("Destripe", function () {
  async function deployOneYearLockFixture() {
    const [owner, otherAccount] = await hre.ethers.getSigners();
    const Destripe = await hre.ethers.getContractFactory("Destripe");
    const destripe = await Destripe.deploy()

    return { destripe, owner, otherAccount };
  }

  it('', () => {

  })
});
