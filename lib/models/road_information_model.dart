// we will create our information model here
// create a simple class
class RoadInformation {
  // define how a information will look like
  // every information will have an Id.
  final String id;
  // every information will have a title, it's the question itself.
  final String title;
  final String imgUrl;
  // every information will have options.
  final String subtitle;

  // create a constructor
  RoadInformation({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imgUrl,
  });

  // override the toString method to print the informations on console
  @override
  String toString() {
    return 'Information(id: $id, title: $title, subtitle: $subtitle, imgUrl: $imgUrl)';
  }
}
