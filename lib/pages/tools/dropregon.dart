import 'dart:convert';
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class DragableWidget extends StatefulWidget {
  const DragableWidget({
    super.key,
    required this.name,
    required this.color,
    required this.dragItemProvider,
  });

  final String name;
  final Color color;
  final DragItemProvider dragItemProvider;

  @override
  State<DragableWidget> createState() => _DragableWidgetState();
}

class _DragableWidgetState extends State<DragableWidget> {
  bool _dragging = false;

  Future<DragItem?> provideDragItem(DragItemRequest request) async {
    final item = await widget.dragItemProvider(request);
    if (item != null) {
      void updateDraggingState() {
        setState(() {
          _dragging = request.session.dragging.value;
        });
      }

      request.session.dragging.addListener(updateDraggingState);
      updateDraggingState();
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return DragItemWidget(
      allowedOperations: () => [DropOperation.copy],
      canAddItemToExistingSession: true,
      dragItemProvider: provideDragItem,
      child: DraggableWidget(
        child: AnimatedOpacity(
          opacity: _dragging ? 0.5 : 1,
          duration: const Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Text(
              widget.name,
              style: const TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

Future<Uint8List> createImageData(Color color) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint()..color = color;
  canvas.drawOval(const Rect.fromLTWH(0, 0, 200, 200), paint);
  final picture = recorder.endRecording();
  final image = await picture.toImage(200, 200);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    super.key,
    required this.draggable,
    required this.dropZone,
  });

  final List<Widget> draggable;
  final Widget dropZone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 8,
                  spacing: 10,
                  children: draggable,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0).copyWith(top: 0),
                  child: dropZone,
                ),
              ),
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            textDirection: TextDirection.rtl,
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: draggable.toList(growable: false),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0).copyWith(right: 0),
                  child: dropZone,
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

extension on DragSession {
  Future<bool> hasLocalData(Object data) async {
    final localData = await getLocalData() ?? [];
    return localData.contains(data);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  Future<DragItem?> textDragItem(DragItemRequest request) async {
    // For multi drag on iOS check if this item is already in the session
    if (await request.session.hasLocalData('text-item')) {
      return null;
    }
    final item = DragItem(
      localData: 'text-item',
      suggestedName: 'PlainText.txt',
    );
    item.add(Formats.plainText('Plain Text Value'));
    return item;
  }

  Future<DragItem?> imageDragItem(DragItemRequest request) async {
    // For multi drag on iOS check if this item is already in the session
    if (await request.session.hasLocalData('image-item')) {
      return null;
    }
    final item = DragItem(
      localData: 'image-item',
      suggestedName: 'Green.png',
    );
    item.add(Formats.png(await createImageData(Colors.green)));
    return item;
  }

  Future<DragItem?> lazyImageDragItem(DragItemRequest request) async {
    // For multi drag on iOS check if this item is already in the session
    if (await request.session.hasLocalData('lazy-image-item')) {
      return null;
    }
    final item = DragItem(
      localData: 'lazy-image-item',
      suggestedName: 'LazyBlue.png',
    );
    item.add(Formats.png.lazy(() async {
      showMessage('Requested lazy image.');
      return await createImageData(Colors.blue);
    }));
    return item;
  }

  Future<DragItem?> virtualFileDragItem(DragItemRequest request) async {
    // For multi drag on iOS check if this item is already in the session
    if (await request.session.hasLocalData('virtual-file-item')) {
      return null;
    }
    final item = DragItem(
      localData: 'virtual-file-item',
      suggestedName: 'VirtualFile.txt',
    );
    if (!item.virtualFileSupported) {
      return null;
    }
    item.addVirtualFile(
      format: Formats.plainTextFile,
      provider: (sinkProvider, progress) {
        showMessage('Requesting virtual file content.');
        final line = utf8.encode('Line in virtual file\n');
        const lines = 10;
        final sink = sinkProvider(fileSize: line.length * lines);
        for (var i = 0; i < lines; ++i) {
          sink.add(line);
        }
        sink.close();
      },
    );
    return item;
  }

  Future<DragItem?> multipleRepresentationsDragItem(
      DragItemRequest request) async {
    // For multi drag on iOS check if this item is already in the session
    if (await request.session.hasLocalData('multiple-representations-item')) {
      return null;
    }
    final item = DragItem(
      localData: 'multiple-representations-item',
    );
    item.add(Formats.png(await createImageData(Colors.pink)));
    item.add(Formats.plainText("Hello World"));
    item.add(Formats.uri(
        NamedUri(Uri.parse('https://flutter.dev'), name: 'Flutter')));
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: HomeLayout(
        draggable: [
          DragableWidget(
            name: 'Text',
            color: Colors.red,
            dragItemProvider: textDragItem,
          ),
          DragableWidget(
            name: 'Image',
            color: Colors.green,
            dragItemProvider: imageDragItem,
          ),
          DragableWidget(
            name: 'Image 2',
            color: Colors.blue,
            dragItemProvider: lazyImageDragItem,
          ),
          DragableWidget(
            name: 'Virtual',
            color: Colors.amber.shade700,
            dragItemProvider: virtualFileDragItem,
          ),
          DragableWidget(
            name: 'Multiple',
            color: Colors.pink,
            dragItemProvider: multipleRepresentationsDragItem,
          ),
        ],
        dropZone: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey.shade200),
            borderRadius: BorderRadius.circular(14),
          ),
          child: _DropZone(),
        ),
      ),
    );
  }
}

