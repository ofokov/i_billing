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

class _CustomOverlayPortalState extends State<CustomOverlayPortal>
    with TickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  String? selectedEntity;
  final GlobalKey _key = GlobalKey();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context)?.insert(_overlayEntry!);
      _animationController.forward();
    } else {
      _animationController.reverse().then((value) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        final RenderBox? renderBox =
            _key.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox == null) return const SizedBox.shrink();

        final position = renderBox.localToGlobal(Offset.zero);
        return Positioned(
          top: position.dy + renderBox.size.height + 10,
          left: position.dx,
          child: Material(
            color: Colors.transparent,
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Container(
                  width: renderBox.size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xff2A2A2D),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      widget.entityList.length,
                      (index) => Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {
                            setState(() {
                              selectedEntity = widget.entityList[index];
                              _toggleOverlay();
                              widget.onChanged?.call(selectedEntity);
                            });
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: index == 0 ? 16 : 8.0,
                                  bottom:
                                      (index == widget.entityList.length - 1)
                                          ? 16
                                          : 8,
                                  left: 24,
                                  right: 24,
                                ),
                                child: Text(
                                  widget.entityList[index],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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
        GestureDetector(
          key: _key,
          onTap: _toggleOverlay,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff2A2A2D)),
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(6)),
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
        const SizedBox(height: 16),
      ],
    );
  }
}
