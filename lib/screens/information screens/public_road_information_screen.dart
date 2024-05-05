import 'package:flutter/material.dart';
import 'package:nurbs_driving_test/const/constant.dart';
import 'package:nurbs_driving_test/const/theme_setting.dart';
import 'package:nurbs_driving_test/models/db_connect.dart';
import 'package:nurbs_driving_test/models/road_information_model.dart';
import 'package:nurbs_driving_test/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class PublicRoadInformationScreen extends StatefulWidget {
  const PublicRoadInformationScreen({super.key});

  @override
  State<PublicRoadInformationScreen> createState() =>
      _PublicRoadInformationScreenState();
}

class _PublicRoadInformationScreenState
    extends State<PublicRoadInformationScreen> {
  var db = DBconnect();

  late Future _informations;
  bool isImageLoading = true;

  Future<List<RoadInformation>> getData() async {
    return db.fetchInformation();
  }

  @override
  void initState() {
    _informations = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeSate = Provider.of<ThemeSetting>(context).currentTheme;
    var isLight = themeSate.brightness == Brightness.light;
    // Access the warningList from the repository
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: poppinsTxt(
                  txt: 'Public Road Information',
                  txtSize: 25,
                  txtWeight: FontWeight.w500,
                  clr: isLight ? greenDark : Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
                child: FutureBuilder(
              future: _informations as Future<List<RoadInformation>>,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Network Error'),
                    );
                  } else if (snapshot.hasData) {
                    ///
                    var extractedData = snapshot.data as List<RoadInformation>;

                    return ListView.builder(
                      itemCount: extractedData.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              poppinsTxt(
                                txt: extractedData[index].title.toString(),
                                txtSize: 20,
                                txtWeight: FontWeight.w400,
                                clr: isLight ? greenDark : blueShade,
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: FutureBuilder(
                                    future: Future.delayed(
                                            const Duration(seconds: 2))
                                        .then((value) {
                                      setState(() {
                                        isImageLoading = false;
                                      });
                                    }),
                                    builder: (context, snapshot) {
                                      return isImageLoading == true
                                          ? Shimmer.fromColors(
                                              baseColor: Colors.grey.shade400,
                                              highlightColor:
                                                  Colors.grey.shade200,
                                              enabled: isImageLoading,
                                              child: const Icon(
                                                Icons.image,
                                                size: 80,
                                              ),
                                            )
                                          : SizedBox(
                                              width: double.infinity,
                                              child: Image.network(
                                                extractedData[index].imgUrl,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Center(
                                                      child: SizedBox(
                                                    height: 150,
                                                    child:
                                                        Image.asset(errorImg),
                                                  ));
                                                },
                                                filterQuality:
                                                    FilterQuality.high,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              dmSansTxt(
                                  txt: extractedData[index].subtitle.toString(),
                                  txtSize: 16),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: greenDark,
                  ));
                }

                return const Center(
                  child: Text('No Data'),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
