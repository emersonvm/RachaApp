import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_app/models/auth.dart';
import 'package:racha_app/models/event.dart';
import 'package:racha_app/utils/app_routes.dart';

class EventGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.asset(
            'assets/gol.png',
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.EVENT_DETAIL,
              arguments: event,
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.orange,
          title: Text(
            event.name,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
