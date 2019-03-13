import 'package:flutter/material.dart';
import 'package:flutter_my/components/SearchInput.dart';
import 'package:flutter_my/views/PageFirst.dart';
import 'package:flutter_my/views/PageSecond.dart';
import 'package:flutter_my/views/PageThird.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TopTabWidget();
}

class TopTabWidget extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // 底部导航栏的文字 ， 给appBar 共用一下。
  var _bottomTitles = ["首页", "知识", "热门"];

  // 底部导航栏未选中时的图片
  var _bottomIconNor = [
    "assets/images/icon_bottom_main_nor.png",
    "assets/images/icon_bottom_knowledge_nor.png",
    "assets/images/icon_bottom_hot_nor.png",
  ];

  // 底部导航栏选中时的图片
  var _bottomIconChecked = [
    "assets/images/icon_bottom_main_checked.png",
    "assets/images/icon_bottom_knowledge_checked.png",
    "assets/images/icon_bottom_hot_checked.png",
  ];

  // 底部导航栏当前选中的页面
  var _currentBottomIndex = 0;



  // 页面
  var _body;
  List<Widget> pages = [PageFirst(), PageSecond(), PageFirst()];
  PageController _pageController;
  TabController _tabController;

  @override
  void initState() {
   _pageController = new PageController(initialPage: 0);
   // _tabController = TabController(length: _bottomTitles.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _body = PageView.builder(
      itemBuilder: ((BuildContext context, int index) {
        return pages[index];
      }),
      controller: _pageController,
      onPageChanged: _pageChange,
      itemCount: pages.length,
    );
//    _body = IndexedStack(
//        children: <Widget>[
//          PageFirst(),
//          PageSecond(),
//          PageFirst()
//        ],);
    return Scaffold(
        appBar: AppBar(
          title: buildSearchInput(context),
        ),
        body: _body,
        bottomNavigationBar: BottomNavigationBar(
          items: getBottomNavigationBarItems(),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentBottomIndex,
          onTap: (index) {
            setState(() {
              _currentBottomIndex = index;
              _pageController.jumpToPage(index);
            });

          },
        ));
  }

  //抽取顶部搜索页面
  Widget buildSearchInput(BuildContext context) {
    return new SearchInput();
  }

  //生成单个底部按钮
  getBottomNavigationBarItems() => List.generate(
      _bottomTitles.length,
      (i) => BottomNavigationBarItem(
          icon: getBottomIcon(i), title: getBottomTitle(i)));

  //切换底部文字
  getBottomTitle(int i) => Text(
        _bottomTitles[i],
        style: TextStyle(
            fontSize: 14.0,
            color: _currentBottomIndex == i ? Colors.green : Colors.grey),
      );

  //切换底部图片
  getBottomIcon(int i) => Image.asset(
        getBottomIconPath(i),
        width: 25.0,
        height: 25.0,
      );

  String getBottomIconPath(int i) =>
      _currentBottomIndex == i ? _bottomIconChecked[i] : _bottomIconNor[i];

  void _pageChange(int value) {
    setState(() {
      _currentBottomIndex = value;
    });
  }
}
