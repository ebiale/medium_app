import 'package:flutter/material.dart';
import 'package:rss_medium_app/ui/shared/custom_text.dart';

class ListTileItem extends StatefulWidget {
  final String searchTerm;

  const ListTileItem({
    required this.searchTerm,
    super.key,
  });

  @override
  _ListTileItemState createState() => _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        padding: EdgeInsets.only(left: _isHovered ? 30 : 10),
        child: Row(
          children: [
            Expanded(
              child: CustomWhiteText(
                text: widget.searchTerm,
                fontSize: 18,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: _isHovered ? Colors.white : Colors.transparent,
            ),
          ],
        ),
      ),
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
    );
  }

  void _onHover(bool hovered) {
    setState(() {
      _isHovered = hovered;
    });
  }
}
