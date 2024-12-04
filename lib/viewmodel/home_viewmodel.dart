import 'package:flutter/material.dart';
import 'package:learn_mvc/data/response/api_response.dart';
import 'package:learn_mvc/model/city.dart';
import 'package:learn_mvc/model/costs/costs.dart';
import 'package:learn_mvc/model/model.dart';
import 'package:learn_mvc/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepo = HomeRepository();

  final expeditionList = [
    'jne',
    'pos',
    'tiki',
  ];

  String _selectedExpedition = '';
  String get selectedExpedition => _selectedExpedition;

  ApiResponse<List<Costs>> _calculatedCosts = ApiResponse.notStarted();
  ApiResponse<List<Costs>> get calculatedCosts => _calculatedCosts;

  String _weight = '0';
  String get weight => _weight;

  Province? _selectedOriginProvince;
  Province? get selectedOriginProvince => _selectedOriginProvince;

  City? _selectedOriginCity;
  City? get selectedOriginCity => _selectedOriginCity;

  City? _selectedDestinationCity;
  City? get selectedDestinationCity => _selectedDestinationCity;

  ApiResponse<List<Province>> _provinceList = ApiResponse.loading();
  ApiResponse<List<Province>> get provinceList => _provinceList;

  ApiResponse<List<City>> _originCityList = ApiResponse.notStarted();
  ApiResponse<List<City>> get originCityList => _originCityList;

  ApiResponse<List<City>> _destinationCityList = ApiResponse.notStarted();
  ApiResponse<List<City>> get destinationCityList => _destinationCityList;

  setProvincelist(ApiResponse<List<Province>> response) {
    _provinceList = response;
    notifyListeners();
  }

  setOriginCityList(ApiResponse<List<City>> response) {
    _originCityList = response;
    notifyListeners();
  }

  setDestinationCityList(ApiResponse<List<City>> response) {
    _destinationCityList = response;
    notifyListeners();
  }

  void setSelectedOriginCity(City city) {
    _selectedOriginCity = city;
    notifyListeners();
  }

  void setSelectedDestinationCity(City city) {
    _selectedDestinationCity = city;
    notifyListeners();
  }

  void setExpedition(String expeditionName) {
    _selectedExpedition = expeditionName;
    notifyListeners();
  }

  void setWeight(String weight) {
    _weight = weight;
    notifyListeners();
  }

  Future<void> calculateEstimation() async {
    try {
      print(
          "CALCULATE COST.  \n Origin: ${_selectedOriginCity} \n Destination: ${_selectedDestinationCity}" +
              " \n Weight: ${weight} \n Expedition: ${selectedExpedition}");

      _calculatedCosts = ApiResponse.loading();
      notifyListeners();

      if (weight.isEmpty ||
          selectedExpedition.isEmpty ||
          selectedOriginCity == null ||
          selectedDestinationCity == null) {
        _calculatedCosts = ApiResponse.error('Please fill all the fields');
        notifyListeners();
        print("CALCULATE COST.  \n Error: Please fill all the fields");
        return;
      }

      List<Costs> result = await _homeRepo.fetchCalculateCosts(
        selectedOriginCity!.cityId!,
        selectedDestinationCity!.cityId!,
        weight,
        selectedExpedition,
      );

      _calculatedCosts = ApiResponse.completed(result);

      notifyListeners();
      print("CALCULATE COST.  \n Result: ${result}");
    } catch (e) {
      _calculatedCosts = ApiResponse.error(e.toString());
      notifyListeners();
      ApiResponse.error(e.toString());
    }
  }

  Future<void> getProvinceList() async {
    try {
      setProvincelist(ApiResponse.loading());
      List<Province> result = await _homeRepo.fetchProvinceList();
      setProvincelist(ApiResponse.completed(result));
    } catch (e) {
      setProvincelist(ApiResponse.error(e.toString()));
    }
  }

  Future<void> getOriginCityListByProvinceId(String provinceId) async {
    try {
      setOriginCityList(ApiResponse.loading());
      List<City> result = await _homeRepo.fetchCityList(provinceId);
      setOriginCityList(ApiResponse.completed(result));
    } catch (e) {
      setOriginCityList(ApiResponse.error(e.toString()));
    }
  }

  Future<void> getDestinationCityListByProvinceId(String provinceId) async {
    try {
      setDestinationCityList(ApiResponse.loading());
      List<City> result = await _homeRepo.fetchCityList(provinceId);
      setDestinationCityList(ApiResponse.completed(result));
    } catch (e) {
      setDestinationCityList(ApiResponse.error(e.toString()));
    }
  }
}