class _DropZone extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DropZoneState();
}

class _DropZoneState extends State<_DropZone> {
  @override
  Widget build(BuildContext context) {
    return DropRegion(
      formats: const [
        ...Formats.standardFormats,
        // formatCustom,
      ],
      hitTestBehavior: HitTestBehavior.opaque,
      onDropOver: _onDropOver,
      onPerformDrop: _onPerformDrop,
      onDropLeave: _onDropLeave,
      child: Stack(
        children: [
          Positioned.fill(child: _content),
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: _isDragOver ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: _preview,
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropOperation _onDropOver(DropOverEvent event) {
    setState(() {
      _isDragOver = true;
      _preview = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.black.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ListView(
                  shrinkWrap: true,
                  children: event.session.items
                      .map<Widget>((e) => _DropItemInfo(dropItem: e))
                      .toList(growable: false),
                ),
              ),
            ),
          ),
        ),
      );
    });
    return event.session.allowedOperations.firstOrNull ?? DropOperation.none;
  }

  Future<void> _onPerformDrop(PerformDropEvent event) async {
    // Obtain additional reader information first
    // final readers = await Future.wait(
    // event.session.items.map(
    //       (e) => ReaderInfo.fromReader(
    //     e.dataReader!,
    //     localData: e.localData,
    //   ),
    // ),
    // );

    if (!mounted) {
      return;
    }
    //
    // buildWidgetsForReaders(context, readers, (value) {
    //   setState(() {
    //     // Use super_sliver_list to get around bad sliver list performance
    //     // with large amount if items.
    //     final delegate = SliverChildListDelegate(value
    //         .intersperse(const SizedBox(height: 10))
    //         .toList(growable: false));
    //     _content = CustomScrollView(
    //       slivers: [
    //         SliverPadding(
    //           padding: const EdgeInsets.all(10),
    //           sliver: SuperSliverList(delegate: delegate),
    //         )
    //       ],
    //     );
    //   });
    // });
  }

  void _onDropLeave(DropEvent event) {
    setState(() {
      _isDragOver = false;
    });
  }


  Future<PlatformFile?> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [],
      withData: true,
    );
    if (result != null) {
      return result.files.single;
    }
    return null;
  }

  bool _isDragOver = false;

  Widget _preview = const SizedBox();
  final Widget _content = const Center(
    child: Text(
      'Drop here',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
    ),
  );
}

class _DropItemInfo extends StatelessWidget {
  const _DropItemInfo({
    required this.dropItem,
  });

  final DropItem dropItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (dropItem.localData != null)
              Text.rich(TextSpan(children: [
                const TextSpan(
                  text: 'Local data: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '${dropItem.localData}'),
              ])),
            const SizedBox(
              height: 4,
            ),
            Text.rich(TextSpan(children: [
              const TextSpan(
                text: 'Native formats: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: dropItem.platformFormats.join(', ')),
            ])),
          ],
        ),
      ),
    );
  }
}

class SelectFile extends StatefulWidget {
  const SelectFile({super.key});

  @override
  State<SelectFile> createState() => _SelectFileState();
}

