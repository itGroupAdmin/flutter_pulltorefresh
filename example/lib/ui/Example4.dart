import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Example4 extends StatefulWidget {
  @override
  _Example4State createState() => new _Example4State();
}

class _Example4State extends State<Example4> {

  RefreshMode loading=RefreshMode.idle, refreshing=RefreshMode.idle;
  List<Widget> data = [];
  void _getDatas() {

    for (int i = 0; i < 14; i++) {
      data.add(new Text('Data $i'));
    }
  }


  void _onModeChange(isUp,mode){
    if(isUp){
      //must be do it
      setState(() {
        refreshing = mode;
      });
      // this is equals onRefresh()
      if(mode==RefreshMode.refreshing) {
        new Future.delayed(const Duration(milliseconds: 2000), () {
          setState(() {
            refreshing = RefreshMode.failed;
          });
          print("Refreshed!!!");
        });
      }
    }
    else{
      //must be do it
      setState(() {
        loading= mode;
      });
      // this is equals onLoaadmore()
      if(mode==RefreshMode.refreshing) {
        new Future<Null>.delayed(const Duration(milliseconds: 2000), () {

          setState(() {
            data.add(new Text('Data '));

            loading = RefreshMode.completed;
          });
          print("LoadComplete!!!");
        });
      }
    }
  }

  void _onOffsetCallback(bool isUp,double offset) {
    // if you want change some widgets state ,you should rewrite the callback
//    print(offset);
  }

  @override
  void initState() {
    // TODO: implement initState
    _getDatas();

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new SmartRefresher(
            enablePullDownRefresh: true,
            enablePullUpLoad: true,
            refreshMode: this.refreshing,
            loadMode: this.loading,
            onModeChange: _onModeChange,
            onOffsetChange: _onOffsetCallback,
            child: new ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemExtent: 40.0,
              itemCount: data.length,
              itemBuilder: (context,index){
                return data[index];
              },

            )
        )
    );
  }
}
