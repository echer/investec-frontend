// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carteira-api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CarteiraAPI implements CarteiraAPI {
  _CarteiraAPI(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://investec-backend.herokuapp.com/v1/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  list() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('carteira',
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
}
