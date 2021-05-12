import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:interview_app/config/style.dart';
import 'package:interview_app/widget/list.dart';
import 'package:interview_app/widget/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  const HomePage();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController tabController;
  TabController tabController1;
  TabController tabController2;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController1 = TabController(length: 3, vsync: this);
    tabController2 = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    tabController1.dispose();
    tabController2.dispose();
    super.dispose();
  }

  final labelStyle = TextStyle(
    fontSize: 17.0,
    height: 1.0,
    fontWeight: FontWeight.w500,
  );
  final unselectedLabelStyle = TextStyle(
    fontSize: 16.0,
    height: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 44,
          color: Style.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TabBar(
                  indicator: const ColorTabIndicator(Style.primaryColor),
                  labelColor: Style.activeTabLabelColor0,
                  unselectedLabelColor: Style.inactiveTabLabelColor0,
                  labelStyle: labelStyle,
                  unselectedLabelStyle: unselectedLabelStyle,
                  labelPadding: EdgeInsets.only(right: 16.0),
                  isScrollable: true,
                  tabs: const <Tab>[
                    Tab(text: '全职'),
                    Tab(text: '实习'),
                    Tab(text: '兼职'),
                    Tab(text: '推荐'),
                  ],
                  controller: tabController,
                ),
              ),
              Search(),
            ],
          ),
        ),
        Expanded(
          child: fullTimeJobsView(),
        )
      ],
    );
  }

  Widget fullTimeJobsView() {
    return ExtendedTabBarView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                indicator: const ColorTabIndicator(Style.backgroundColor),
                labelColor: Style.activeTabLabelColor1,
                unselectedLabelColor: Style.inactiveTabLabelColor1,
                labelStyle: labelStyle,
                unselectedLabelStyle: unselectedLabelStyle,
                labelPadding: EdgeInsets.only(right: 16.0),
                isScrollable: true,
                tabs: const <Tab>[
                  Tab(text: 'UI设计'),
                  Tab(text: '产品经理'),
                  Tab(text: '前端工程师'),
                ],
                controller: tabController1,
              ),
            ),
            Expanded(
              child: ExtendedTabBarView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 32,
                                child: TabBar(
                                  indicator: const ColorTabIndicator(
                                      Style.backgroundColor),
                                  labelColor: Style.activeTabLabelColor1,
                                  unselectedLabelColor:
                                      Style.inactiveTabLabelColor1,
                                  labelStyle: labelStyle,
                                  unselectedLabelStyle: unselectedLabelStyle,
                                  labelPadding: EdgeInsets.only(right: 16.0),
                                  indicatorPadding: EdgeInsets.zero,
                                  isScrollable: true,
                                  tabs: const <Tab>[
                                    Tab(text: '推荐'),
                                    Tab(text: '最新'),
                                  ],
                                  controller: tabController2,
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(3, 3),
                                    blurRadius: 6,
                                    color: const Color(0x202E2F82),
                                  ),
                                  BoxShadow(
                                    offset: Offset(-3, -3),
                                    blurRadius: 6,
                                    color: const Color(0xE2FFFFFF),
                                  ),
                                ],
                                color: Style.backgroundColor,
                              ),
                              child: Text(
                                '筛选',
                                style: TextStyle(
                                  height: 1.2,
                                  fontSize: 14,
                                  color: const Color(0xFF636475),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ExtendedTabBarView(
                          controller: tabController2,
                          children: const <Widget>[
                            CardListWidget(),
                            CardListWidget(),
                          ],
                          link: true,
                        ),
                      )
                    ],
                  ),
                  const ListWidget('Tab01'),
                  const ListWidget('Tab02'),
                ],
                controller: tabController1,
              ),
            )
          ],
        ),
        const ListWidget('Tab1'),
        const ListWidget('Tab2'),
        const ListWidget('Tab3'),
      ],
      controller: tabController,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
