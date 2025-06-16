import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'models/image_model.dart';
import 'providers/like_provider.dart';
import 'providers/theme_provider.dart';
import 'views/master_view.dart';
import 'views/details_view.dart';
import 'views/likes_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LikeProvider()),
      ],
      child: const LikeItApp(),
    ),
  );
}

class LikeItApp extends StatelessWidget {
  const LikeItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          routerConfig: _router,
        );
      },
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


