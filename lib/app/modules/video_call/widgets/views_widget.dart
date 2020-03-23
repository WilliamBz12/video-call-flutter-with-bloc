import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class ViewsWidget extends StatelessWidget {
  final List<int> users;
  ViewsWidget({this.users});

  List<Widget> _getUsersRenderViews() {
    final List<AgoraRenderWidget> list = [
      AgoraRenderWidget(0, local: true, preview: true),
    ];
    users.forEach((int uid) {
      list.add(AgoraRenderWidget(uid));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> views = _getUsersRenderViews();
    switch (views.length) {
      case 2: //2 beacuse the list has at least one item by default 
        return Column(
          children: <Widget>[_videoView(views[0])], //this is the first video
        );
      case 3:
        return Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[2]]), //this is the second video 
          ],
        );
      default:
    }
    return Container();
  }

  Widget _videoView(view) {
    return Expanded(
      child: Container(child: view),
    );
  }

  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(children: wrappedViews),
    );
  }
}
