part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel _homeViewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    _homeViewModel.getProvinceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Cek ongkir"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => _homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, model, child) {
            // Your widget tree here
            switch (model.provinceList.status) {
              case Status.completed:
                return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          labelText: 'Select Expedition',
                                          border: OutlineInputBorder(),
                                        ),
                                        items: _homeViewModel.expeditionList
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          model.setExpedition(value ?? "");
                                          // Handle expedition selection
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Weight (gram)',
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          // Handle weight input
                                          model.setWeight(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                // Row for origin selection
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 16.0, bottom: 8.0),
                                  child: Text("Origin",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<Province>(
                                        isExpanded: true,
                                        decoration: const InputDecoration(
                                          labelText: 'Province',
                                          border: OutlineInputBorder(),
                                        ),
                                        items: model.provinceList.data
                                            ?.map((Province province) {
                                          return DropdownMenuItem<Province>(
                                            value: province,
                                            child: Text(
                                              province.province ?? '',
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (Province? value) {
                                          if (value != null) {
                                            model.getOriginCityListByProvinceId(
                                                value.provinceId ?? '');
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: model.originCityList.status ==
                                              Status.loading
                                          ? const CircularProgressIndicator()
                                          : DropdownButtonFormField<City>(
                                              isExpanded: true,
                                              decoration: const InputDecoration(
                                                labelText: 'City',
                                                border: OutlineInputBorder(),
                                              ),
                                              items: model.originCityList.data
                                                  ?.map((City city) {
                                                return DropdownMenuItem<City>(
                                                  value: city,
                                                  child: Text(
                                                    city.cityName ?? '',
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (City? value) {
                                                if (value != null) {
                                                  model.setSelectedOriginCity(
                                                      value);
                                                }
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                                // Row for destination selection
                                const Padding(
                                  padding:
                                      EdgeInsets.only(top: 16.0, bottom: 8.0),
                                  child: Text("Destination",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<Province>(
                                        isExpanded: true,
                                        decoration: const InputDecoration(
                                          labelText: 'Province',
                                          border: OutlineInputBorder(),
                                        ),
                                        items: model.provinceList.data
                                            ?.map((Province province) {
                                          return DropdownMenuItem<Province>(
                                            value: province,
                                            child: Text(
                                              province.province ?? '',
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (Province? value) {
                                          if (value != null) {
                                            model
                                                .getDestinationCityListByProvinceId(
                                                    value.provinceId ?? '');
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: model.destinationCityList.status ==
                                              Status.loading
                                          ? const CircularProgressIndicator()
                                          : DropdownButtonFormField<City>(
                                              isExpanded: true,
                                              decoration: const InputDecoration(
                                                labelText: 'City',
                                                border: OutlineInputBorder(),
                                              ),
                                              items: model
                                                  .destinationCityList.data
                                                  ?.map((City city) {
                                                return DropdownMenuItem<City>(
                                                  value: city,
                                                  child: Text(
                                                    city.cityName ?? '',
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (City? value) {
                                                if (value != null) {
                                                  model
                                                      .setSelectedDestinationCity(
                                                          value);
                                                }
                                              },
                                            ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, bottom: 8.0),
                                  child: Center(
                                    child: ElevatedButton(
                                      onPressed: model.selectedOriginCity !=
                                                  null &&
                                              model.selectedDestinationCity !=
                                                  null
                                          ? () {
                                              model.calculateEstimation();
                                            }
                                          : null,
                                      child: Text('Calculate Cost'),
                                    ),
                                  ),
                                ),

                                // Cost estimation result
                                const SizedBox(height: 24),
                                Consumer<HomeViewModel>(
                                  builder: (context, value, _) {
                                    switch (value.calculatedCosts.status) {
                                      case Status.loading:
                                        return Container();
                                      case Status.error:
                                        return Center(
                                          child: Text(value
                                              .calculatedCosts.message
                                              .toString()),
                                        );
                                      case Status.completed:
                                        final ongkirData = value
                                            .calculatedCosts.data![0].costs!;
                                        return Column(
                                          children: ongkirData.map((ongkir) {
                                            return Card(
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  child: Text(
                                                    ongkir.service
                                                            ?.toUpperCase()
                                                            .substring(0, 1) ??
                                                        "",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  backgroundColor: Colors.blue,
                                                ),
                                                title: Text(
                                                  "${ongkir.description ?? "Deskripsi tidak tersedia"} (${ongkir.service ?? "Nama Layanan"})",
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: ongkir.cost
                                                          ?.map((cost) {
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Biaya: Rp${cost.value}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            const SizedBox(
                                                                height: 8),
                                                            RichText(
                                                              text: TextSpan(
                                                                text:
                                                                    "Estimasi sampai: ${cost.etd} hari",
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }).toList() ??
                                                      [],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      default:
                                        return Container();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
              case Status.error:
                return Center(
                  child: Text("Error : ${model.provinceList.message}"),
                );
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}
