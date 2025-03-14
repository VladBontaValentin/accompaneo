import 'package:accompaneo/main.dart';
import 'package:accompaneo/models/simple_playlist.dart';
import 'package:accompaneo/models/song/song.dart';
import 'package:accompaneo/pages/player_page.dart';
import 'package:accompaneo/pages/playlist_page.dart';
import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/recover_password_page.dart';
import 'widgets/invalid_route.dart';
import 'values/app_routes.dart';

class Routes {
  const Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {


    switch (settings.name) {
      case AppRoutes.login:
        return SlideRightRoute(widget: const LoginPage());

      case AppRoutes.register:
        return SlideRightRoute(widget: const RegisterPage());

      case AppRoutes.forgotPassword:
        return SlideRightRoute(widget: const ForgotPasswordPage());

      case AppRoutes.playlistSearch:
        return SlideRightRoute(widget: const PlaylistPage(playlist: SimplePlaylist(code: '', name: 'Search', latestPlayed: false, favourites: false, searchable: true)));

      case AppRoutes.player: {
        final args = settings.arguments as Map<String, Song>;

        return SlideRightRoute(widget:  PlayerPage(song: args['song']!));
      }

      case AppRoutes.playlist: {
        final args = settings.arguments as Map<String, Object>;

        return SlideRightRoute(widget:  PlaylistPage(queryTerm: args['queryTerm'] != null ? args['queryTerm'] as String: '', playlist: args['playlist'] as SimplePlaylist));
      }      

      case AppRoutes.home:
        return SlideRightRoute(widget: const AccompaneoApp(selectedIndex: 0));

      case AppRoutes.profile:
        return SlideRightRoute(widget: const AccompaneoApp(selectedIndex: 1));

      case AppRoutes.playlists:
        return SlideRightRoute(widget: const AccompaneoApp(selectedIndex: 3));    

      /// An invalid route. User shouldn't see this,
      /// it's for debugging purpose only.
      default:
        return SlideRightRoute(widget: const InvalidRoute());
    }
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({required  this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}