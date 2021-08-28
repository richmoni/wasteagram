import 'package:flutter/material.dart';

/// A customizable material design app bar.
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  /// The title of the app bar.
  final String title;

  /// Indicates whether to include a leading back button. False by default.
  final bool backButton;

  CustomAppBar({Key? key, required this.title, this.backButton = false})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // If back button is requested then instantiate the leading widget.
    Widget? _leading;
    if (backButton) {
      _leading = Semantics(
        child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        button: true,
        enabled: true,
        label: 'Tap to return to list screen',
      );
    }
    return AppBar(
      title: Text(title),
      centerTitle: true,
      leading: _leading,
    );
  }
}
