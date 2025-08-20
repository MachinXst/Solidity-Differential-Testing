const hre = require("hardhat");
const { expect } = require('chai');

require('chai')
    .use(require('chai-as-promised'))
    .should()

describe("Differential tests", function () {

  let hashing
  let deployer, user

  beforeEach(async () => {
    [deployer, user] = await ethers.getSigners();

    const Hashing = await ethers.getContractFactory("Hashing");
    hashing = await Hashing.deploy();
  })

  it("should compare the 2 different hashing methods", async function () {
    const user1 = await user.getAddress()
    const randomNumber = 235;
    const salt = ethers.utils.randomBytes(32);

    const output1 = await hashing.getMessageHash(user1, randomNumber, "someMessage", randomNumber);
    const output2 = await hashing.getMessageHash2(user1, randomNumber, "someMessage", randomNumber);

    expect(output1).to.equal(output2);
  });

});