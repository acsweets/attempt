import 'menu_node.dart';

class MenuState {
  MenuNode? _selectedNode;

  // 设置选中节点
  void selectNode(MenuNode newSelectedNode) {
    // 如果有之前的选中节点，取消选中
    if (_selectedNode != newSelectedNode) {
      // 只在节点不同的时候更新状态
      if (_selectedNode != null) {
        _selectedNode!.select = false;
      }
      _selectedNode = newSelectedNode;
      _selectedNode!.select = true;
    }
  }

  String setRoute(MenuNode selectedNode){
    if(selectedNode.isLeaf){
      return selectedNode.path;
    }else{
      return setRoute(selectedNode);
    }
  }
}
