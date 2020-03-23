import 'package:videocallflutter/app/modules/video_call/video_call_module.dart';
import 'package:videocallflutter/app/app_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:videocallflutter/app/app_widget.dart';
import 'package:videocallflutter/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: HomeModule()),
        Router('/video-call', module: VideoCallModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
