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
        title: const Text('Détail de l\'image'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer<LikeProvider>(
            builder: (context, likeProvider, child) {
              final isLiked = likeProvider.isLiked(image.id);

              return IconButton(
                onPressed: () => likeProvider.toggleLike(image.id),
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.pinkAccent : Colors.grey,
                ),
              );
            },
          ),
          const ThemeSwitcher(),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: image.imageUrl,
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Auteur : ${image.author}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Text(
            //   'ID de l\'image : ${image.id}',
            //   style: const TextStyle(color: Colors.grey),
            // ),
          ],
        ),
      ),
    );
  }
}
