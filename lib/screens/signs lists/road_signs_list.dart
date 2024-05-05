import 'package:nurbs_driving_test/const/constant.dart';

class RoadSignsRepository {
  List<Map<String, dynamic>> getRoadList() {
    return [
      {
        'text': 'Begin of a priority road',
        'image': '$roadImages/Begin of a priority road.png',
      },
      {
        'text': 'Curve of the main road',
        'image': '$roadImages/Curve of the main road.png',
      },
      {
        'text': 'Curve of the main road11',
        'image': '$roadImages/Curve of the main road11.png',
      },
      {
        'text': 'Curve of the main road22',
        'image': '$roadImages/Curve of the main road22.png',
      },
      {
        'text': 'End of the priority road',
        'image': '$roadImages/End of the priority road.png',
      },
      {
        'text': 'Give way to all drivers',
        'image': '$roadImages/Give way to all drivers.png',
      },
      {
        'text': 'Mandatory direction of the roundabout',
        'image': '$roadImages/Mandatory direction of the roundabout.png',
      },
      {
        'text': 'Road narrowing, give way to oncoming drivers',
        'image': '$roadImages/Road narrowing, give way to oncoming drivers.png',
      },
      {
        'text': 'Road narrowing, oncoming drivers have to give way',
        'image':
            '$roadImages/Road narrowing, oncoming drivers have to give way.png',
      },
      {
        'text': 'Stop and give way to all drivers',
        'image': '$roadImages/Stop and give way to all drivers.png',
      },
      {
        'text': 'Warning for a crossroad side roads on the left and right',
        'image':
            '$roadImages/Warning for a crossroad side roads on the left and right.png',
      },
      {
        'text': 'Warning for an uncontrolled crossroad',
        'image': '$roadImages/Warning for an uncontrolled crossroad.png',
      },
    ];
  }
}
