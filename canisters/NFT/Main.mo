import Types "./Types";
import Principal "mo:base/Principal";
import List "mo:base/List";
import Text "mo:base/Text";
import Nat64 "mo:base/Nat64";

/*
  Se referencia al archivo Types con "Types.nombreDeLaEstructura"
*/
shared actor class Dip721NFT(custodian : Principal, init : Types.Dip721NonFungibleToken) = Self {
  /* toda variable que se declara "stable" guarda valores en el canister
  en este caso se define las variables con los tipos de datos definidos
  anteriormente en Types, porsupuesto hasta no colocar nada todo está vacio */
  stable var transactionId : Types.TransactionId = 0; // id
  stable var nfts = List.nil<Types.Nft>(); // dueño, id, metadata
  stable var custodians = List.make<Principal>(custodian);
  // ini.algo hace referencia a los objetos dentro de Dip721NonFungibleToken en el archivo Types
  stable var logo : Types.LogoResult = init.logo;
  stable var name : Text = init.name;
  stable var symbol : Text = init.symbol;
  stable var maxLimit : Nat16 = init.maxLimit;

  // null_address es donde se envian los NFTs que se queman
  // hasta ahora desconocia que podian quemarse pero tiene sentido
  // ya que los NFTs funcionan igual que una criptomoneda, con algunas diferencias
  let null_address : Principal = Principal.fromText("aaaaa-aa");

  // funcion que muestra el balance de tu cartera de NFTs
  public query func balanceOfDip721(user : Principal) : async Nat64 {
    return Nat64.fromNat(
      List.size(
        List.filter(nfts, func(token : Types.Nft) : Bool { token.owner == user })
      ) // devuelve un numero que equivale a: el total de los tokens en posesion
    );
  };

  /*
  de forma similar a azle se usa la palabra query'consulta' aunque con diferente
  estructura, a las estructuras propias del lenguaje
  los programadores le llamamos 'sintaxis'
  */
  public query func ownerOfDip721(token_id : Types.TokenId) : async Types.OwnerResult {

  };
};
