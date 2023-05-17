import 'package:flutter/material.dart';
import 'package:map_demo/models/sellers.dart';

class PageSellers extends StatefulWidget {
  const PageSellers({super.key, required Sellers seller});

  @override
  State<PageSellers> createState() => _PageSellersState();
}

class _PageSellersState extends State<PageSellers> {
  @override
  Widget build(BuildContext context) {
    return Text("sellers");
  }
}