class _SelectFileState extends State<SelectFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('拖动文件'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              DropRegion(
                formats: const [
                  ...Formats.standardFormats,
                  // formatCustom,
                ],
                hitTestBehavior: HitTestBehavior.opaque,
                onDropOver: (DropOverEvent event){
                  return event.session.allowedOperations.firstOrNull ?? DropOperation.none;
                },
                onPerformDrop: _onPerformDrop,
                onDropLeave: (DropEvent event){},
                child: Stack(
                  children: [
                    // Positioned.fill(child: _content),
                    // Positioned.fill(
                    //   child: IgnorePointer(
                    //     child: AnimatedOpacity(
                    //       opacity: _isDragOver ? 1.0 : 0.0,
                    //       duration: const Duration(milliseconds: 200),
                    //       child: _preview,
                    //     ),
                    //   ),
                    // ),


                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<void> _onPerformDrop(PerformDropEvent event) async {

  }

}

// class Dropregon extends StatefulWidget {
//   const Dropregon({super.key});
//
//   @override
//   State<Dropregon> createState() => _DropregonState();
// }
//
// class _DropregonState extends State<Dropregon> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _pickFileToUpload,
//       behavior: HitTestBehavior.opaque,
//       child: DropRegion(
//         formats: Formats.standardFormats,
//         hitTestBehavior: HitTestBehavior.opaque,
//         onDropOver: _onDropOver,
//         onPerformDrop: (e) async {
//
//
//           await _onPerformDrop(e);
//           setState(() {
//             _isLoading = false;
//             focusNode.unfocus();
//           });
//         },
//         onDropEnter: (_) {
//           focusNode.requestFocus();
//         },
//         onDropLeave: (_) {
//           focusNode.unfocus();
//         },
//         child: Center(
//           child: Container(
//             child: Text(''),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _pickFileToUpload() async {
//     //   focusNode.requestFocus();
//     //   final file = await _pickFile();
//     //   if (file == null) {
//     //     focusNode.unfocus();
//     //     return;
//     //   }
//     //   final data = file.bytes;
//     //   final extensionName = file.name.fileExtensionName;
//     //   if (data == null || extensionName == null) return;
//     //   setState(() {
//     //     _isLoading = true;
//     //   });
//     //   await _upload(
//     //     UploaderData(
//     //       extensionName: extensionName.toLowerCase(),
//     //       data: data,
//     //       md5Value: widget.checkMd5 ? md5.convert(data).toString() : null,
//     //       fileName: file.name,
//     //     ),
//     //   );
//     //   setState(() {
//     //     _isLoading = false;
//     //     focusNode.unfocus();
//     //   });
//     // }
//   }
//   //
//   // DropOperation _onDropOver(DropOverEvent event) {
//   //   if (event.session.allowedOperations.contains(DropOperation.copy)) {
//   //     return DropOperation.copy;
//   //   } else {
//   //     return DropOperation.none;
//   //   }
//   // }
//   //
//   // Future<void> _onPerformDrop(PerformDropEvent event) async {
//   //   final item = event.session.items.first;
//   //   final reader = item.dataReader!;
//   //   final format = reader.getFormats([...widget.formats.keys]).firstOrNull;
//   //   if (format == null || format is! SimpleFileFormat) return;
//   //   final fileName = await reader.getSuggestedName();
//   //   final extensionName = fileName?.fileExtensionName;
//   //   final data = await reader.readFile(format);
//   //   if (data == null || extensionName == null) return;
//   //   await _upload(
//   //     UploaderData(
//   //       extensionName: extensionName.toLowerCase(),
//   //       data: data,
//   //       md5Value: widget.checkMd5 ? md5.convert(data).toString() : null,
//   //       fileName: fileName,
//   //     ),
//   //   );
//   // }
//   //
//   // Future<void> _upload(UploaderData? data) async {
//   //   final l10n = AppGlobals.l10n;
//   //   if (data == null) {
//   //     toast(l10n.damagedFile);
//   //     return;
//   //   }
//   //   if (data.data.lengthInBytes >
//   //       widget.maxFileSizeBytes.toUnit(BytesUnit.B).value.toBigInt().toInt()) {
//   //     toast(l10n.maximumFileSizeIs(widget.maxFileSizeBytes));
//   //     return;
//   //   }
//   //   T? temp;
//   //   try {
//   //     temp = await widget.uploader(data);
//   //   } catch (e) {
//   //     log('$e');
//   //   }
//   //
//   //   if (temp == null) {
//   //     _uploadResult = null;
//   //   } else {
//   //     _uploadResult = UploadResult(temp, data);
//   //   }
//   //
//   //   widget.onChanged?.call(_uploadResult);
//   // }
// }
