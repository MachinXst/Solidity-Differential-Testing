# Differential testing
This compares two different implementations of the same application to identify potential issues.
For more info on Differential tests, check out
`https://getfoundry.sh/forge/advanced-testing/differential-ffi-testing/#differential-testing`

## Technology Stack & Dependencies

- Solidity (Writing Smart Contract)
- Javascript (Game interaction)
- [NodeJS](https://nodejs.org/en/) To create hardhat project and install dependencis using npm

### 1. Clone/Download the Repository

### 2. Install Dependencies:

```
npm install
```
### 3. Run tests
```
npx hardhat test test/deployment.js
```
The deployment.js test should fail due to the RegularDeploy and Create2Deploy not being the same contract.
In the deployment test script, you can console.log the output of the comparison test block by
commenting out `//` the expect line at the bottom, and adding

`console.log(regularDeploy.address)
 console.log(create2Deploy.address)`

The output should return two different addresses, which in part shows what's causing the test to fail, however
the new console.log lines will show the test is now passing.
```
npx hardhat test test/hashing.js
```
The hashing.js test should pass as both example contracts have the same output.