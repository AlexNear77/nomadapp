import 'dart:ffi';
import 'package:latlong2/latlong.dart';

class Sellers {
  const Sellers(
      {required this.image,
      required this.title,
      required this.address,
      required this.location,
      required this.enable,
      required this.limit,
      required this.orders,
      required this.complete,
      required this.precio});

  final String image;
  final String title;
  final String address;
  final LatLng location;
  final String enable;
  final String limit;
  final int orders;
  final int complete;
  final double precio;
  /* Pago == Efectivo, ATM */
}

final _locations = [
  LatLng(-12.0080041, -77.0778237),
  LatLng(-12.0430962, -77.0208307),
  LatLng(-12.0211287, -77.0502137),
  LatLng(-12.0480045, -77.0205112),
  LatLng(-12.0654067, -77.0257675),
  LatLng(-12.0622444, -77.0708716)
];

const _path = 'assets/images/';

final mapSellers = [
  /*  Sellers(
      image: '${_path}seller.png',
      title: "Mario Belisario",
      address: 'Belisario 32425',
      location: _locations[0]), */
  Sellers(
      image: "https://rickandmortyapi.com/api/character/avatar/6.jpeg",
      title: "Abadango Cluster Princess",
      address: 'Belisario 32425',
      location: _locations[0],
      enable: '200.12',
      limit: '10 - 50',
      orders: 12,
      complete: 10,
      precio: 4475.54),
  Sellers(
      image: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
      title: "Jerry Smith",
      address: "Monrovia 2341",
      location: _locations[1],
      enable: '50.50',
      limit: '5 - 30',
      orders: 44,
      complete: 40,
      precio: 4474.54),
  Sellers(
      image: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
      title: "Beth Smith",
      address: "Los angeles 4222",
      location: _locations[2],
      enable: '100.00',
      limit: '10 - 100',
      orders: 70,
      complete: 69,
      precio: 4465.54),
  Sellers(
      image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      title: "Rick Sanchez",
      address: "San Andres 3249",
      location: _locations[3],
      enable: '70.12',
      limit: '10 - 50',
      orders: 12,
      complete: 12,
      precio: 4475.00),
  Sellers(
      image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
      title: "Morty Smith",
      address: "Rovia 3221",
      location: _locations[4],
      enable: '63.32',
      limit: '5 - 70',
      orders: 34,
      complete: 34,
      precio: 4473.54),
  Sellers(
      image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
      title: "Summer Smith",
      address: "Matia 2341",
      location: _locations[5],
      enable: '70',
      limit: '5 - 20',
      orders: 99,
      complete: 99,
      precio: 4471.54)
];
