import 'package:cosmos_sdk/src/models/ics23/messages/proof/compressed_batch_entry.dart';
import 'package:cosmos_sdk/src/models/ics23/messages/inner_op.dart';
import 'package:cosmos_sdk/src/models/ics23/types/types.dart';

import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/utils/quick_extensions.dart';

import 'base_proof.dart';

class Ics23CompressedBatchProof extends Ics23ProofBase {
  final List<Ics23CompressedBatchEntry>? entries;
  final List<Ics23InnerOp>? lookupInners;
  Ics23CompressedBatchProof(
      {List<Ics23CompressedBatchEntry>? entries,
      List<Ics23InnerOp>? lookupInners})
      : entries = entries?.nullOnEmpy,
        lookupInners = lookupInners?.nullOnEmpy;
  factory Ics23CompressedBatchProof.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return Ics23CompressedBatchProof(
        entries: decode
            .getFileds<List<int>>(1)
            .map((e) => Ics23CompressedBatchEntry.deserialize(e))
            .toList(),
        lookupInners: decode
            .getFileds<List<int>>(2)
            .map((e) => Ics23InnerOp.deserialize(e))
            .toList());
  }

  @override
  List<int> get fieldIds => [1, 2];

  @override
  Map<String, dynamic> toJson() {
    return {
      "entries": entries?.map((e) => e.toJson()).toList(),
      "lookup_inners": lookupInners?.map((e) => e.toJson()).toList()
    };
  }

  @override
  String get typeUrl => Ics23Types.compressedBatchProof.typeUrl;

  @override
  List get values => [entries, lookupInners];

  @override
  int get commitmentId => 4;
}
