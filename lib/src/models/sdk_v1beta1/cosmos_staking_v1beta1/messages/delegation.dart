import 'package:cosmos_sdk/src/address/address.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_staking_v1beta1/types/types.dart';

/// Delegation represents the bond with tokens held by an account.
/// It is owned by one delegator, and is associated with the voting power of one validator.
class Delegation extends CosmosMessage {
  // delegatorAddress is the bech32-encoded address of the delegator.
  final BaseAddress delegatorAddress;

  // validatorAddress is the bech32-encoded address of the validator.
  final BaseAddress validatorAddress;

  // shares define the delegation shares received.
  final String shares;

  const Delegation({
    required this.delegatorAddress,
    required this.validatorAddress,
    required this.shares,
  });
  factory Delegation.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return Delegation(
        delegatorAddress: BaseAddress(decode.getField(1)),
        validatorAddress: BaseAddress(decode.getField(2)),
        shares: decode.getField(3));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'delegator_address': delegatorAddress.address,
      'validator_address': validatorAddress.address,
      'shares': shares,
    };
  }

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  String get typeUrl => StakingV1beta1Types.delegation.typeUrl;

  @override
  List get values =>
      [delegatorAddress.address, validatorAddress.address, shares];
}
