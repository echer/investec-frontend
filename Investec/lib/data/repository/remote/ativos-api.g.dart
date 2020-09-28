// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ativos-api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AtivosAPI implements AtivosAPI {
  _AtivosAPI(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://investec-backend.herokuapp.com/v1/';
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
        'carteira/:carteira/ativos',
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
}
