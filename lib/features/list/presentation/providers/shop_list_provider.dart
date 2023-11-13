import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/infrastructure/services/storage_service.dart';

part 'shop_list_provider.g.dart';

@Riverpod(keepAlive: true)
class ShopList extends _$ShopList {

  @override
  ShopListState build(ShopListType type) {
    return ShopListState();
  }
  

  ///* Delete
  ///* Add
  ///* Reorder
  ///* Update data
  ///* Toggle display list
   

  Future<void> load() async {

    switch(type){
      case ShopListType.personal:{
        final storage = StorageService();
        final List<String>? data  =  await storage.read(SKey.personalList);

        if(data == null) return;

        state = state.copyWith(items: ShopListState.toShopItem(data));
        break;
      }
      case ShopListType.shared:{
        //TODO: Obtener datos de db
      }
    }

    final storage = StorageService();
    final List<String>? data = await storage.read(SKey.personalList);
    final List<ShopItem> result = [];

    if(data == null) return;
    for(int i=0; i<data.length; i+=2){
      result.add(ShopItem(data: data[i], selected: bool.tryParse(data[i+1]) ?? false));
    }

    state = state.copyWith(items: result);
  }

  void add() => state = state.copyWith(items: [...state.items, ShopItem()]);

  void delete(int index){
    final aux = state.items;
    aux.removeAt(index);
    state = state.copyWith(items: aux);
  }

  void reorder(int oldIndex, int newIndex){
    final aux = state.items;
    final element = aux[oldIndex];
    aux.removeAt(oldIndex);
    aux.insert(newIndex, element);

    state = state.copyWith(items: aux);
  }

  //Actualizar datos cuando se cambiel el foco o onEditingComplete
  void update(int index,
  {
    String? data,
    bool? selected
  }){
    final items = state.items;
    final newData = ShopItem(data: data ?? items[index].data, selected: selected ?? items[index].selected);
    state = state.copyWith(
      items: items.map((e) => items.indexOf(e) == index ? newData : e ).toList()
    );

  }

  void updateCurrentField(String value) => state = state.copyWith(currentField: value);

  void toggleDisplayList() => state = state.copyWith(displayList: !state.displayList);

  @override
  String toString(){
    String result = '';
    for (ShopItem element in state.items) {
      result += '[${element.data} - ${element.selected}], ';
    }
    return result;
  }
  
}


class ShopListState{
  bool displayList;
  List<ShopItem> items;
  String currentField;

  ShopListState({
    this.displayList = true,
    this.items = const[],
    this.currentField = ''
  });

  ShopListState copyWith({
    bool? displayList,
    List<ShopItem>? items,
    String? currentField
  }) => ShopListState(
    displayList: displayList ?? this.displayList,
    items: items ?? this.items,
    currentField: currentField ?? this.currentField
  );


  static List<String> toStringLIst(List<ShopItem> items){
    if(items.isEmpty) return [];
    final List<String> result = [];
    for(ShopItem item in items){
      result.add(item.data);
      result.add(item.selected.toString());
    }
    return result;
  }


  static List<ShopItem> toShopItem(List<String> list){
    if(list.isEmpty) return [];
    List<ShopItem> result = [];
    for(int i=0; i<list.length; i+=2){
      result.add(ShopItem(data: list[i], selected: bool.tryParse(list[i+1]) ?? false));
    }
    return result;
  }

}

class ShopItem{
  bool selected;
  String data;

  ShopItem({
    this.selected = false,
    this.data = ''
  });
}


enum ShopListType{
  personal,
  shared
}