Tree Map data structure for Haxe
===
This library provides a class that can be used to store a value with a key of multiple values.

## Usage

You can create the object with an optional matching function. It will be used on the keys.
```haxe
public function new(?m:(v1:K, v2:K) -> Bool)
```

You can check if your keys has already set a value.
```haxe
public function has(keys:Array<K>):Bool
```

You can get the value stored for given keys. If it is not set it will return null.
```haxe
public function get(keys:Array<K>):V
```

You can add a value to the tree with the given keys. You should avoid null because it is currently the value used to show there is no return.
It will throw an exception if the keys are already used.
```haxe
public function add(keys:Array<K>, value:V)
```

The set method will have the same behaviour than add but will not throw an exception if the key are already used: it will overwrite the value.
```haxe
public function add(keys:Array<K>, value:V)
```

The tree can be cleared with this method.
```haxe
public function clear()
```