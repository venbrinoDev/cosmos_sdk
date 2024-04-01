import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_gov_v1beta1/types/types.dart';

import 'package:cosmos_sdk/src/protobuf/protobuf.dart';

/// VotingParams defines the params for voting on governance proposals.
class GovVotingParams extends CosmosMessage {
  /// Duration of the voting period.
  final ProtobufDuration votingPeriod;
  const GovVotingParams(this.votingPeriod);
  factory GovVotingParams.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return GovVotingParams(ProtobufDuration.deserialize(decode.getField(1)));
  }

  @override
  List<int> get fieldIds => [1];

  @override
  Map<String, dynamic> toJson() {
    return {"voting_period": votingPeriod.toJson()};
  }

  @override
  String get typeUrl => GovV1beta1types.govVotingParams.typeUrl;

  @override
  List get values => [votingPeriod];
}
