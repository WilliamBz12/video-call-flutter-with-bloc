import 'package:flutter/material.dart';
import 'package:videocallflutter/app/modules/video_call/video_call_module.dart';

import 'video_call_bloc.dart';
import 'widgets/panel_widget.dart';
import 'widgets/toolbar_widget.dart';
import 'widgets/views_widget.dart';

class VideoCallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;

  /// Creates a call page with given channel name.
  const VideoCallPage({Key key, this.channelName}) : super(key: key);

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  
  bool muted = false;
  final _bloc = VideoCallModule.to.get<VideoCallBloc>();

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    _bloc.initAgoraEngine(channel: widget.channelName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call in ${widget.channelName}'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            StreamBuilder<List<int>>(
              stream: _bloc.outUsers,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return ViewsWidget(users: snapshot.data);
                }
                return Container();
              },
            ),
            StreamBuilder<List<String>>(
              stream: _bloc.outMessages,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return PanelWidget(infoStrings: snapshot.data);
                }
                return Container();
              },
            ),
            ToolbarWidget(
                muted: muted,
                onCallEnd: () => Navigator.pop(context),
                onSwitchCamera: _bloc.switchCamera,
                onToggleMute: () {
                  setState(() => muted = !muted);
                  _bloc.muteAudio(muted);
                }),
          ],
        ),
      ),
    );
  }
}
