import 'package:flutter/material.dart';
import 'package:learn_mvc/data/network/netwrok_api_services.dart';
import 'package:learn_mvc/model/city.dart';
import 'package:learn_mvc/model/costs/costs.dart';
import 'package:learn_mvc/model/model.dart';

class HomeRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Province>> fetchProvinceList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('starter/province');

      List<Province> result = [];
      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List<dynamic>)
            .map((e) => Province.fromJson(e as Map<String, dynamic>))
            .toList();
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Costs>> fetchCalculateCosts(
      String originId, destinationId, weight, expedition) async {
    try {
      dynamic response = await _apiServices.postApiResponse('starter/cost', {
        'origin': originId,
        'destination': destinationId,
        'weight': weight,
        'courier': expedition,
      });

      debugPrint('response Cost Fetch: $response');
      List<Costs> result = [];
      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List<dynamic>)
            .map((e) => Costs.fromMap(e))
            .toList();
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<City>> fetchCityList(String provinceId) async {
    debugPrint('FETCH CITY LIST');
    try {
      debugPrint('provinceId: $provinceId');
      dynamic response =
          await _apiServices.getApiResponse('starter/city', queryParams: {
        'province': provinceId,
      });

      List<City> result = [];

      debugPrint('response City Fetch: $response');
      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List<dynamic>)
            .map((e) => City.fromMap(e))
            .toList();
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
