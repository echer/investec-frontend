// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ativos-api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AtivosAPI implements AtivosAPI {
  _AtivosAPI(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://investec-backend.herokuapp.com/v1/carteira';
  }

  final Dio _dio;

  String baseUrl;

  @override
  list(carteira) async {
    ArgumentError.checkNotNull(carteira, 'carteira');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/$carteira/ativos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Ativo.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  create(carteira, ativo) async {
    ArgumentError.checkNotNull(carteira, 'carteira');
    ArgumentError.checkNotNull(ativo, 'ativo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(ativo?.toJson() ?? <String, dynamic>{});
    final Response _result = await _dio.request('/$carteira/ativos',
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
  update(carteira, id, ativo) async {
    ArgumentError.checkNotNull(carteira, 'carteira');
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(ativo, 'ativo');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(ativo?.toJson() ?? <String, dynamic>{});
    final Response _result = await _dio.request('/$carteira/ativos/$id',
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
  delete(carteira, id) async {
    ArgumentError.checkNotNull(carteira, 'carteira');
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response _result = await _dio.request('/$carteira/ativos/$id',
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
