export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'getPuzzle' : IDL.Func([], [IDL.Vec(IDL.Nat)], ['query']),
    'isSolved' : IDL.Func([], [IDL.Bool], ['query']),
    'makeMove' : IDL.Func([IDL.Nat], [IDL.Bool], []),
    'newPuzzle' : IDL.Func([], [IDL.Vec(IDL.Nat)], []),
  });
};
export const init = ({ IDL }) => { return []; };
