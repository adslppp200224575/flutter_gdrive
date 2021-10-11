import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class DownloadPage extends StatefulWidget {
  @override
  //State<StatefulWidget> createState() => _DownloadPageState();
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  bool _isDownloading = false;
  String downloadMessage = 'Initializing....';
  var appbar = AppBar(
    title: const Text("test"),
    backgroundColor: Colors.amber,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: Column(
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: () async {
                setState(() {
                  _isDownloading = !_isDownloading;
                });
                var dir = await getExternalStorageDirectory();
//'https:/sample-videos.com/img/Sample-jpg-image-5mb.jpg'
                Dio dio = Dio();
                dio.download(
                    'https:/sample-videos.com/img/Sample-jpg-image-5mb.jpg',
                    '${dir?.path}/sample.jpg',
                    onReceiveProgress: (actualbytes, totalbytes) {
                  var percentage = actualbytes / totalbytes * 100;
                  setState(() {
                    downloadMessage = 'Downloading.... ${percentage.floor()}%';
                  });
                });
              },
              label: const Text('Download'),
            ),
            const SizedBox(height: 32),
            Text(downloadMessage),
          ],
        ),
      ),
    );
  }
}
