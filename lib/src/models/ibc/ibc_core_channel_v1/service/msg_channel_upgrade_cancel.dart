import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:cosmos_sdk/src/models/ibc/ibc_core_channel_v1/messages/error_receipt.dart';
import 'package:cosmos_sdk/src/models/ibc/ibc_core_client_v1/messages/height.dart';

import 'package:cosmos_sdk/src/models/ibc/types/types.dart';
import 'package:cosmos_sdk/src/models/global_messages/service_empty_response.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';

/// MsgChannelUpgradeCancel defines the request type for the ChannelUpgradeCancel rpc
class MsgChannelUpgradeCancel extends CosmosMessage
    with ServiceMessage<EmptyServiceRequestResponse> {
  final String? portId;
  final String? channelId;
  final IbcChannelErrorReceipt errorReceipt;
  final List<int>? proofErrorReceipt;
  final IbcClientHeight proofHeight;
  final String? signer;
  MsgChannelUpgradeCancel(
      {this.portId,
      this.channelId,
      required this.errorReceipt,
      List<int>? proofErrorReceipt,
      required this.proofHeight,
      this.signer})
      : proofErrorReceipt =
            BytesUtils.tryToBytes(proofErrorReceipt, unmodifiable: true);
  factory MsgChannelUpgradeCancel.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return MsgChannelUpgradeCancel(
        portId: decode.getField(1),
        channelId: decode.getField(2),
        errorReceipt: IbcChannelErrorReceipt.deserialize(decode.getField(3)),
        proofErrorReceipt: decode.getField(4),
        proofHeight: IbcClientHeight.deserialize(decode.getField(5)),
        signer: decode.getField(6));
  }

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5, 6];

  @override
  String get service => IbcTypes.channelUpgradeCancel.typeUrl;

  @override
  Map<String, dynamic> toJson() {
    return {
      "port_id": portId,
      "channel_id": channelId,
      "error_receipt": errorReceipt.toJson(),
      "proof_error_receipt": BytesUtils.tryToHexString(proofErrorReceipt),
      "proof_height": proofHeight.toJson(),
      "signer": signer,
    };
  }

  @override
  String get typeUrl => IbcTypes.msgChannelUpgradeCancel.typeUrl;

  @override
  List get values =>
      [portId, channelId, errorReceipt, proofErrorReceipt, proofHeight, signer];

  @override
  List<String?> get signers => [signer];

  @override
  EmptyServiceRequestResponse onResponse(List<int> bytes) {
    return EmptyServiceRequestResponse(
        IbcTypes.msgChannelUpgradeCancelResponse.typeUrl);
  }
}
