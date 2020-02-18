Tree Map data structure for Haxe
===
This library provides a trie data structure. It allows to store a value with a list of keys.
You can check https://en.wikipedia.org/wiki/Trie for more information.

## Features

You can create the object with an optional matching function. It will be used on the key.
```haxe
public function new(?m:(v1:K, v2:K) -> Bool)
```

You can check if the key has already set a value.
```haxe
public function has(keys:Array<K>):Bool
```

You can get the value stored for the given key. If it is not set it will return null.
```haxe
public function get(keys:Array<K>):V
```

You can add a value to the tree with the given key. You should avoid null because it is currently the value used to show there is no return.
It will throw an exception if the key is already used.
```haxe
public function add(keys:Array<K>, value:V)
```

The set method will have the same behaviour than add but will not throw an exception if the key is already used: it will overwrite the value.
```haxe
public function set(keys:Array<K>, value:V)
```

The tree can be cleared with this method.
```haxe
public function clear()
```

## Usage

Usage for a trie with the default matching function i.e. applying == operator
```haxe
// Creating a trie with the default equality function (==)
var trie = new Trie<String, Int>()

// Adding some values
trie.add(["a", "b"], 5);
trie.add(["a", "b", "c"], 6);
trie.add(["a", "c", "c"], 7);

// Now the trie looks like:
// --a--b--+--5
//   +     +--c--6
//   +--c--c--7

// trie.add(["a", "b"], 7)
// will throw an exception because the key is already used

// Updating one of the value
trie.set(["a", "b"], 10);

// Now the trie looks like:
// --a--b--+--10
//   +     +--c--6
//   +--c--c--7

// Testing if a key is set
if(trie.has(["a", "b"])) {
    trace("The key (a, b) is used");
}

// Getting the value, it will return null if not set
trace(trie.get(["a", "b"])) // traces 10
trace(trie.get(["b", "b"])) // traces null

// Clearing all the data from the trie
trie.clear();
```

Usage for a trie with a different matching function, string will be case insensitive
```haxe
// Creating a trie with the default equality function (==)
var trie = new Trie<String, Int>((s1:String, s2:String) -> s1.toLowerCase() == s2.toLowerCase())

// Adding some values
trie.add(["a", "b"], 5);
trie.add(["a", "b", "c"], 6);
trie.add(["a", "c", "c"], 7);

// Now the trie looks like:
// --a--b--+--5
//   +     +--c--6
//   +--c--c--7

// Updating one of the value
trie.set(["A", "b"], 10);

// Now the trie looks like:
// --a--b--+--10
//   +     +--c--6
//   +--c--c--7

// Testing if a key is set
if(trie.has(["A", "B"])) {
    trace("The key (A, B) is used bacause (a, b) is");
}

// Getting the value, it will return null if not set
trace(trie.get(["A", "b"])) // traces 10
trace(trie.get(["b", "b"])) // traces null
```