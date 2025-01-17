import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_tx_v1beta1/query/simulate_response.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_tx_v1beta1/types/types.dart';
import 'package:blockchain_utils/binary/utils.dart';

/// Simulate simulates executing a transaction for estimating gas usage.
class SimulateRequest extends CosmosMessage
    with QueryMessage<SimulateResponse> {
  /// tx_bytes is the raw transaction.
  ///
  /// Since: cosmos-sdk 0.43
  final List<int> txBytes;
  SimulateRequest(List<int> txBytes)
      : txBytes = BytesUtils.toBytes(txBytes, unmodifiable: true);
  factory SimulateRequest.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return SimulateRequest(decode.getField(2));
  }

  @override
  List<int> get fieldIds => [2];

  @override
  String get queryPath => TxV1beta1Types.simulate.typeUrl;

  @override
  Map<String, dynamic> toJson() {
    return {"tx_bytes": BytesUtils.toHexString(txBytes)};
  }

  @override
  String get typeUrl => TxV1beta1Types.simulateRequest.typeUrl;

  @override
  List get values => [txBytes];

  @override
  SimulateResponse onResponse(List<int> bytes) {
    return SimulateResponse.deserialize(bytes);
  }
}
