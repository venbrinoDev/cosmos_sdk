import 'package:cosmos_sdk/src/address/address.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_gov_v1beta1/messages/weighted_vote_option.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_gov_v1beta1/types/types.dart';
import 'package:cosmos_sdk/src/models/global_messages/service_empty_response.dart';

import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/utils/quick_extensions.dart';

/// VoteWeighted defines a method to add a weighted vote on a specific proposal.
/// Since: cosmos-sdk 0.43
class GovMsgVoteWeighted extends CosmosMessage
    with ServiceMessage<EmptyServiceRequestResponse> {
  final BigInt propoosalId;
  final BaseAddress? voter;
  final List<GovWeightedVoteOption> options;

  GovMsgVoteWeighted(
      {required this.propoosalId,
      this.voter,
      required List<GovWeightedVoteOption> options})
      : options = options.mutable;
  factory GovMsgVoteWeighted.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return GovMsgVoteWeighted(
      propoosalId: decode.getField(1),
      voter:
          decode.getResult(2)?.to<BaseAddress, String>((e) => BaseAddress(e)),
      options: decode
          .getFileds(3)
          .map((e) => GovWeightedVoteOption.deserialize(e))
          .toList(),
    );
  }

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  String get service => GovV1beta1types.serviceGovVoteWeighted.typeUrl;

  @override
  Map<String, dynamic> toJson() {
    return {
      "proposal_id": propoosalId.toString(),
      "voter": voter?.address,
      "options": options.map((e) => e.toJson()).toList()
    };
  }

  @override
  String get typeUrl => GovV1beta1types.govMsgVoteWeighted.typeUrl;

  @override
  List get values => [propoosalId, voter?.address, options];
  @override
  List<String?> get signers => [voter?.address];
  @override
  EmptyServiceRequestResponse onResponse(List<int> bytes) {
    return EmptyServiceRequestResponse(
        GovV1beta1types.govMsgVoteWeightedResponse.typeUrl);
  }
}
