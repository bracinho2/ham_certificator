import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:guarani/src/widgets/carousel/guarani_carousel_item.dart';

class GuaraniCarouselWidget extends StatefulWidget {
  final List<GuaraniCarouselItem> items;
  const GuaraniCarouselWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<GuaraniCarouselWidget> createState() => _GuaraniCarouselWidgetState();
}

class _GuaraniCarouselWidgetState extends State<GuaraniCarouselWidget> {
  List<GuaraniCarouselItem> get _items => widget.items;

  final _pageController = PageController();
  int _selectedIndicator = 0;
  late Timer _timer;
  late int bannerCount;
  double bannerHeight = 400;

  void _pageControllerListener() {
    _pageController.addListener(() {
      final int next = _pageController.page!.round();
      if (_selectedIndicator != next) {
        setState(() {
          _selectedIndicator = next;
        });
      }
    });
  }

  void _bannerPass() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final page = Random().nextInt(_items.length);

      setState(() {
        _pageController.animateToPage(page,
            duration: const Duration(seconds: 1), curve: Curves.easeIn);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _pageControllerListener();
    _bannerPass();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void setHeight(double width) {
    setState(() {
      bannerHeight = width * .4;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    setHeight(mediaQueryData.size.width);

    return SizedBox(
      height: bannerHeight,
      width: mediaQueryData.size.width,
      child: Stack(
        children: [
          BannerView(
            itens: _items,
            height: bannerHeight,
            controller: _pageController,
          ),
          BannerIndicator(
            itens: _items,
            controller: _pageController,
            selectedIndicator: _selectedIndicator,
          ),
        ],
      ),
    );
  }
}

class BannerView extends StatefulWidget {
  final List<GuaraniCarouselItem> itens;
  final double height;
  final PageController controller;
  const BannerView({
    Key? key,
    required this.itens,
    required this.height,
    required this.controller,
  }) : super(key: key);

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  double textTitleSize = 40;
  double textSubtitleSize = 20;

  void setTitleSize(double width) {
    setState(() {
      textTitleSize = width * .03;
    });
  }

  void setSubtitleSize(double width) {
    setState(() {
      textSubtitleSize = width * .02;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    setTitleSize(mediaQueryData.size.width);
    setSubtitleSize(mediaQueryData.size.width);

    return SizedBox(
      height: widget.height,
      child: PageView(
        controller: widget.controller,
        children: widget.itens
            .map(
              (banner) => InkWell(
                // onTap: () {
                //   banner.onTap(banner);
                // },
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          banner.imageUrl,
                        ).image,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: textTitleSize,
                        right: textTitleSize,
                        bottom: textTitleSize,
                      ),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.amber,
                                  child: Text(
                                    banner.eventMessage,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                color: Colors.amber,
                                child: Text(
                                  banner.eventName,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: textTitleSize,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: textSubtitleSize,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                color: Colors.amber,
                                child: Text(
                                  '${banner.eventLocal} | ${banner.eventDate}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: textSubtitleSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
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

class BannerIndicator<T> extends StatelessWidget {
  final List<T> itens;
  final PageController controller;
  final int selectedIndicator;
  const BannerIndicator({
    Key? key,
    required this.itens,
    required this.controller,
    required this.selectedIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: itens.asMap().entries.map((entry) {
            int index = entry.key;
            return InkWell(
              onTap: () {
                controller.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: selectedIndicator == index
                    ? Container(
                        height: 10,
                        width: 5,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.rectangle,
                        ),
                      )
                    : Container(
                        height: 5,
                        width: 20,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                        ),
                      ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
