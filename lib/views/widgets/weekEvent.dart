import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/models/schedule.dart';
import 'package:tumble/views/eventDetails.dart';

class WeekEvent extends StatelessWidget {
  final Schedule? event;
  final bool empty;

  const WeekEvent({Key? key, this.event, this.empty = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (event != null) {
      return Container(
        height: 23,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(2),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
            )
          ],
        ),
        child: MaterialButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventDetailsPage(
                          event: event!,
                        )));
          },
          child: Row(
            children: [
              Container(
                width: 3,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(2), bottomLeft: Radius.circular(2)),
                  color: Color(int.parse("ff" + event!.color.replaceAll("#", ""), radix: 16)),
                ),
              ),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    width: 100,
                    color: Color(int.parse("ff" + event!.color.replaceAll("#", ""), radix: 16)).withOpacity(0.35),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      DateFormat("HH:mm").format(event!.start) + " - " + DateFormat("HH:mm").format(event!.end),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ),
                  child: Text(
                    event!.title,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 25,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(2),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(2), bottomLeft: Radius.circular(2)),
                color: Colors.grey.shade400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "No scheduled activities",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
