import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_bank_v1beta1/query/query_denoms_metadata_response.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_base_query_v1beta1/messages/page_request.dart';

import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_bank_v1beta1/types/types.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';

/// QueryDenomsMetadataRequest is the request type for the Query/DenomsMetadata RPC method.
class QueryDenomsMetadataRequest extends CosmosMessage
    with QueryMessage<QueryDenomsMetadataResponse> {
  /// pagination defines an optional pagination for the request.
  final PageRequest? pagination;
  const QueryDenomsMetadataRequest({this.pagination});
  factory QueryDenomsMetadataRequest.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return QueryDenomsMetadataRequest(
        pagination: decode
            .getResult(1)
            ?.to<PageRequest, List<int>>((e) => PageRequest.deserialize(e)));
  }

  @override
  List<int> get fieldIds => [1];

  @override
  String get queryPath => BankV1beta1Types.denomsMetadata.typeUrl;

  @override
  Map<String, dynamic> toJson() {
    return {"pagination": pagination?.toJson()};
  }

  @override
  String get typeUrl => BankV1beta1Types.denomsMetadataRequest.typeUrl;

  @override
  List get values => [pagination];

  @override
  QueryDenomsMetadataResponse onResponse(List<int> bytes) {
    return QueryDenomsMetadataResponse.deserialize(bytes);
  }
}
