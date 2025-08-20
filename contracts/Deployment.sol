// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract RegularDeploy {
    // Returns the address of the newly deployed contract
    function deploy(
        address _owner,
        uint _foo,
        bytes32 _salt
    ) public payable returns (address) {
        return address(new MockContract{salt: _salt}(_owner, _foo));
    }
}

contract Create2Deploy {
    event Deployed(address addr, uint salt);

    function getBytecode(address _owner, uint _foo) public pure returns (bytes memory) {
        bytes memory bytecode = type(MockContract).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_owner, _foo));
    }

    function deploy(bytes memory bytecode, uint _salt) public payable {
        address addr;

        assembly {
            addr := create2(
                callvalue(), // wei sent with current call
                add(bytecode, 0x20),
                mload(bytecode), 
                _salt 
            )

            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }

        emit Deployed(addr, _salt);
    }
}

contract MockContract {
    address public owner;
    uint public foo;

    constructor(address _owner, uint _foo) payable {
        owner = _owner;
        foo = _foo;
    }

    function getBalance() public onlyOwner view returns (uint) {
        return address(this).balance;
    }

     modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }
}
