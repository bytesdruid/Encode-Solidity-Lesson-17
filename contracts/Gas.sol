// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Gas {
    uint256 public highScore;

    function loopActions(uint256 actions) public {
        while (actions > 1) {
            highScore += actions / (1 + highScore);
            actions--;
        }
    }

    uint256 highestNumber1;

    function updateNumber(uint256 countValue) public { // 1 mem read + 1 storage read + 1 comparison operation
        while (countValue > highestNumber1) {
            countValue--; // 1 mem write
            highestNumber1++; // 1 storage write
        }
    } // total ops: 5

    uint256 highestNumber2;

    function updateNumberOptimized(uint256 countValue) public { 
        uint256 number = highestNumber2; // 1 mem write
        while(countValue > number) // 1 mem read + 1 memory read + 1 comparison operation
        {
            countValue--; // 1 mem write
            number++; // 1 mem write
        }
        highestNumber2 = number; // 1 mem read + 1 storage write
    } // total ops: 8

    struct Packed {
        uint256 a;
        uint128 b;
        uint128 c;
        uint64 d;
        uint64 e;
        uint64 f;
        uint32 g;
        uint8 h;
        uint8 i;
        uint8 j;
        uint8 k;
    }

    struct Unpacked {
        uint128 b;
        uint8 h;
        uint64 d;
        uint8 k;
        uint256 a;
        uint64 e;
        uint128 c;
        uint8 j;
        uint64 f;
        uint8 i;
        uint32 g;
    }

    Packed[] packedObjectsArray;

    Unpacked[] unpackedObjectsArray;

    function createPacked() public {
        packedObjectsArray.push(
            Packed({
                a: 0,
                b: 0,
                c: 0,
                d: 0,
                e: 0,
                f: 0,
                g: 0,
                h: 0,
                i: 0,
                j: 0,
                k: 0
            })
        );
    }

    function createUnpacked() public {
        unpackedObjectsArray.push(
            Unpacked({
                a: 0,
                b: 0,
                c: 0,
                d: 0,
                e: 0,
                f: 0,
                g: 0,
                h: 0,
                i: 0,
                j: 0,
                k: 0
            })
        );
    }
}