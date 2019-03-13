import 'package:flutter/material.dart';
import 'package:flutter_my/common/list_view_item.dart';
import 'package:flutter_my/components/BannerRecycle.dart';
import 'package:flutter_my/components/ListRefresh.dart' as listComp;
import 'package:flutter_my/common/NetUrls.dart';
import 'package:flutter_my/common/NetUtils.dart';

class PageFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PageFirstState();
}

class PageFirstState extends State<PageFirst>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
   // return listComp.ListRefresh(getArticleData, makeCard, headerView);
    return listComp.ListRefresh(getArticleData, makeCard);
  }

  /**
   * 绘制每个条目
   */
  Widget makeCard(index, item) {
    var myTitle = '${item['title']}';
  //  var myTitle = '${item['superChapterName']}';
    var myUsername = '${'👲'}: ${item['superChapterName']} ';
    var codeUrl = '${item['link']}';
    return new ListViewItem(
      itemUrl: codeUrl,
      itemTitle: myTitle,
      data: myUsername,
    );
  }

  /**
   * 绘制轮播图
   */
  headerView() {
    return Column(
      children: <Widget>[
        Stack(
            //alignment: const FractionalOffset(0.9, 0.1),//方法一
            children: <Widget>[
              BannerRecycle(),
            ]),
        SizedBox(
            height: 1, child: Container(color: Theme.of(context).primaryColor)),
        SizedBox(height: 10),
      ],
    );
  }

  /**
   * 网络请求
   */
  Future<List> getArticleData(int curPage) async {
    var articleUrl = "${NetUrls.ARTICLE_LIST}$curPage/json";
    var response = await NetUtils.getDatas(articleUrl, new Map());
    return response['data']["datas"];
  }
}
