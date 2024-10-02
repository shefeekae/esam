import 'dart:collection';

LinkedHashMap<String, dynamic> reorderMap({
  required List<String> keyOrder,
  required Map<String, dynamic> myMap,
}) {


  // Create a LinkedHashMap with the desired order
  LinkedHashMap<String, dynamic> orderedMap = LinkedHashMap.fromIterable(
    keyOrder,
    key: (key) => key,
    value: (key) => myMap[key],
  );

//   print('Original Map: $myMap');
  return orderedMap;
}
