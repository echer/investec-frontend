// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carteira-api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CarteiraAPI implements CarteiraAPI {
  _CarteiraAPI(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://investec-backend.herokuapp.com/v1/carteira';
  }

  final Dio _dio;

  String baseUrl;

  @override
  list() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Carteira.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  create(carteira) async {
    ArgumentError.checkNotNull(carteira, 'carteira');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(carteira?.toJson() ?? <String, dynamic>{});
    final Response _result = await _dio.request('/',
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
  update(id, carteira) async {
    ArgumentError.checkNotNull(id, 'id');
    ArgumentError.checkNotNull(carteira, 'carteira');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(carteira?.toJson() ?? <String, dynamic>{});
    final Response _result = await _dio.request('/$id',
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
}
