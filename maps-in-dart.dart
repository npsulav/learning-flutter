// creates a list of [Map<String,double>]
List<Map<String,double>> lists = [];

void main(){
  // create a new map
  Map<String,double> map1 = {"height":12,"width":13};
  
  // accessing the [height] of [map1]
  print(map1["height"]);
  // RESULTS {height:12,width:13}
  
  lists.add(map1);
  Map<String,double> map2 = {"height":32,"width":48};
  lists.add(map2);
  
  // accessing the list
  print(lists);
  // RESULTS [{height:12,width:13},{height:32,width:48}]
  
  // accessing the first member of list
  print(lists[0]);
  // RESULTS {height:12,width:13}
  
  
  // accessing the map
  print(lists[0]["height"]);
  // RESULTS 12
}
