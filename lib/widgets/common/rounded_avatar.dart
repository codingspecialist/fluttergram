import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';

class RoundedAvatar extends StatelessWidget {
  final size;

  const RoundedAvatar({
    Key? key,
    this.size = avatar_size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: "https://picsum.photos/id/100/30/30",
        width: size,
        height: size,
      ),
    );
  }
}
