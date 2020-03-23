import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _channelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video call with BLOC'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _channelController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(width: 1),
              ),
              hintText: 'Channel name',
            ),
          ),
          RaisedButton(
            onPressed: onJoin,
            child: Text('Join'),
          ),
        ],
      ),
    );
  }

  Future<void> onJoin() async {
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.pushNamed(
        context,
        '/video-call',
        arguments: _channelController.text
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions([
      PermissionGroup.camera,
      PermissionGroup.microphone,
    ]);
  }
}
