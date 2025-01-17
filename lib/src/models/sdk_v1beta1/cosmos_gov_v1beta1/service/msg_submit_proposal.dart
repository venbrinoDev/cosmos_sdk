import 'package:cosmos_sdk/src/address/address.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_base_v1beta1/messages/coin.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_gov_v1beta1/types/types.dart';

import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/utils/quick_extensions.dart';

import 'msg_submit_proposal_response.dart';

/// MsgSubmitProposal defines an sdk.Msg type that supports submitting arbitrary proposal Content.
class GovMsgSubmitProposal extends CosmosMessage
    with ServiceMessage<GovMsgSubmitProposalResponse> {
  /// content is the proposal's content.
  final Any? content;

  /// initial_deposit is the deposit value that must be paid at proposal submission.
  final List<Coin> initialDeposit;

  /// proposer is the account address of the proposer.
  final BaseAddress? proposer;
  GovMsgSubmitProposal(
      {this.content, required List<Coin> initialDeposit, this.proposer})
      : initialDeposit = initialDeposit.mutable;
  factory GovMsgSubmitProposal.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return GovMsgSubmitProposal(
        content:
            decode.getResult(1)?.to<Any, List<int>>((e) => Any.deserialize(e)),
        initialDeposit: decode
            .getFileds<List<int>>(2)
            .map((e) => Coin.deserialize(e))
            .toList(),
        proposer: decode
            .getResult(3)
            ?.to<BaseAddress, String>((e) => BaseAddress(e)));
  }

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  String get service => GovV1beta1types.serviceGovSubmitProposal.typeUrl;

  @override
  Map<String, dynamic> toJson() {
    return {
      "content": content?.toJson(),
      "initial_deposit": initialDeposit.map((e) => e.toJson()).toList(),
      "proposer": proposer?.address
    };
  }

  @override
  String get typeUrl => GovV1beta1types.govMsgSubmitProposal.typeUrl;

  @override
  List get values => [content, initialDeposit, proposer];
  @override
  List<String?> get signers => [proposer?.address];

  @override
  GovMsgSubmitProposalResponse onResponse(List<int> bytes) {
    return GovMsgSubmitProposalResponse.deserialize(bytes);
  }
}
