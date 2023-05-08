import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_demo/models/sellers.dart';

const MAPBOX_ACCES_TOKEN =
    'pk.eyJ1IjoiYWxleG5lYXIiLCJhIjoiY2xoZHhxdmxkMWZkOTNsbm9ydXRwdnNnaSJ9.1fvRUpDAO76YHw9sM-21Iw';
const MAPBOX_STYLE = 'mapbox/dark-v11';
const MARKER_COLOR = Color.fromARGB(255, 235, 218, 33);
final myPosition = LatLng(-12.0362176, -77.0296812);

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _pageController = PageController();

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    for (var i = 0; i < mapSellers.length; i++) {
      final mapItem = mapSellers[i];
      _markerList.add(
        Marker(
          height: 40,
          width: 40,
          point: mapItem.location,
          builder: (_) {
            return GestureDetector(
              //pageController.jumpTo (indice)
              onTap: () {
                print('Selected marker ${mapItem.title}');
              },
              child: Image.asset('assets/images/seller.png'),
            );
          },
        ),
      );
    }
    return _markerList;
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        backgroundColor: Colors.amber[400],
        title: const Text("Select to Seller"),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
                center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': MAPBOX_ACCES_TOKEN,
                  'id': MAPBOX_STYLE
                },
              ),
              MarkerLayer(
                markers: _markers,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                      point: myPosition,
                      builder: (_) {
                        return _MyLocationMarker();
                      })
                ],
              )
            ],
          ),
          // add pageview
          Positioned(
            left: 0,
            right: 0,
            bottom: 21,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
                itemCount: mapSellers.length,
                itemBuilder: (context, index) {
                  final item = mapSellers[index];
                  return _MapItemDetails(mapMarker: item);
                }),
          )
        ],
      ),
    );
  }
}

class _MyLocationMarker extends StatelessWidget {
  const _MyLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration:
          const BoxDecoration(color: MARKER_COLOR, shape: BoxShape.circle),
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({super.key, required this.mapMarker});

  final Sellers mapMarker;
  @override
  Widget build(BuildContext context) {
    final _styleTitle = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    final _styleAddress = TextStyle(color: Colors.grey[800], fontSize: 14);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.amber[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: Image.asset(mapMarker.image)),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        mapMarker.title,
                        style: _styleTitle,
                      ),
                      const SizedBox(height: 10),
                      Text(mapMarker.address, style: _styleTitle)
                    ],
                  ))
                ],
              ),
            ),
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () => null,
              color: MARKER_COLOR,
              elevation: 6,
              child: Text(
                'Trade',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
