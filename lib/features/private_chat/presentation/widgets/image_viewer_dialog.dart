import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewerDialog extends StatefulWidget {
  final List<String> imagesList;

  ImageViewerDialog({
    Key key,
    this.imagesList,
  }) : super(key: key);

  @override
  _ImageViewerDialogState createState() => _ImageViewerDialogState();
}

class _ImageViewerDialogState extends State<ImageViewerDialog> {
  bool _showHeaderAndFooter = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            _showHeaderAndFooter = !_showHeaderAndFooter;
          });
        },
        child: SafeArea(
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: [
                Dismissible(
                  key: Key('DisMissKey'),
                  background: const Offstage(),
                  direction: DismissDirection.vertical,
                  resizeDuration: Duration(milliseconds: 1),
                  onDismissed: (_) => Navigator.of(context).pop(),
                  child: _buildImagesSlider(context),
                ),
                //_buildImageCarousel(context),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      reverseDuration: const Duration(milliseconds: 200),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: _showHeaderAndFooter
                          ? Container(
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                              ),
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      SizedBox(width: 18),
                                      Text(
                                        '1 of 5',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      MdiIcons.dotsVertical,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            )
                          : const Offstage(),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      reverseDuration: const Duration(milliseconds: 200),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: _showHeaderAndFooter
                          ? Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                              ),
                              padding:
                                  const EdgeInsetsDirectional.only(start: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Mr YaS',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            .copyWith(color: Colors.white),
                                      ),
                                      Text(
                                        '25.08.21 at 10:44',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        MdiIcons.shareVariant,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {})
                                ],
                              ),
                            )
                          : const Offstage(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagesSlider(BuildContext context) {
    return Center(
      child: PhotoViewGallery.builder(
        reverse: true,
        backgroundDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
        scrollPhysics: const ClampingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: AssetImage(widget.imagesList[index]),
            minScale: PhotoViewComputedScale.contained,
            heroAttributes:
                PhotoViewHeroAttributes(tag: widget.imagesList[index]),
          );
        },
        itemCount: widget.imagesList.length,
      ),
    );
  }
}

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String get barrierLabel => '';
}
