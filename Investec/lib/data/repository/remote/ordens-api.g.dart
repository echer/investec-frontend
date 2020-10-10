// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordens-api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OrdensAPI implements OrdensAPI {
  _OrdensAPI(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://investec-backend.herokuapp.com/v1/carteira';
  }

  final Dio _dio;

  String baseUrl;

  @override
  list(carteira, ativo) async {
    ArgumentError.checkNotNull(carteira, 'carteira');
    ArgumentError.checkNotNull(ativo, 'ativo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '$carteira/ativos/$ativo/ordens',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Ordem.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  create(carteira, ativo, obj) async {
    ArgumentError.checkNotNull(carteira, 'carteira');
    ArgumentError.checkNotNull(ativo, 'ativo');
    ArgumentError.checkNotNull(obj, 'obj');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(obj?.toJson() ?? <String, dynamic>{});
    final Response _result = await _dio.request(
        '$carteira/ativos/$ativo/ordens',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  update(carteira, ativo, id, obj) async {
    ArgumentError.checkNotNull(carteira, 'carteira');
    ArgumentError.checkNotNull(ativo, 'ativo');
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(obj, 'obj');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(obj?.toJson() ?? <String, dynamic>{});
    final Response _result = await _dio.request(
        '$carteira/ativos/$ativo/ordens/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  delete(carteira, ativo, id) async {
    ArgumentError.checkNotNull(carteira, 'carteira');
    ArgumentError.checkNotNull(ativo, 'ativo');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response _result = await _dio.request(
        '$carteira/ativos/$ativo/ordens/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'DELETE',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }
}
