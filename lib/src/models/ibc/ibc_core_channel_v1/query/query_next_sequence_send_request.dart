import 'package:cosmos_sdk/src/models/ibc/ibc_core_channel_v1/query/query_next_equence_send_response.dart';

import 'package:cosmos_sdk/src/models/ibc/types/types.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';

/// QueryNextSequenceSendRequest is the request type for the Query/QueryNextSequenceSend RPC method
class QueryNextSequenceSendRequest extends CosmosMessage
    with QueryMessage<QueryNextSequenceSendResponse> {
  /// port unique identifier
  final String? portId;

  /// channel unique identifier
  final String? channelId;
  const QueryNextSequenceSendRequest({this.portId, this.channelId});
  factory QueryNextSequenceSendRequest.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return QueryNextSequenceSendRequest(
        portId: decode.getField(1), channelId: decode.getField(2));
  }

  @override
  List<int> get fieldIds => [1, 2];

  @override
  String get queryPath => IbcTypes.nextSequenceSend.typeUrl;

  @override
  Map<String, dynamic> toJson() {
    return {"port_id": portId, "channel_id": channelId};
  }

  @override
  String get typeUrl => IbcTypes.queryNextSequenceSendRequest.typeUrl;

  @override
  List get values => [portId, channelId];

  @override
  QueryNextSequenceSendResponse onResponse(List<int> bytes) {
    return QueryNextSequenceSendResponse.deserialize(bytes);
  }
}
