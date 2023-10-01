import Text "mo:base/Text";
import Nat16 "mo:base/Nat16";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Blob "mo:base/Blob";
import Nat "mo:base/Nat";

/* Aqui se Definen los tipos de datos para luego ser referenciados.
ejemplo: si una variable es 'una caja' en la que guardas cosas
aqui se especifica que objetos van dentro de esa caja y si una caja
guarda otras cajas con cosas adentro

Nota: Dip721 es un estandar y este código suele usarse así como está, la mayoria
ni siquiera se molesta en intentar entender como funciona pero no viene mal
hacerle un análisis, esta versión está modificada y re-escrita
habrà que hecharle mano para ligar los tokens una vez transferidos desde el canister
a un usuarios

Nota 2: esto es solo la estructura de datos, llamado en otros lenguaje como
"el modelo"
*/
module {
  // aunque se declare como "módulo"
  /*
    logo_type: archivo de imagen
    data: metadata
  */
  public type LogoResult = {
    logo_type : Text;
    data : Text;
  };

  // Protocolo Dip721: el estándar NFT en la red ICP
  // inspirado en ERC-721 (NFT de Ethereum)
  public type Dip721NonFungibleToken = {
    logo : LogoResult; // referencia a LogoResult que contiene imagen y matadata
    name : Text; // nombre del NFT
    symbol : Text; // simbolo del token: cada NTF es un token
    maxLimit : Nat16; // Cantidad de NFTs
  };

  /*
  las interfaces son conceptos bastante abstractos: generalmente en
  otros lenguajes de programación sirven como "los planos", como una caja
  que en lugar de guardar objetos guarda funciones, pero Motoko es un lenguaje
  particular, ampliarè mas adelante..
    Actualización: en Motoko hay una movida llamada "pattern matching"
    y las varibles declaradas con un "#algunaCosa" son 'literales':
    pareciera ser similar a las "constantes" de otros lenguajes
  */
  public type InterfaceId = {
    #Approval; // Aprobar
    #TransactionHistory; // historial de transacción
    #Mint; // "Mintear/Acuñar/Crear" NFT (token)
    #Burn; // Quemar
    #TransferNotification; // Notificación de transferencia
  };

  /* En caso de haber errores, que los hay porque el usuario puede intentar
  hacer cosas que no deberia o porque pueden haber imprevistos, como que justo
  se vaya la conexion y no se puede concretar, en ese caso tambien se definen
  esos "estados"
  */
  public type ApiError = {
    #Unauthorized;
    #InvalidTokenId;
    #ZeroAddress;
    #Other;
  };

  // El Resultado puede ser "OK" o "Error"
  public type Result<S, E> = {
    #Ok : S;
    #Error : E;
  };

  // Cartera que correctponde al dueño del token deriva de:
  //"Principal"(su Identity) o Error
  public type OwnerResult = Result<Principal, ApiError>;

  // Quien recibe el token
  public type TxReceipt = Result<Nat, ApiError>;

  // Identificador de la transacción
  public type TransactionId = Nat;

  // Identificador del Token No Fungible
  public type TokenId = Nat64;

  // Metadatos

  // Parece ser el "propósito"
  public type MetadataPurpose = {
    #Preview; // vista previa
    #Rendered; // Renderizado
  };

  // Tipos de datos que se pueden guardar como Metadato: basicamente TODO
  public type MetadataVal = {
    #TextContent : Text;
    #BlobContent : Blob;
    #NatContent : Nat;
    #Nat8Content : Nat8;
    #Nat16Content : Nat16;
    #Nat32Content : Nat32;
    #Nat64Content : Nat64;
  };

  /* Entonces se define un diccionario: un diccionario es una variable
  que en lugar de recibir un solo dato a la vez, recibe una clave y un valor
  asociado, ejemplo:
  Key: 123
  Valor: datos de la certificacion "profesores"
  */
  public type MetadataKeyVal = {
    key : Text;
    val : MetadataVal;
  };

  public type MetadataPart = {
    purpose : MetadataPurpose; // guarda MetadataDesc declarada mas arriba
    key_val_data : [MetadataKeyVal]; //
    data : Blob;
  };

  public type MetadataDesc = [MetadataPart];

  public type MetadataResult = Result<MetadataDesc, ApiError>;

  public type ExtendedMetadataResult = Result<{ metadata_desc : MetadataDesc; token_id : TokenId }, ApiError>;

  public type MintReceiptPart = {
    token_id : TokenId;
    id : Nat;
  };

  public type MintReceipt = Result<MintReceiptPart, ApiError>;

  // Finalmente se define el NFT
  public type Nft = {
    owner : Principal; // dueño
    id : TokenId; // identificador
    metadata : MetadataDesc; // metadatos
  };
};
