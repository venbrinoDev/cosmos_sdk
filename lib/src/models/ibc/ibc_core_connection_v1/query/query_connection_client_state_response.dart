import 'package:blockchain_utils/binary/utils.dart';
import 'package:cosmos_sdk/src/models/ibc/ibc_core_client_v1/messages/height.dart';
import 'package:cosmos_sdk/src/models/ibc/ibc_core_client_v1/messages/identified_client_state.dart';
import 'package:cosmos_sdk/src/models/ibc/types/types.dart';
import 'package:cosmos_sdk/src/protobuf/protobuf.dart';

/// QueryConnectionClientStateResponse is the response type for the Query/ConnectionClientState RPC method
class IbcConnectionQueryConnectionClientStateResponse extends CosmosMessage {
  /// client state associated with the channel
  final IbcClientIdentifiedClientState? identifiedClientState;

  /// merkle proof of existence
  final List<int>? proof;

  /// height at which the proof was retrieved
  final IbcClientHeight proofHeight;
  IbcConnectionQueryConnectionClientStateResponse(
      {this.identifiedClientState, List<int>? proof, required this.proofHeight})
      : proof = BytesUtils.tryToBytes(proof);
  factory IbcConnectionQueryConnectionClientStateResponse.deserialize(
      List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return IbcConnectionQueryConnectionClientStateResponse(
      identifiedClientState: decode
          .getResult(1)
          ?.to<IbcClientIdentifiedClientState, List<int>>(
              (e) => IbcClientIdentifiedClientState.deserialize(e)),
      proof: decode.getField(2),
      proofHeight: IbcClientHeight.deserialize(decode.getField(3)),
    );
  }

  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  Map<String, dynamic> toJson() {
    return {
      "identified_client_state": identifiedClientState?.toJson(),
      "proof": BytesUtils.tryToHexString(proof),
      "proof_height": proofHeight.toJson()
    };
  }

  @override
  String get typeUrl =>
      IbcTypes.ibcConnectionQueryConnectionClientStateResponse.typeUrl;

  @override
  List get values => [identifiedClientState, proof, proofHeight];
}
