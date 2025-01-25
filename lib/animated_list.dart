import 'package:flutter/material.dart';

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});

  @override
  State<AnimatedListScreen> createState() => _AnimatedListState();
}

class _AnimatedListState extends State<AnimatedListScreen> {
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  List<String> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Animated List',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
      ),
      body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: AnimatedList(
                key: listKey,
                initialItemCount: items.length,
                itemBuilder: (context, index, animation) {
                  return _buildItem(items[index], animation, index);
                }),
          ),
          _buildInputBar()
        ],
      ),
    ));
  }

  // ---------------------input bar-------------------
  Widget _buildInputBar() {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Enter the item',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            ),

          )),
          IconButton(
              onPressed: () {
                final newItem = controller.text;
                if (newItem.isNotEmpty) {
                  _addItem(newItem);
                  controller.clear();
                }
              },
              icon: Icon(Icons.add))
        ],
      ),
    );
  }

// ---------------------remove item from the list---------------
  void _addItem(String newItem) {
    items.insert(0, newItem);
    listKey.currentState?.insertItem(0);
  }

// ---------------------remove item from the list---------------
  void _removeItem(int index) {
    final removedItem = items.removeAt(index);
    listKey.currentState?.removeItem(index, (context, animation) {
      return _buildItem(removedItem, animation, index);
    }, duration: const Duration(milliseconds: 300));
  }
// ---------------------size transition animation-------------------

  // Widget _buildItem(String item, Animation<double> animation, int index){
  //   return SizeTransition(
  //     sizeFactor: animation,
  //     child: Card(
  //       child: ListTile(
  //         title: Text(item),
  //         trailing: IconButton(
  //           onPressed: (){
  //             _removeItem(index);
  //           },
  //           icon: Icon(Icons.delete),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // -----------------fade animation-------------------

  // Widget _buildItem(String item, Animation<double> animation, int index) {
  //   return FadeTransition(
  //     opacity: animation,
  //     child: SizeTransition(
  //       sizeFactor: animation,
  //       child: Card(
  //         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //         child: ListTile(
  //           title: Text(item),
  //           trailing: IconButton(
  //               onPressed: () {
  //                 _removeItem(index);
  //               },
  //               icon: Icon(Icons.delete,color: Colors.red,)),
  //         ),
  //       ),
  //     ),
  //   );
  // }

// -------------------sliding animation-------------------

 Widget _buildItem(String item, Animation<double> animation, int index){
   return SlideTransition(position: Tween<Offset>(
     begin: const Offset(1,0),
     end: Offset.zero,
   ).animate(animation),
   child: Card(
    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    child: ListTile(
      title: Text(item),
      trailing: IconButton(onPressed: (){
        _removeItem(index);
      }, icon: Icon(Icons.delete)),
    ),
   ),);

 }
}
