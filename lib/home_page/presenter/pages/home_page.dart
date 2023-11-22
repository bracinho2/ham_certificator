import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:guarani/guarani.dart';
import 'package:ham_certificator/home_page/presenter/pages/widgets/available_events_list_widget.dart';
import 'package:ham_certificator/home_page/presenter/pages/widgets/past_events_list_widget.dart';

import '../../../events/controller/event_controller.dart';
import '../facade/home_page_facade.dart';
import 'widgets/carousel_events_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.facade,
  });

  final HomePageFacade facade;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageFacade get _facade => widget.facade;

  @override
  void initState() {
    super.initState();
    _facade.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GuaraniHeaderMenuWidget(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CarouselEventsWidget(
                  eventController: GetIt.I.get<EventController>(),
                ),
                if (constraints.maxWidth < 800)
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: TitleWidget(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: DescriptionTextWidget(),
                      ),
                    ],
                  ),
                if (constraints.maxWidth > 800)
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TitleWidget(
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(width: 50),
                        Expanded(
                          flex: 6,
                          child: DescriptionTextWidget(),
                        ),
                      ],
                    ),
                  ),
                const Divider(
                  thickness: 2,
                ),
                const GuaraniTitleSeparatorWidget(
                  title: 'Agenda',
                  subtitle: 'Clique no Evento para Informações',
                ),
                AvailableEventsListWidget(
                  eventController: GetIt.I.get<EventController>(),
                ),
                const Divider(
                  thickness: 2,
                ),
                const GuaraniTitleSeparatorWidget(
                  title: 'Certificados',
                  subtitle: 'Clique no evento e baixe seu certificado',
                ),
                PastEventsListWidget(
                  eventController: GetIt.I.get<EventController>(),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const GuaraniFooterWidget(),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget(
      {super.key, this.textSize = 50, this.textAlign = TextAlign.center});

  final double textSize;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Ham Certificator',
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: textSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class DescriptionTextWidget extends StatelessWidget {
  const DescriptionTextWidget({
    super.key,
    this.textSize = 20,
    this.textAlign = TextAlign.justify,
  });

  final double textSize;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      '''O Radioamadorismo é uma comunidade ativa ao redor do mundo. Nós radioamadores realizamos muitas atividades e temos a tradição de certificá-las. Atividadess como Eventos Formativos, Eventos Festivos, Field Days, Ativações especiais são algumas das atividades desenvolvidas. Porém, a entrega dos certificados sempre é uma atividade onerosa. Pensando nisso, surgiu o Ham Certificador como a ferramenta para entrega de certificados. Simples e fácil de usar!''',
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: textSize,
      ),
    );
  }
}
