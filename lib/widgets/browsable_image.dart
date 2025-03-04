
import 'package:flutter/material.dart';

class BrowsableImage extends StatelessWidget {
  final Color? backgroundColor;
  final IconData? icon; 
  final String? imageUrl;

  // Constructor
  const BrowsableImage({
    super.key,
    this.backgroundColor,
    this.icon = Icons.music_note,
    this.imageUrl = ''
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: SizedBox(
        height: 60,
        width: 60,
        child: 
          imageUrl != null && imageUrl!.isNotEmpty ?
            Image.network(imageUrl!, height: 60, fit: BoxFit.fill, errorBuilder: (context, error, stackTrace) {
              return FittedBox(fit: BoxFit.fill, child: Container(color:backgroundColor ?? Theme.of(context).colorScheme.primary, child: Padding(padding: EdgeInsets.all(10), child: Icon(icon, color: Colors.white))));
            },)
          :
            FittedBox(fit: BoxFit.fill, child: Container(color:backgroundColor ?? Theme.of(context).colorScheme.primary, child: Padding(padding: EdgeInsets.all(10), child: Icon(icon, color: Colors.white))))
      ),
    );
  }
}