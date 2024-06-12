import 'package:flutter/material.dart';

class CustomOverlayPortal extends StatefulWidget {
  final String name;
  final List<String> entityList;
  final ValueChanged<String?>? onChanged;

  const CustomOverlayPortal({
    Key? key,
    required this.name,
    required this.entityList,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomOverlayPortal> createState() => _CustomOverlayPortalState();
}

class _CustomOverlayPortalState extends State<CustomOverlayPortal> {
  OverlayPortalController overlayPortalController = OverlayPortalController();
  String? selectedEntity;
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 6),
        Builder(
          builder: (BuildContext context) {
            return OverlayPortal(
              controller: overlayPortalController,
              overlayChildBuilder: (context) {
                // Ensure the RenderBox is available before using it
                final RenderBox? renderBox =
                    _key.currentContext?.findRenderObject() as RenderBox?;
                if (renderBox == null) {
                  return const SizedBox.shrink();
                }
                final position = renderBox.localToGlobal(Offset.zero);
                return Positioned(
                  top: position.dy + renderBox.size.height + 10,
                  left: position.dx,
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    elevation: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: Color(0xff2A2A2D),
                      ),
                      width: renderBox.size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.entityList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              widget.entityList[index],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            onTap: () {
                              setState(() {
                                selectedEntity = widget.entityList[index];
                                overlayPortalController.toggle();
                                if (widget.onChanged != null) {
                                  widget.onChanged!(selectedEntity);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
              child: GestureDetector(
                key: _key,
                onTap: overlayPortalController.toggle,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff2A2A2D)),
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedEntity ?? "",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Icon(
                        Icons.expand_circle_down,
                        size: 20,
                        color: Color(0xff2A2A2D),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
