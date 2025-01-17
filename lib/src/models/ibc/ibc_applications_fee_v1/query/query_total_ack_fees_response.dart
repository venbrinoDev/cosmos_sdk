import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_base_v1beta1/messages/coin.dart';
import 'package:cosmos_sdk/src/models/ibc/types/types.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/utils/quick_extensions.dart';

/// QueryTotalAckFeesResponse defines the response type for the TotalAckFees rpc
class QueryTotalAckFeesResponse extends CosmosMessage {
  /// the total packet acknowledgement fees
  final List<Coin> recvFees;
  QueryTotalAckFeesResponse({required List<Coin> recvFees})
      : recvFees = recvFees.mutable;
  factory QueryTotalAckFeesResponse.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return QueryTotalAckFeesResponse(
        recvFees: decode.getFileds(1).map((e) => Coin.deserialize(e)).toList());
  }

  @override
  List<int> get fieldIds => [1];

  @override
  Map<String, dynamic> toJson() {
    return {"recv_fees": recvFees.map((e) => e.toJson()).toList()};
  }

  @override
  String get typeUrl => IbcTypes.queryTotalAckFeesResponse.typeUrl;

  @override
  List get values => [recvFees];
}
