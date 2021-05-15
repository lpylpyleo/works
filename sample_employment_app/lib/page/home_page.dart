import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/material.dart';
import 'package:interview_app/config/style.dart';
import 'package:interview_app/widget/list.dart';
import 'package:interview_app/widget/search.dart';

import 'chat_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController;
  int page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              const HomePage(),
              const ChatPage(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                page = 1 - page;
                pageController.jumpToPage(page);
              },
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFF191927).withOpacity(0.88),
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor: Style.backgroundColor,
    );
  }
}

/// 未做文字防抖处理
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
            Theme(
              data: Theme.of(context).copyWith(primaryColor: Colors.white),
              child: Container(
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
            ),
            Expanded(
              child: ExtendedTabBarView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        color: Style.backgroundColor,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 32,
                                child: TabBar(
                                  indicator: const ColorTabIndicator(
                                      Style.backgroundColor),
                                  indicatorColor: Style.backgroundColor,
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
