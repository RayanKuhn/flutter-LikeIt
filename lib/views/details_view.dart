import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:likeit/providers/like_provider.dart';
import 'package:likeit/widgets/theme_switcher.dart';
import 'package:provider/provider.dart';
import '../models/image_model.dart';

class DetailsView extends StatelessWidget {
  final ImageModel image;

  const DetailsView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
        actions: const [ThemeSwitcher()],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Détail de l\'image',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: image.imageUrl,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Consumer<LikeProvider>(
                    builder: (context, likeProvider, _) {
                      final isLiked = likeProvider.isLiked(image.id);
                      return GestureDetector(
                        onTap: () => likeProvider.toggleLike(image.id),
                        child: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.pinkAccent : Colors.white,
                          size: 32,
                          shadows: const [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Text(
              'Auteur : ${image.author}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

