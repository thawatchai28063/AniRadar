import 'package:flutter/material.dart';

class AnimePoster extends StatelessWidget {
  const AnimePoster({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius = 18,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        color: const Color(0xFF312E81),
        child: imageUrl.isEmpty
            ? const Icon(Icons.movie_filter_outlined, color: Colors.white70)
            : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.movie_filter_outlined,
                    color: Colors.white70,
                  );
                },
              ),
      ),
    );
  }
}
