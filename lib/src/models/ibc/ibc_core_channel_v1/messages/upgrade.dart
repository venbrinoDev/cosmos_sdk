import 'package:cosmos_sdk/src/models/ibc/ibc_core_channel_v1/messages/timeout.dart';
import 'package:cosmos_sdk/src/models/ibc/ibc_core_channel_v1/messages/upgrade_fields.dart';
import 'package:cosmos_sdk/src/models/ibc/types/types.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';

/// Upgrade is a verifiable type which contains the relevant information for an attempted upgrade.
/// It provides the proposed changes to the channel end,
/// the timeout for this upgrade attempt and the next packet
/// sequence which allows the counterparty to efficiently know the
/// highest sequence it has received. The next sequence send is
/// used for pruning and upgrading from unordered to ordered channels.
class IbcChannelUpgrade extends CosmosMessage {
  final UpgradeFields fields;
  final IbcChannelTimeout timeout;
  final BigInt? nextSequenceSend;
  const IbcChannelUpgrade(
      {required this.fields, required this.timeout, this.nextSequenceSend});
  factory IbcChannelUpgrade.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return IbcChannelUpgrade(
        fields: UpgradeFields.deserialize(decode.getField(1)),
        timeout: IbcChannelTimeout.deserialize(decode.getField(2)),
        nextSequenceSend: decode.getField(3));
  }
  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  Map<String, dynamic> toJson() {
    return {
      "fields": fields.toJson(),
      "timeout": timeout.toJson(),
      "next_sequence_send": nextSequenceSend?.toString(),
    };
  }

  @override
  String get typeUrl => IbcTypes.upgrade.typeUrl;

  @override
  List get values => [fields, timeout, nextSequenceSend];
}
