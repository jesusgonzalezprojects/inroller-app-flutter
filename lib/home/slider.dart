import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {

  final List<String> imgList = [
    'https://st3.depositphotos.com/1875497/31894/i/450/depositphotos_318941740-stock-photo-blinds-shade-window-decoration-interior.jpg',
    'https://static9.depositphotos.com/1035257/1171/i/450/depositphotos_11715292-stock-photo-modern-bedroom.jpg',
    'https://static5.depositphotos.com/1026645/520/i/450/depositphotos_5202585-stock-photo-stylish-modern-dining-room.jpg',
    'https://st4.depositphotos.com/1273062/27170/i/450/depositphotos_271707940-stock-photo-interior-dining-area-3d-illustration.jpg',
    'https://st4.depositphotos.com/1273062/27170/i/450/depositphotos_271707940-stock-photo-interior-dining-area-3d-illustration.jpg',
    'https://st4.depositphotos.com/1273062/27170/i/450/depositphotos_271707940-stock-photo-interior-dining-area-3d-illustration.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Center(
            child: CarouselSlider(
              autoPlay: true,
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              height: 280.0,
              viewportFraction: 1.0,
              items: imgList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: i,
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator()
                          ),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                        )
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
