// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

library util {
    function filterFunc(
        int256[] memory self,
        function(int256) pure returns (uint256) f
    ) internal pure returns (uint256[] memory newArr) {
        uint256[] memory tempArr = new uint256[](self.length + 1);

        for (uint256 i = 0; i < self.length; i++) {
            if (self[i] > 0) {
                tempArr[tempArr.length - 1] = tempArr[tempArr.length - 1] + 1;
                tempArr[tempArr[tempArr.length - 1] - 1] = f(self[i]);
            }
        }

        newArr = new uint256[](tempArr[tempArr.length - 1]);
        for (uint256 j = 0; j < newArr.length; j++) {
            newArr[j] = tempArr[j];
        }
    }
}

contract MyContract {
    using util for int256[];

    function getPositiveAndSquare(int256[] memory arr)
        public
        pure
        returns (uint256[] memory)
    {
        return arr.filterFunc(square);
    }

    function square(int256 val) public pure returns (uint256) {
        return uint256(val * val);
    }
}
