import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:revive/presentation/view/selected_image_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class GalleryGridWidget extends StatelessWidget {
  GalleryGridWidget({
    super.key,
    required this.loading,
    required List<Medium> media,
  }) : _media = media;

  bool loading;
  final List<Medium> _media;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : MasonryGridView.builder(
            itemCount: _media.length,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              return OpenContainer(
                closedColor: Colors.transparent,
                openColor: Colors.transparent,
                closedElevation: 0,
                openElevation: 0,
                closedBuilder: (context, action) =>
                    AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  columnCount: 3,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: MemoryImage(kTransparentImage),
                        image: ThumbnailProvider(
                          mediumId: _media[index].id,
                          mediumType: _media[index].mediumType,
                          highQuality: true,
                        ),
                      ),
                    ),
                  ),
                ),
                openBuilder: (context, action) => SelectedImageScreen(
                  medium: _media[index],
                  image: PhotoProvider(
                    mediumId: _media[index].id,
                  ),
                ),
              );
            },
          );
  }
}
