import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//写一个验证码输入组件  要输入16 或者 20个  4*4  4*5
class CarInputPage extends StatefulWidget {
  //输入框的总数
  final int total;
  final int rowCount;
  final double size;

  const CarInputPage({
    super.key,
    required this.total,
    this.rowCount = 4,
    this.size = 60,
  });

  @override
  createState() => _CarInputPageState();
}

class _CarInputPageState extends State<CarInputPage> {
  TextEditingController controller = TextEditingController();
  List dataList = [];

  List fillData(List data) {
    if (data.length < widget.total) {
      data.add('');
      fillData(data);
    }
    return data;
  }

  @override
  void initState() {
    dataList = List.generate(widget.total, (i) => '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (kDebugMode) {
            print('object');
          }
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Container(
          width: 500,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  // Container(
                  //   width: 200,
                  //   height: 200,
                  //   child: GridView(
                  //     physics: NeverScrollableScrollPhysics(),
                  //     gridDelegate:
                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 4),
                  //     children: List.generate(
                  //         dataList.length, (i) => renderContainer(dataList[i])),
                  //   ),
                  // ),
                  Container(
                    width: 200,
                    height: 400,
                    child: ScrollConfiguration(
                      behavior: NoScrollBehavior(), // 自定义无滚动条行为
                      child: GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(), // 禁用滚动
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        children: List.generate(
                          dataList.length,
                          (i) => renderContainer(dataList[i]),
                        ),
                      ),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: dataList
                  //       .map<Widget>((e) => renderContainer(e))
                  //       .toList(),
                  // ),
                  TextField(
                    maxLength: widget.total,
                    onChanged: (value) {
                      List data = [];
                      for (int i = 0; i < value.length; i++) {
                        data.add(value.substring(i, i + 1));
                      }
                      data = fillData(data);
                      if (mounted) {
                        setState(() {
                          dataList = data;
                        });
                      }
                    },
                    controller: controller,
                    cursorWidth: 0,
                    cursorColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.transparent),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  renderContainer(title) {
    return Container(
      // width: widget.size,
      // height: widget.size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
              color: title == '' ? Colors.green : Colors.blue, width: 2)),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, color: Colors.blue),
      ),
    );
  }
}

class NoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child; // 不显示滚动指示器
  }
}
