// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/core/widgets/optimized_animated_container.dart';

import '../../home/widgets/homepage_header.dart';
import '../controllers/device_info_controller.dart';

class DeviceInfoBodyScreen extends StatelessWidget {
  const DeviceInfoBodyScreen({super.key, required this.storeId});
  final String storeId;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xfff9f9f9),
        body: OptimizedAnimatedContainer(
            shouldAnimate: true, child: DeviceInfoBodySubScreen()));
  }
}

class DeviceInfoBodySubScreen extends StatefulWidget {
  const DeviceInfoBodySubScreen({super.key});

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
              if (!isCollapsed) const HomePageHeaderWidget(),
              if (isCollapsed) _buildCollapsedTitle(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCollapsedTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 85,
        child: buildWidgetOFScrollHeader(context),
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
              scale: scale,
              child: controller.getDashboardViewBodyScreen[index]);
        },
        childCount: controller.getDashboardViewBodyScreen.length,
      ),
    );
  }
}
