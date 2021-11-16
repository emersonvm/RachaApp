import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_app/components/event_grid_item.dart';
import 'package:racha_app/models/event.dart';
import 'package:racha_app/models/event_list.dart';

class EventGrid extends StatelessWidget {
  EventGrid();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventList>(context);
    final List<Event> loadedEvents = provider.items;
    if (loadedEvents.length == 0)
      return Stack(children: [
        Container(
          height: 200,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shadowColor: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const ListTile(
                  title: Text(
                    'Você não possui nenhum\revento! \n\n Para adicionar um evento você deve clicar no botão + abaixo.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 1500,
          height: 1400,
        ),
      ]);
    else
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
