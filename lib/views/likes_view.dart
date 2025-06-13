import 'package:flutter/material.dart';
import 'package:likeit/models/image_model.dart';
import 'package:likeit/providers/like_provider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class LikesView extends StatelessWidget {
  final List<ImageModel> allImages;

  const LikesView({super.key, required this.allImages});

  @override
  Widget build(BuildContext context) {
    final likedImageIds = context.watch<LikeProvider>().likedImageIds;
    final likedImages =
        allImages.where((img) => likedImageIds.contains(img.id)).toList();

    if (likedImages.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Mes Likes')),
        body: Center(child: Text('Aucune image likée.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Mes Likes')),
      body: ListView.builder(
        itemCount: likedImages.length,
        itemBuilder: (context, index) {
          final image = likedImages[index];
          final isLiked = context.watch<LikeProvider>().isLiked(image.id);

          return GestureDetector(
            onTap: () => context.push('/details', extra: image),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
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
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            context.read<LikeProvider>().toggleLike(image.id);
                          },
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.pinkAccent : Colors.white,
                            size: 30,
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
      ),
    );
  }
}
