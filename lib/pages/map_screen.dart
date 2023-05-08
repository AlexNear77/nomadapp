import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_demo/models/sellers.dart';

const MAPBOX_ACCES_TOKEN =
    'pk.eyJ1IjoiYWxleG5lYXIiLCJhIjoiY2xoZHhxdmxkMWZkOTNsbm9ydXRwdnNnaSJ9.1fvRUpDAO76YHw9sM-21Iw';
const MAPBOX_STYLE = 'mapbox/dark-v11';
const MARKER_COLOR = Color.fromARGB(255, 235, 218, 33);
const MARKER_SIZE_EXPANDED = 67.0;
const MARKER_SIZE_SHRINKED = 50.0;
final myPosition = LatLng(-12.0362176, -77.0296812);

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = 0;

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    for (var i = 0; i < mapSellers.length; i++) {
      final mapItem = mapSellers[i];
      _markerList.add(
        Marker(
          height: MARKER_SIZE_EXPANDED,
          width: MARKER_SIZE_EXPANDED,
          point: mapItem.location,
          builder: (_) {
            return GestureDetector(
              //pageController.jumpTo (indice)
              onTap: () {
                _selectedIndex = i;
                setState(() {
                  _pageController.animateToPage(i,
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.fastOutSlowIn); /* elasticOut */
                });
                print('Selected marker ${mapItem.title}');
              },
              child: _LocationMarker(
                selected: _selectedIndex == i,
              ),
            );
          },
        ),
      );
    }
    return _markerList;
  }

  ///==============================================================================
  ///                     INIITIALIZED ANIMATION LOCATION NOMAD
  ///============================================================================
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 777));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  ///===========================================================================

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
              // MARKET SELLERS
              MarkerLayer(
                markers: _markers,
              ),
              // MARKET NOMAD
              MarkerLayer(
                markers: [
                  Marker(
                      height: 60,
                      width: 60,
                      point: myPosition,
                      builder: (_) {
                        return _MyLocationMarker(_animationController);
                      })
                ],
              )
            ],
          ),
          //=========================================
          //              CARD SELLERS
          //=========================================
          Positioned(
            left: 0,
            right: 0,
            bottom: 21,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
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

//=============================================================================
//                              Mark seller
//============================================================================
class _LocationMarker extends StatelessWidget {
  const _LocationMarker({super.key, this.selected = false});
  final bool selected;
  @override
  Widget build(BuildContext context) {
    final size = selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINKED;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: Duration(milliseconds: 200),
        child: Image.asset('assets/images/seller.png'),
      ),
    );
  }
}
//===========================================================================

//=============================================================================
//                              Mark Nomad
//============================================================================
class _MyLocationMarker extends AnimatedWidget {
  const _MyLocationMarker(
    Animation<double> animation, {
    Key? key,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newValue = lerpDouble(0.5, 1, value)!;
    final size = 50.0;
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              height: size * newValue,
              width: size * newValue,
              decoration: BoxDecoration(
                  color: MARKER_COLOR.withOpacity(0.5), shape: BoxShape.circle),
            ),
          ),
          Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                  color: MARKER_COLOR, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
//===========================================================================

//==============================================================================
//                            Card Seller select
//=============================================================================
class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({super.key, required this.mapMarker});

  final Sellers mapMarker;
  @override
  Widget build(BuildContext context) {
    // --------------------------------Styles---------------------------
    final _styleTitle = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    final _styleAddress = TextStyle(color: Colors.grey[800], fontSize: 14);
    final _styleSubtitle =
        TextStyle(color: Color.fromARGB(255, 41, 41, 41), fontSize: 17);
    final _styledPrice =
        TextStyle(color: Color.fromARGB(255, 35, 231, 58), fontSize: 17);
    //-------------------------------------------------------------------
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.amber[400],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(mapMarker.image))),
                    ),

                    /* Expanded(child: Image.network(mapMarker.image)), */
                    /* Expanded(child: Image.asset(mapMarker.image)), */
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          mapMarker.title,
                          style: _styleTitle,
                        ),
                        const SizedBox(height: 10),
                        Text("Address: " + mapMarker.address,
                            style: _styleSubtitle),
                        Row(children: [
                          Text("Enable: ", style: _styleSubtitle),
                          Text("\$" + mapMarker.enable, style: _styledPrice),
                        ]),
                        Text("Limit: \$" + mapMarker.limit,
                            style: _styleSubtitle),

                        //-------------- Orders and Complete----------------
                        Row(
                          children: [
                            Text("Orders: " + mapMarker.orders.toString(),
                                style: _styleSubtitle),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                "Complete: % " +
                                    (mapMarker.complete *
                                            100 /
                                            mapMarker.orders)
                                        .toInt()
                                        .toString(),
                                style: _styleSubtitle)
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 7.0),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                elevation: 17.0,
                color: Colors.black,
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                  minWidth: 200.0,
                  height: 35,
                  color: Colors.black,
                  child: const Text(
                    "Trade",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//========================================================================
