import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tumble/models/schedule.dart';
import 'dart:math';

class EventDetailsPage extends StatelessWidget {
  final Schedule event;

  const EventDetailsPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            // Column for weekday + time and date
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      DateFormat("EEEE").format(event.start).toUpperCase(),
                      style: const TextStyle(fontSize: 75),
                    ),
                  ),
                  // Row for time and date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Column for time stamp
                      Column(
                        children: [
                          Text(
                            DateFormat("HH:mm").format(event.start),
                            style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            DateFormat("HH:mm").format(event.end),
                            style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat("MMM").format(event.start).toUpperCase() +
                            " " +
                            DateFormat("dd").format(event.start),
                        style: const TextStyle(fontSize: 75),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Image(
                    image: const AssetImage("assets/images/detailsSplitter.png"),
                    color: Color(int.parse("ff" + event.color.replaceAll("#", ""), radix: 16)).withOpacity(0.35),
                  ),
                ),
                Expanded(
                  child: Transform.rotate(
                    angle: pi / 180 * 180,
                    child: Image(
                        image: const AssetImage("assets/images/detailsSplitter.png"),
                        color: Color(int.parse("ff" + event.color.replaceAll("#", ""), radix: 16)).withOpacity(0.35)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.course,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              event.title,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                event.location,
                                softWrap: true,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                event.lecturer,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
