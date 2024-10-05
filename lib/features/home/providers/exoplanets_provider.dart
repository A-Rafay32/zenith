import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenith/app/constants/api_urls.dart';
import 'package:zenith/core/services/http_service.dart';
import 'package:zenith/features/home/model/exoplanets_collection_model.dart';

final exoplanetsProvider = FutureProvider((ref) async {
  final response = await HttpService(baseUrl: BASEURL_EXOPLANETS)
      .get(APIUrls.getExoplanets());
  print(response);
  return NasaCollection.fromJson(response as Map<String, dynamic>);
});
