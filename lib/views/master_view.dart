import 'package:flutter/material.dart';
import 'package:likeit/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:likeit/widgets/theme_switcher.dart';
import '../models/image_model.dart';
import '../services/api_service.dart';
import '../providers/like_provider.dart';

class MasterView extends StatefulWidget {
  const MasterView({super.key});

  @override
  State<MasterView> createState() => _MasterViewState();
}

class _MasterViewState extends State<MasterView> {
  final ApiService _api = ApiService();

  final List<ImageModel> _images = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isGridView = false;


  Future<void> _loadPage() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    try {
      final newImages = await _api.fetchImages(page: _currentPage);
      if (newImages.length < 10) _hasMore = false;

      setState(() {
        _images.addAll(newImages);
        _currentPage++;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur de chargement : $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 2,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/LogoMira.png', height: 32),
            const SizedBox(width: 10),
            Text(
              'Mira',
              style: TextStyle(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          Consumer<AuthProvider>(
            builder: (context, auth, _) {
              return Row(
                children: [
                  if (auth.isLoggedIn) ...[
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () => context.push('/likes', extra: _images),
                    ),
                  ],
                  IconButton(
                    icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
                    onPressed: () {
                      setState(() {
                        _isGridView = !_isGridView;
                      });
                    },
                  ),
                  const ThemeSwitcher(),
                  IconButton(
                    icon: Icon(auth.isLoggedIn ? Icons.person : Icons.login),
                    onPressed: () {
                      context.go(auth.isLoggedIn ? '/profile' : '/login');
                    },
                  ),
                ],
              );
            },
          ),
        ],

      ),

      body:
          _images.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : (_isGridView
                  ? GridView.builder(
                    padding: const EdgeInsets.only(
                      bottom: 80,
                      left: 8,
                      right: 8,
                      top: 8,
                    ),
                    itemCount: _images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                    itemBuilder: (context, index) {
                      final image = _images[index];
                      final likeProv = context.watch<LikeProvider>();
                      final isLiked = likeProv.isLiked(image.id);

                      return GestureDetector(
                        onTap: () => context.push('/details', extra: image),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: image.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              if (!_isGridView)
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => likeProv.toggleLike(image.id),
                                    child: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          isLiked ? Colors.red : Colors.white,
                                      size: 20,
                                      shadows: const [
                                        Shadow(
                                          blurRadius: 3,
                                          color: Colors.black,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                  : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      final image = _images[index];
                      final likeProv = context.watch<LikeProvider>();
                      final isLiked = likeProv.isLiked(image.id);

                      return GestureDetector(
                        onTap: () => context.push('/details', extra: image),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: image.imageUrl,
                                      placeholder:
                                          (c, _) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                      errorWidget:
                                          (c, _, __) => const Icon(Icons.error),
                                      height: 300,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap:
                                          () => likeProv.toggleLike(image.id),
                                      child: Icon(
                                        isLiked
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color:
                                            isLiked
                                                ? Colors.pinkAccent
                                                : Colors.white,
                                        size: 28,
                                        shadows: const [
                                          Shadow(
                                            blurRadius: 4,
                                            color: Colors.black,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Auteur : ${image.author}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),

      floatingActionButton:
          _hasMore
              ? FloatingActionButton.extended(
                onPressed: _isLoading ? null : _loadPage,
                label:
                    _isLoading
                        ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text('Charger plus'),
                icon: const Icon(Icons.download),
              )
              : null,
    );
  }
}


