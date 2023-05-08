import 'package:latlong2/latlong.dart';

class Sellers {
  const Sellers(
      {required this.image,
      required this.title,
      required this.address,
      required this.location});

  final String image;
  final String title;
  final String address;
  final LatLng location;
}

final _locations = [
  LatLng(-12.0080041, -77.0778237),
  LatLng(-12.0430962, -77.0208307),
  LatLng(-12.0211287, -77.0502137),
];

const _path = 'assets/images/';

final mapSellers = [
  Sellers(
      image: '${_path}seller.png',
      title: "Marcos",
      address: 'Adress Marcos 123',
      location: _locations[1]),
  Sellers(
      image: '${_path}seller.png',
      title: "Luigui",
      address: "Address Luigui 321",
      location: _locations[2])
];
