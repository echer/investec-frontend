// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario-api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UsuarioAPI implements UsuarioAPI {
  _UsuarioAPI(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://investec-backend.herokuapp.com/v1/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  list(usuario) async {
    ArgumentError.checkNotNull(usuario, 'usuario');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(usuario?.toJson() ?? <String, dynamic>{});
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'usuario/login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Login.fromJson(_result.data);
    return value;
  }
}
