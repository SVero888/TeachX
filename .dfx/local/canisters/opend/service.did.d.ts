import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export interface _SERVICE {
  'completePurchase' : ActorMethod<[Principal, Principal, Principal], string>,
  'getListedNFTs' : ActorMethod<[], Array<Principal>>,
  'getListingPrice' : ActorMethod<[Principal], bigint>,
  'getOpenDCanisterId' : ActorMethod<[], Principal>,
  'getOriginalOwner' : ActorMethod<[Principal], Principal>,
  'getOwnedNFTs' : ActorMethod<[Principal], Array<Principal>>,
  'isListed' : ActorMethod<[Principal], boolean>,
  'listItem' : ActorMethod<[Principal, bigint], string>,
  'mint' : ActorMethod<[Uint8Array | number[], string], Principal>,
}
