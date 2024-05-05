import 'package:http/http.dart' as http; // the http package
import 'package:nurbs_driving_test/models/road_information_model.dart';
import './question_model.dart';
import 'dart:convert';

class DBconnect {
  final url = Uri.parse(
      'https://driving-test-nurbs-default-rtdb.firebaseio.com/test.json');

  // fetch the data from database
  Future<List<Question>> fetchQuestions() async {
    // we got the data from just using this. now let's print it to see what we got.
    return http.get(url).then((response) {
      // the 'then' method returns a 'response' which is our data.
      // to whats inside we have to decode it first.
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Question(
          id: key, // the encrypted key/the title we gave to our data
          title: value['title'], // title of the question
          options: Map.castFrom(value['options']), // options of the question
          imgUrl: value['imgUrl'],
        );
        // add to newQuestions
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }

  final infoUrl = Uri.parse(
      'https://driving-test-nurbs-default-rtdb.firebaseio.com/information.json');

  // fetch the data from database
  Future<List<RoadInformation>> fetchInformation() async {
    // we got the data from just using this. now let's print it to see what we got.
    return http.get(infoUrl).then((response) {
      // the 'then' method returns a 'response' which is our data.
      // to whats inside we have to decode it first.
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<RoadInformation> newIformations = [];
      data.forEach((key, value) {
        var newIformation = RoadInformation(
          id: key, // the encrypted key/the title we gave to our data
          title: value['title'], // title of the question
          subtitle: value['subtitle'], // options of the question
          imgUrl: value['imgUrl'],
        );
        // add to newQuestions
        newIformations.add(newIformation);
      });
      return newIformations;
    });
  }
}
