import 'package:flutter/material.dart';
import 'package:guarani/src/extensions/date_time_extension.dart';
import 'package:guarani/src/widgets/event_list/guarani_event_list_item.dart';

class GuaraniEventListWidget extends StatefulWidget {
  const GuaraniEventListWidget({
    super.key,
    required this.items,
    this.isFutureEvents = false,
  });

  final List<GuaraniEventListItem> items;
  final bool isFutureEvents;

  @override
  State<GuaraniEventListWidget> createState() => _GuaraniEventListWidgetState();
}

class _GuaraniEventListWidgetState extends State<GuaraniEventListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: widget.items
            .map(
              (event) => InkWell(
                overlayColor: MaterialStateProperty.resolveWith((states) {
                  return Colors.black12;
                }),
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  event.onTap(event);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            width: 400,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  event.imageUrl,
                                ).image,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.amber,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    event.startDate.getMonthNameAbreviation(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.amber,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    event.startDate.day.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 45,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  event.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  event.local,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
