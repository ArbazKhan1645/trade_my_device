// ignore_for_file: use_build_context_synchronously, avoid_print, unnecessary_null_comparison, depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import '../../../core/widgets/optimized_animated_container.dart';
import '../controllers/home.controller.dart';
import '../widgets/homepage_header.dart';

class HomePageViewScreen extends StatelessWidget {
  const HomePageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool enableAnimations = !kIsWeb || !kReleaseMode;
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return OptimizedAnimatedContainer(
            shouldAnimate: enableAnimations,
            child: DashBoardViewBodyScreen(constraints: constraints),
          );
        },
      ),
    );
  }
}

class DashBoardViewBodyScreen extends StatefulWidget {
  const DashBoardViewBodyScreen({super.key, required this.constraints});
  final BoxConstraints constraints;

  @override
  State<DashBoardViewBodyScreen> createState() =>
      _DashBoardViewBodyScreenState();
}

class _DashBoardViewBodyScreenState extends State<DashBoardViewBodyScreen> {
  late final HomeController controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
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
              scale: scale,
              child: controller.getDashboardViewBodyScreen[index]);
        },
        childCount: controller.getDashboardViewBodyScreen.length,
      ),
    );
  }
}
