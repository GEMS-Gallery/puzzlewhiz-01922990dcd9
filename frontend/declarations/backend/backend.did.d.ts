import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface _SERVICE {
  'getPuzzle' : ActorMethod<[], Array<bigint>>,
  'isSolved' : ActorMethod<[], boolean>,
  'makeMove' : ActorMethod<[bigint], boolean>,
  'newPuzzle' : ActorMethod<[], Array<bigint>>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
