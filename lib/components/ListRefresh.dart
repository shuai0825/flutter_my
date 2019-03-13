import 'package:flutter/material.dart';
import 'package:flutter_my/common/NetUrls.dart';
import 'package:flutter_my/common/NetUtils.dart';
import 'package:flutter_my/components/load_view.dart';

class ListRefresh extends StatefulWidget {
  final renderItem;
  final requestApi;


  ListRefresh(this.requestApi, this.renderItem);

  @override
  State<StatefulWidget> createState() => ListRefreshState();
}

class ListRefreshState extends State<ListRefresh>{
  //列表滑动监听
  ScrollController _scrollController = ScrollController();

  /// 给Snack用的。
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

  /// 获取到的文章列表数据集合。给ListView构建Item时使用。
  List items = List();

  /// 文章总条数，用来做加载更多的判断用的。
  var _totalCount;

  /// 当前的页面，这个接口是从0开始的。
  var _curPager = 0;

  /// 标志当前在请求中。
  var _isRequesting = false;


  @override
  void initState() {
    super.initState();
    print("子初始化");
      _refresh();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
              _scrollController.position.pixels &&
          !_isRequesting) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("子构建");
    if (items.length == 0) {
      return load_view();
    } else {
      return RefreshIndicator(
          child: ListView.builder(
            itemBuilder: (context, index) {
//              if (index == 0 && index != items.length) {
//                if(widget.headView is Function){
//                  return widget.headView();
//                }else {
//                  return Container(height: 0);
//                }
//              }

              if (index == items.length) {
                return _buildProgressIndicator();
              } else {
                return widget.renderItem(index, items[index]);
              }
            },
            itemCount: items.length,
            controller: _scrollController,
          ),
          onRefresh: _refresh);
    }
  }

  // 下拉刷新动作，这里需要看下文档
  Future _refresh() async {
    _curPager = 0;
    _getMoreData();
  }

  Future _getMoreData() async {
    if (!_isRequesting) {
      setState(() {
        _isRequesting = true;
      });
      try {
        List newEntries = await widget.requestApi(_curPager);
        if (newEntries.length > 0 && this.mounted) {
          setState(() {
            _isRequesting = false; //作用1：用于控制加载更多条目
            if (_curPager == 0) {
              items = newEntries;
            } else {
              items.addAll(newEntries);
            }
            _curPager++;
          });
        } else {
          setState(() {
            _isRequesting = false;
          });
          Scaffold.of(context)
              .showSnackBar(new SnackBar(content: new Text('没有更多数据了....')));
        }
      } catch (e) {
        print("网络异常" + e.message); //异常捕获，父反正可以捕获子类产生的异常
        setState(() {
          _isRequesting = false;
        });
      }
    }
  }

  /**
   * 绘制上拉加载更多，条目展示
   */
  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(11.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Offstage(
                //Offstage隐藏、Opacity透明度
                offstage: _isRequesting ? false : true,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                )),
            SizedBox(height: 10.0),
            Text(
              '稍等片刻更精彩',
              style: TextStyle(
                  fontSize: 14.0, color: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
