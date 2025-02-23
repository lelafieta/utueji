import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/event_cubit.dart';
import '../cubit/event_state.dart';
import '../widgets/event_widget.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        print(state);
        if (state is EventLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EventLoaded) {
          if (state.events.isEmpty) {
            return const Center(child: Text("Sem eventos registados"));
          } else {
            final events = state.events;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Eventos próximos de si",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextButton(onPressed: () {}, child: Text("Ver mais"))
                      ],
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.95,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      animateToClosest: false,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: false,
                      enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: events.map((event) {
                      return EventWidget(
                        event: event,
                      );
                    }).toList(),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Para ti",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        // TextButton(onPressed: () {}, child: Text("Ver mais"))
                      ],
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.all(14),
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return EventWidget(
                          event: event,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: state.events.length)
                ],
              ),
            );
          }
        }
        return Text("data");
      },
    );
  }
}
