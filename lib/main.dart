import 'package:flutter/material.dart';
import 'package:likeit/views/likes_view.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'models/image_model.dart';

import 'providers/like_provider.dart';
import 'views/master_view.dart';
import 'views/details_view.dart';

void main() {
  runApp(const LikeItApp());
}

class LikeItApp extends StatelessWidget {
  const LikeItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LikeProvider())],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.pink),
        routerConfig: _router,
      ),
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MasterView(),
      routes: [
        GoRoute(
          path: 'likes',
          builder: (context, state) {
            final images = state.extra as List<ImageModel>;
            return LikesView(allImages: images);
          },
        ),
        GoRoute(
          path: 'details',
          builder: (context, state) {
            final image = state.extra as ImageModel;
            return DetailsView(image: image);
          },
        ),
      ],
    ),
  ],
);


