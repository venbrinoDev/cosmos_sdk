import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_base_abci_v1beta1/types/types.dart';
import 'package:cosmos_sdk/src/models/tendermint/tendermint_abci/messages/event.dart';
import 'package:blockchain_utils/binary/utils.dart';

/// Result is the union of ResponseFormat and ResponseCheckTx.
class Result extends CosmosMessage {
  /// Data is any data returned from message or handler execution. It MUST be
  /// length prefixed in order to separate data from multiple message executions.
  /// Deprecated. This field is still populated, but prefer msg_response instead
  /// because it also contains the Msg response typeURL.
  final List<int>? data;

  /// Log contains the log information from message or handler execution.
  final String log;

  /// Events contains a slice of Event objects that were emitted during message
  /// or handler execution.
  final List<Event> events;

  /// msg_responses contains the Msg handler responses type packed in Anys.
  ///
  /// Since: cosmos-sdk 0.46
  final List<Any> msgResponses;

  Result(
      {List<int>? data,
      required this.log,
      required List<Event> events,
      required List<Any> msgResponses})
      : data = BytesUtils.tryToBytes(data, unmodifiable: true),
        events = List<Event>.unmodifiable(events),
        msgResponses = List<Any>.unmodifiable(msgResponses);
  factory Result.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return Result(
        data: decode.getField(1),
        log: decode.getField(2),
        events: decode
            .getFileds<List<int>>(3)
            .map((e) => Event.deserialize(e))
            .toList(),
        msgResponses: decode
            .getFileds<List<int>>(4)
            .map((e) => Any.deserialize(e))
            .toList());
  }

  @override
  List<int> get fieldIds => [1, 2, 3, 4];

  @override
  Map<String, dynamic> toJson() {
    return {
      "data": BytesUtils.tryToHexString(data),
      "log": log,
      "events": events.map((e) => e.toJson()).toList(),
      "msg_responses": msgResponses.map((e) => e.toJson()).toList()
    };
  }

  @override
  String get typeUrl => BaseAbciV1beta1.result.typeUrl;

  @override
  List get values => [data, log, events, msgResponses];
}
