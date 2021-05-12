import 'package:flutter/material.dart';

import 'job_card.dart';

class CardListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (BuildContext c, int i) {
        return JobCard(
          jobName: '汽车UIUE设计师',
          wage: '1.5-2万元',
          companyDescription: '中科创达软件 已上市 1000-9999人',
          tags: ['3-5年', '本科', '视觉设计', '动效设计', 'UI设计'],
          employer: '韩先生·HRBP',
          location: '甘井子 小平岛',
        );
      },
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 16);
      },
    );
  }

  const CardListWidget();
}

class ListWidget extends StatelessWidget {
  const ListWidget(this.tabKey, {this.scrollDirection = Axis.vertical});

  final String tabKey;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext c, int i) {
        return Container(
            //decoration: BoxDecoration(border: Border.all(color: Colors.orange,width: 1.0)),
            alignment: Alignment.center,
            height: 60.0,
            child: Text('$tabKey : List$i'));
      },
      itemCount: 100,
      scrollDirection: scrollDirection,
    );
  }
}
