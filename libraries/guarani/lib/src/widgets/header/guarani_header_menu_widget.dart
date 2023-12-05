import 'package:flutter/material.dart';

class GuaraniHeaderMenuWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const GuaraniHeaderMenuWidget({
    super.key,
    this.showEvent = false,
    this.eventName,
    this.translate,
  });

  final bool showEvent;
  final String? eventName;
  final Function()? translate;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);

    final mediaQueryData = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50),
      height: 100,
      width: mediaQueryData.size.width,
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (canPop)
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'HamCertificator',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (showEvent && mediaQueryData.size.width < 800)
                    Text(
                      eventName!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              if (showEvent && mediaQueryData.size.width > 800)
                Text(
                  eventName!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          if (translate != null)
            IconButton(
              onPressed: translate,
              icon: const Icon(
                Icons.language,
                color: Colors.white,
                size: 30,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
