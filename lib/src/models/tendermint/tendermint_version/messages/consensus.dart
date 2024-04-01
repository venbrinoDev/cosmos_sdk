import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/models/tendermint/types/types.dart';

/// Consensus captures the consensus rules for processing a block in the blockchain,
/// including all blockchain data structures and the rules of the application's state transition machine.
class Consensus extends CosmosMessage {
  final BigInt? block;
  final BigInt? app;
  const Consensus({this.block, this.app});
  factory Consensus.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return Consensus(block: decode.getField(1), app: decode.getField(2));
  }

  @override
  List<int> get fieldIds => [1, 2];

  @override
  Map<String, dynamic> toJson() {
    return {"block": block?.toString(), "app": app?.toString()};
  }

  @override
  String get typeUrl => TendermintTypes.consensus.typeUrl;

  @override
  List get values => [block, app];
}
