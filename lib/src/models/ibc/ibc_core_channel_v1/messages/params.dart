import 'package:cosmos_sdk/src/models/ibc/ibc_core_channel_v1/messages/timeout.dart';
import 'package:cosmos_sdk/src/models/ibc/types/types.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';

/// Params defines the set of IBC channel parameters.
class IbcChannelParams extends CosmosMessage {
  /// the relative timeout after which channel upgrades will time out.
  final IbcChannelTimeout upgradeTimeout;
  const IbcChannelParams(this.upgradeTimeout);
  factory IbcChannelParams.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return IbcChannelParams(IbcChannelTimeout.deserialize(decode.getField(1)));
  }

  @override
  List<int> get fieldIds => [1];

  @override
  Map<String, dynamic> toJson() {
    return {"upgrade_timeout": upgradeTimeout.toJson()};
  }

  @override
  String get typeUrl => IbcTypes.ibcChannelParams.typeUrl;

  @override
  List get values => [upgradeTimeout];
}
