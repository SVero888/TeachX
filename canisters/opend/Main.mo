import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import NFTActorClass "../NFT/Main";
import Cycles "mo:base/ExperimentalCycles";
import HashMap"mo:base/HashMap";
import List "mo:base/List";
import Iter "mo:base/Iter";

actor OpenD {
  // Crear custom datatype Listing
  private type Listing ={
    itemOwner: Principal;
    itemPrice:Nat;
  };
  
  /* Se guardan los NFTS 
  
  NFT(nftids)
  owners(id,list of nfts)
  listing(nft,price)
  
  como Listas dentro de HashMaps
  */
  var mapOfNFT = HashMap.HashMap<Principal, NFTActorClass.NFT> (1,Principal.equal,Principal.hash);
  var mapOfOwners = HashMap.HashMap<Principal,List.List<Principal>> (1,Principal.equal,Principal.hash);
  var mapOfListings = HashMap.HashMap<Principal,Listing> (1,Principal.equal,Principal.hash);
  
  // función para mintear(acuñar) NFT desde el frontend
  public shared(msg) func mint(imgData:[Nat8],name:Text): async Principal{
    let owner=msg.caller;// devuelve canisterid owner del main actor
    
    //experimental cycles for minting
    Cycles.add(100_500_000_000);

    let newNFT= await NFTActorClass.NFT(name,owner,imgData);// crear
    let newNFTPrincipal=await newNFT.getCanisterId();// obtener id

    // guardar
    mapOfNFT.put(newNFTPrincipal,newNFT);
    addToOwnershipMap(owner,newNFTPrincipal);
    return newNFTPrincipal;
  };

  // funcion para cambiar el dueño del NFT
  private func addToOwnershipMap(owner:Principal,nftId:Principal){
    //switch statement of question return
    var ownedNfts:List.List<Principal> = switch(mapOfOwners.get(owner)){
      case null List.nil<Principal>();
      case (?result) result;
    };

    // actualizar
    ownedNfts:=List.push(nftId,ownedNfts);
    mapOfOwners.put(owner,ownedNfts);
  };

  // funcion para mostrar todos los NFTs en pocesion de un usuario
  public query func getOwnedNFTs(user:Principal):async [Principal]{
    var userNfts:List.List<Principal> = switch(mapOfOwners.get(user)){
      case null List.nil<Principal>();
      case (?result) result;
    };
    return List.toArray(userNfts);
  };

  // funcion para mostrar todos los NFTs listados como disponibles para intercambiar
  public query func getListedNFTs():async [Principal]{
    return Iter.toArray(mapOfListings.keys());
  };

  // function para mostrar el precio de un NFT en concreto
  public shared(msg) func listItem(id:Principal,price:Nat):async Text{
    //question return process
    var item : NFTActorClass.NFT = switch(mapOfNFT.get(id)){
      case null return "NFT does not exist";
      case (?result) result;
    };

    let owner=await item.getOwner();
    if(Principal.equal(owner,msg.caller)){
      let newListing:Listing ={
        itemOwner=owner;
        itemPrice=price;
      };
      mapOfListings.put(id,newListing);
      return "Success";
    }
    else{
      return "you don't owm this nft"
    }
  };

  // openD canister id
  public query func getOpenDCanisterId():async Principal{
    return Principal.fromActor(OpenD);
  };

  // function para comprobar si un NFT está listado o no
  public query func isListed(id:Principal):async Bool{
    if(mapOfListings.get(id)== null)
    {
      return false;
    }
    else{
      return true;
    }
  };

  // mostrar el dueño original de un NFT (quien lo acuño)
  // esta funcion es comun en tiendas donde hay diferentes creadores
  // en el caso de la plataforma habrà un unico creador: la plataforma
  public query func getOriginalOwner(id:Principal):async Principal{
    var listing: Listing = switch(mapOfListings.get(id)){
      case null return Principal.fromText("");
      case (?result) result;
    };
    return listing.itemOwner;
  };

  // function para obtener la lista de precios de los NFTs filtrados por etiquetas
  // en caso de ser parte de un mercado interno
  public query func getListingPrice(id:Principal):async Nat{
    var listing: Listing = switch(mapOfListings.get(id)){
      case null return 0;
      case (?result) result;
    };
    return listing.itemPrice;
  };

  // funcion para completar una venta y transferir la pocesion del NFT al comprador
  public shared(msg) func completePurchase(nftid:Principal,seller:Principal,buyer:Principal):async Text{
    var purchaseNFT:NFTActorClass.NFT = switch(mapOfNFT.get(nftid)){
      case null return "NFT does not exist";
      case (?result) result;
    };

    // transferir NFT
    let transferResult=await purchaseNFT.transferOwnership(buyer);
    Debug.print(debug_show(transferResult));
    if(transferResult == "Success"){
      // quitar de la lista de disponibles
      mapOfListings.delete(nftid);
      var ownedNFTs: List.List<Principal> = switch(mapOfOwners.get(seller)){
        case null List.nil<Principal>();
        case (?result) result;
      };

      // actualizar pocesion del NFT
      ownedNFTs:= List.filter(ownedNFTs, func (listItemId:Principal):Bool{
        return listItemId !=nftid;
      });
    
      // actualizar pocesion del nuevo dueño en el hashmap
      addToOwnershipMap(buyer,nftid);
      return "Success";
    }
    else{
      return "Error";
    }
  };
};