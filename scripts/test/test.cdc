pub fun main(): Int {
  let dict: {Int: Int} = {};

  var i: Int = 0;
  while i < 10 {
      dict[i] = i;
      i = i + 1;
  }

  for ele in dict.keys {
    dict.remove(key: ele);
  }

  log(dict);

  return 1
}
