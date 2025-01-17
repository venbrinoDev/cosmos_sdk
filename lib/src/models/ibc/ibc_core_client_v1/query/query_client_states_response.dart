import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_base_query_v1beta1/messages/page_response.dart';
import 'package:cosmos_sdk/src/models/ibc/ibc_core_client_v1/messages/identified_client_state.dart';
import 'package:cosmos_sdk/src/models/ibc/types/types.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/utils/quick_extensions.dart';

/// QueryClientStatesResponse is the response type for the Query/ClientStates RPC method.
class QueryClientStatesResponse extends CosmosMessage {
  /// list of stored ClientStates of the chain.
  final List<IbcClientIdentifiedClientState> clinetStates;

  /// pagination response
  final PageResponse? pagination;
  QueryClientStatesResponse(
      {required List<IbcClientIdentifiedClientState> clinetStates,
      this.pagination})
      : clinetStates = clinetStates.mutable;
  factory QueryClientStatesResponse.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return QueryClientStatesResponse(
        clinetStates: decode
            .getFileds(1)
            .map((e) => IbcClientIdentifiedClientState.deserialize(e))
            .toList(),
        pagination: decode
            .getResult(2)
            ?.to<PageResponse, List<int>>((e) => PageResponse.deserialize(e)));
  }

  @override
  List<int> get fieldIds => [1, 2];

  @override
  Map<String, dynamic> toJson() {
    return {
      "client_states": clinetStates.map((e) => e.toJson()).toList(),
      "pagination": pagination?.toJson()
    };
  }

  @override
  String get typeUrl => IbcTypes.queryClientStatesResponse.typeUrl;

  @override
  List get values => [clinetStates, pagination];
}
