import 'package:cosmos_sdk/src/models/ibc/ibc_core_channel_v1/query/query_channel_client_state_response.dart';

import 'package:cosmos_sdk/src/models/ibc/types/types.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';

/// QueryChannelClientStateRequest is the request type for the Query/ClientState RPC method
class QueryChannelClientStateRequest extends CosmosMessage
    with QueryMessage<QueryChannelClientStateResponse> {
  /// port unique identifier
  final String? portId;

  /// channel unique identifier
  final String? channelId;
  const QueryChannelClientStateRequest({this.portId, this.channelId});
  factory QueryChannelClientStateRequest.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return QueryChannelClientStateRequest(
        portId: decode.getField(1), channelId: decode.getField(2));
  }

  @override
  List<int> get fieldIds => [1, 2];

  @override
  String get queryPath => IbcTypes.channelClientState.typeUrl;

  @override
  Map<String, dynamic> toJson() {
    return {"port_id": portId, "channel_id": channelId};
  }

  @override
  String get typeUrl => IbcTypes.queryChannelClientStateRequest.typeUrl;

  @override
  List get values => [portId, channelId];

  @override
  QueryChannelClientStateResponse onResponse(List<int> bytes) {
    return QueryChannelClientStateResponse.deserialize(bytes);
  }
}
