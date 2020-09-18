import 'package:flutter/material.dart';

class GiphyDetail extends StatelessWidget {
  final Map _giphyData;

  GiphyDetail(this._giphyData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(_giphyData["title"]),
      ),
      body: Center(
        child: Image.network(_giphyData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}
