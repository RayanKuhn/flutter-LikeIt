import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'models/image_model.dart';
import 'providers/auth_provider.dart';
import 'providers/like_provider.dart';
import 'providers/theme_provider.dart';
import 'views/details_view.dart';
import 'views/likes_view.dart';
import 'views/login_view.dart';
import 'views/master_view.dart';
import 'views/profile_view.dart';
import 'views/signup_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LikeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const LikeItApp(),
    ),
  );
}

class LikeItApp extends StatefulWidget {
  const LikeItApp({super.key});

  @override
  State<LikeItApp> createState() => _LikeItAppState();
}

class _LikeItAppState extends State<LikeItApp> {

  bool _initialized = false;
  late GoRouter _router;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    final auth = context.read<AuthProvider>();

    _router = GoRouter(
      refreshListenable: auth,
      initialLocation: '/',
      redirect: (context, state) {
        final path = state.uri.path;
        final isAuthPage = path == '/login' || path == '/signup';
        final loggedIn = auth.isLoggedIn;

        if (!loggedIn && !isAuthPage) return '/login';
        if (loggedIn && isAuthPage) return '/';
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const MasterView(),
          routes: [
            GoRoute(
              path: 'likes',
              builder: (_, state) {
                final images = state.extra as List<ImageModel>;
                return LikesView(allImages: images);
              },
            ),
            GoRoute(
              path: 'details',
              builder: (_, state) {
                final image = state.extra as ImageModel;
                return DetailsView(image: image);
              },
            ),
          ],
        ),
        GoRoute(path: '/profile', builder: (_, __) => const ProfileView()),
        GoRoute(path: '/login', builder: (_, __) => const LoginView()),
        GoRoute(path: '/signup', builder: (_, __) => const SignUpView()),
      ],
    );

    _initialized = true;
  }


  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: theme.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerConfig: _router,
    );
  }
}



