import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_base_query_v1beta1/messages/page_response.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_gov_v1beta1/messages/deposit.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_gov_v1beta1/types/types.dart';

import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/utils/quick_extensions.dart';

/// QueryDepositsResponse is the response type for the Query/Deposits RPC method.
class GovQueryDepositsResponse extends CosmosMessage {
  /// deposits defines the requested deposits.
  final List<GovDeposit> deposits;

  /// pagination defines the pagination in the response.
  final PageResponse? pagination;
  GovQueryDepositsResponse(
      {required List<GovDeposit> deposits, this.pagination})
      : deposits = deposits.mutable;
  factory GovQueryDepositsResponse.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return GovQueryDepositsResponse(
        deposits:
            decode.getFileds(1).map((e) => GovDeposit.deserialize(e)).toList(),
        pagination: decode
            .getResult(2)
            ?.to<PageResponse, List<int>>((e) => PageResponse.deserialize(e)));
  }

  @override
  List<int> get fieldIds => [1, 2];

  @override
  Map<String, dynamic> toJson() {
    return {
      "deposits": deposits.map((e) => e.toJson()).toList(),
      "pagination": pagination?.toJson()
    };
  }

  @override
  String get typeUrl => GovV1beta1types.govQueryDepositsResponse.typeUrl;

  @override
  List get values => [deposits, pagination];
}
