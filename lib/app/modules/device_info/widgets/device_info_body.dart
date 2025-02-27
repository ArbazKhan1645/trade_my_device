// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trademydevice/app/core/widgets/optimized_animated_container.dart';
import 'package:flutter/foundation.dart';
import '../../home/widgets/homepage_header.dart';
import '../controllers/device_info_controller.dart';

class DeviceInfoBodyScreen extends StatelessWidget {
  const DeviceInfoBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool enableAnimations = !kIsWeb || !kReleaseMode;
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return OptimizedAnimatedContainer(
            shouldAnimate: enableAnimations,
            child: DeviceInfoBodySubScreen(constraints: constraints),
          );
        },
      ),
    );
  }
}

class DeviceInfoBodySubScreen extends StatefulWidget {
  const DeviceInfoBodySubScreen({super.key, required this.constraints});
  final BoxConstraints constraints;

  @override
  State<DeviceInfoBodySubScreen> createState() =>
      _DeviceInfoBodySubScreenState();
}

class _DeviceInfoBodySubScreenState extends State<DeviceInfoBodySubScreen> {
  late final DeviceInfoController controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(DeviceInfoController());
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(context),
        _buildSliverList(),
      ],
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: 90,
      pinned: true,
      toolbarHeight: 65,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          bool isCollapsed = constraints.biggest.height <= 65;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              if (!isCollapsed)
                HomePageHeaderWidget(constraints: widget.constraints),
              if (isCollapsed)
                _buildCollapsedTitle(constraints: widget.constraints),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCollapsedTitle({BoxConstraints? constraints}) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 85,
        child: buildWidgetOFScrollHeader(context, constraints: constraints),
      ),
    );
  }

  Widget _buildSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          double scale = 1.0;
          if (_scrollController.hasClients) {
            double offset = _scrollController.offset;
            scale = 1 + ((index * 100 - offset).abs() / 200).clamp(0.8, 1.0);
          }
          return Transform.scale(
              scale: scale, child: controller.dashboardViewBodyScreen[index]);
        },
        childCount: controller.dashboardViewBodyScreen.length,
      ),
    );
  }
}
