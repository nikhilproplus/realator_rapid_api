import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realator_rapid_api/controller/controller.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GetDataController getDataController = Get.put(GetDataController());
  final RefreshController refreshControllerbrand =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  void fetchData() {
    Future.delayed(Duration.zero, () async {
      await getDataController.filmDataResult();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Movies",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.purple.shade50,
        body: Center(
          child: SmartRefresher(
            enablePullDown: true,
            onRefresh: () {
              fetchData();
              refreshControllerbrand.refreshCompleted();
            },
            controller: refreshControllerbrand,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: getDataController.searchItemController.value,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        filled: true,
                        fillColor: Colors.deepPurple.shade50,
                        hintText: 'Search a movie',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              getDataController.itemName.value =
                                  getDataController
                                      .searchItemController.value.text;
                              getDataController.saveData.clear();
                              fetchData();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.deepPurple,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Search'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 24),
                    Text(
                      getDataController.searchItemController.value.text.isEmpty
                          ? 'Find available area'
                          : 'available areas related to ${getDataController.searchItemController.value.text}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    getDataController.isDataLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : getDataController.saveData.isEmpty
                            ? Center(
                                child: Text(
                                  getDataController.searchItemController.value
                                          .text.isEmpty
                                      ? 'Please fill the search box to get result'
                                      : "No data available about ${getDataController.searchItemController.value.text}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: getDataController
                                    .saveData.first.autocomplete.length,
                                itemBuilder: (context, index) {
                                  var apiData = getDataController
                                      .saveData.first.autocomplete[index];

                                  return InkWell(
                                    onTap: () async {},
                                    child: Card(
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                            child: Image.network(
                                              'https://solguruz.com/wp-content/uploads/2023/11/What-is-a-Realtor-App-How-Does-It-Help-Your-Property-Business.png',
                                              fit: BoxFit.cover,
                                              height: 200,
                                              width: double.infinity,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  apiData.city ?? "Unknown",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'areaType: ${apiData.areaType}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'score: ${apiData.score.toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'country : ${apiData.country}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'country : ',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                      ),
                                                      // Expanded(
                                                      //   child: ListView.builder(
                                                      //       scrollDirection:
                                                      //           Axis.horizontal,
                                                      //       shrinkWrap: true,
                                                      //       itemCount: apiData
                                                      //           .counties!
                                                      //           .length,
                                                      //       itemBuilder:
                                                      //           (context,
                                                      //               count) {
                                                      //         var itemData =
                                                      //             apiData.counties![
                                                      //                 count];

                                                      //         return Text(
                                                      //           ' ${itemData.name}',
                                                      //           style:
                                                      //               const TextStyle(
                                                      //             fontWeight:
                                                      //                 FontWeight
                                                      //                     .bold,
                                                      //             color: Colors
                                                      //                 .deepPurple,
                                                      //           ),
                                                      //         );
                                                      //       }),
                                                      // ),
                                                      Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: apiData
                                                                .counties!
                                                                .map((each) {
                                                              return Text(
                                                                ' ${each.name}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .deepPurple,
                                                                ),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
