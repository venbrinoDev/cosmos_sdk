import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_base_query_v1beta1/messages/page_response.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_feegrant_v1beta1/messages/grant.dart';
import 'package:cosmos_sdk/src/models/sdk_v1beta1/cosmos_feegrant_v1beta1/types/types.dart';

import 'package:cosmos_sdk/src/protobuf/protobuf.dart';
import 'package:cosmos_sdk/src/utils/quick_extensions.dart';

/// QueryAllowancesByGranterResponse is the response type for the Query/AllowancesByGranter RPC method.
/// Since: cosmos-sdk 0.46
class QueryAllowancesByGranterResponse extends CosmosMessage {
  /// allowances that have been issued by the granter.
  final List<FeeGrant> allowances;

  /// pagination defines an pagination for the response.
  final PageResponse? pagination;
  QueryAllowancesByGranterResponse(
      {required List<FeeGrant> allowances, this.pagination})
      : allowances = allowances.mutable;

  factory QueryAllowancesByGranterResponse.deserialize(List<int> bytes) {
    final decode = CosmosProtocolBuffer.decode(bytes);
    return QueryAllowancesByGranterResponse(
        allowances:
            decode.getFileds(1).map((e) => FeeGrant.deserialize(e)).toList(),
        pagination: decode
            .getResult(2)
            ?.to<PageResponse, List<int>>((e) => PageResponse.deserialize(e)));
  }

  @override
  List<int> get fieldIds => [1, 2];

  @override
  Map<String, dynamic> toJson() {
    return {
      "allowances": allowances.map((e) => e.toJson()).toList(),
      "pagination": pagination?.toJson()
    };
  }

  @override
  String get typeUrl =>
      FeegrantV1beta1Types.queryAllowancesByGranterResponse.typeUrl;

  @override
  List get values => [allowances, pagination];
}
