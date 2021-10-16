import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_app/components/event_grid_item.dart';
import 'package:racha_app/models/event.dart';
import 'package:racha_app/models/event_list.dart';

class EventGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  EventGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventList>(context);
    final List<Event> loadedEvents =
        showFavoriteOnly ? provider.favoriteEvents : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedEvents.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedEvents[i],
        child: EventGridItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
