const hre = require("hardhat");
const { expect } = require('chai');

require('chai')
    .use(require('chai-as-promised'))
    .should()

describe("Differential tests", function () {

  let create2Deploy, regularDeploy
  let deployer, user

  beforeEach(async () => {
    [deployer, user] = await ethers.getSigners();

    const RegularDeploy = await ethers.getContractFactory("RegularDeploy");
    regularDeploy = await RegularDeploy.deploy();

    const Create2Deploy = await ethers.getContractFactory("Create2Deploy");
    create2Deploy = await Create2Deploy.deploy();
  })

  it("should compare Regular vs Create2 deploy", async function () {
    const user1 = await user.getAddress()
    const foo = 88;
    const salt = ethers.utils.randomBytes(32);

    const regularDeployOutput = await regularDeploy.deploy(user1, foo, salt);
    const bytecode = await create2Deploy.getBytecode(user1, foo);

    const create2DeployOutput = await create2Deploy.deploy(bytecode, salt);

    expect(regularDeployOutput).to.equal(create2DeployOutput);
  });

});