import Bool "mo:base/Bool";
import Func "mo:base/Func";

import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Random "mo:base/Random";

actor PuzzleGame {
  // The size of the puzzle grid
  let SIZE : Nat = 3;
  
  // The current state of the puzzle
  stable var puzzle : [var Nat] = Array.init(SIZE * SIZE, 0);

  // Function to generate a new puzzle
  public func newPuzzle() : async [Nat] {
    let numbers = Array.tabulate<Nat>(SIZE * SIZE, func(i) = i);
    var shuffled = Array.thaw<Nat>(numbers);

    for (i in Iter.range(0, SIZE * SIZE - 1)) {
      let randomBytes = await Random.blob();
      let j = Random.rangeFrom(8, randomBytes) % (SIZE * SIZE);
      let temp = shuffled[i];
      shuffled[i] := shuffled[j];
      shuffled[j] := temp;
    };

    puzzle := shuffled;
    return Array.freeze(puzzle);
  };

  // Function to make a move
  public func makeMove(index : Nat) : async Bool {
    let emptyIndex = Array.indexOf<Nat>(0, Array.freeze(puzzle), Nat.equal);
    
    switch (emptyIndex) {
      case (null) { return false; };
      case (?emptyPos) {
        if (isValidMove(index, emptyPos)) {
          let temp = puzzle[index];
          puzzle[index] := puzzle[emptyPos];
          puzzle[emptyPos] := temp;
          return true;
        } else {
          return false;
        };
      };
    };
  };

  // Helper function to check if a move is valid
  private func isValidMove(index : Nat, emptyPos : Nat) : Bool {
    let row1 = index / SIZE;
    let col1 = index % SIZE;
    let row2 = emptyPos / SIZE;
    let col2 = emptyPos % SIZE;

    (row1 == row2 and Int.abs(col1 - col2) == 1) or
    (col1 == col2 and Int.abs(row1 - row2) == 1)
  };

  // Function to check if the puzzle is solved
  public query func isSolved() : async Bool {
    for (i in Iter.range(0, SIZE * SIZE - 1)) {
      if (puzzle[i] != i) {
        return false;
      };
    };
    true
  };

  // Function to get the current puzzle state
  public query func getPuzzle() : async [Nat] {
    Array.freeze(puzzle)
  };
}
