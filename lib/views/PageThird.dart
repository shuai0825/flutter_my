import 'package:flutter/material.dart';
import 'package:flutter_my/common/list_view_item.dart';
import 'package:flutter_my/components/ListRefresh.dart' as listComp;
import 'package:flutter_my/common/NetUrls.dart';
import 'package:flutter_my/common/NetUtils.dart';

class PageThird extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PageThirdState();
}

class PageThirdState extends State<PageThird>
    with AutomaticKeepAliveClientMixin {


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  print('初始化');
  }

  @override
  Widget build(BuildContext context) {
    print('构建');
    return listComp.ListRefresh(getArticleData, makeCard);
  }

  /**
   * 绘制每个条目
   */
  Widget makeCard(index, item) {
    var myTitle = '${item['title']}';
    var myUsername = '${'👲'}: ${item['superChapterName']} ';
    var codeUrl = '${item['link']}';
    return new ListViewItem(
      itemUrl: codeUrl,
      itemTitle: myTitle,
      data: myUsername,
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
