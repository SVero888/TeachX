import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
 
actor class NFT(name:Text,owner:Principal,content:[Nat8])=this{
  private let itemName=name;
  private var nftOwner=owner;
  private let imageBytes=content;

  // Obtener nombre/titulo del NFT
  public query func getName():async Text{
    return name;
  };

  // consultar dueño
  public query func getOwner():async Principal{
    return owner;
  };

  // obtener imagen del NFT
  public query func getAsset():async [Nat8]{
    return imageBytes;
  };

  // obtener el id del canister donde se guardan los NFTs
  public query func getCanisterId():async Principal{
    return Principal.fromActor(this);
  };

  // función para transferir el NFT (debe ser incluida una condiciónal para
  // evitar que pueda ser tranferido y asi sea "soulbounded" {como en el warcraft
  // loktar oggar y todo eso} )
  public shared(msg) func transferOwnership(newOwner:Principal):async Text{
    if(nftOwner == msg.caller ){
      nftOwner:= newOwner;
      return "Success";
    }
    else{
      return "Transfer Error: not initiated by owner";
    }
  };
};