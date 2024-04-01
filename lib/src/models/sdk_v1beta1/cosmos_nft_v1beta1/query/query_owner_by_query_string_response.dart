import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_nft_v1beta1/types/types.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';

/// QueryOwnerByQueryStringResponse is the response type for the Query/Owner RPC method
/// Since: nft v0.1.1
class QueryOwnerByQueryStringResponse extends CosmosMessage {
  /// owner is the owner address of the nft
  final String? owner;
  const QueryOwnerByQueryStringResponse({this.owner});
  factory QueryOwnerByQueryStringResponse.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return QueryOwnerByQueryStringResponse(owner: decode.getField(1));
  }

  @override
  List<int> get fieldIds => [1];

  @override
  Map<String, dynamic> toJson() {
    return {"owner": owner};
  }

  @override
  String get typeUrl =>
      NFTV1beta1Types.queryNFTOwnerByQueryStringResponse.typeUrl;

  @override
  List get values => [owner];
}
