import NodeType;

using Util;

private typedef Matcher<T> = (v1:T, v2:T) -> Bool;

class TreeMap<K, V> {
    private var root:NodeType<K, V> = Root([]);
    private var current:NodeType<K, V> = null;
    private var matcher:Matcher<K>;

    public function new(?m:Matcher<K>) {
        matcher = if(m != null) m else (v1:K, v2:K) -> v1 == v2;
    }

    public function has(keys:Array<K>):Bool {
        return get(keys) != null;
    }

    public function get(keys:Array<K>):V {
        var index:Int = followPath(keys);

        if(index != keys.length) {
            current = null;
            return null;
        } else {
            var  v:V = current.getTerminalValue();
            current = null;
            return v;
        }
    }

    public function add(keys:Array<K>, value:V) {
        var begin:Int = followPath(keys);

        for(i in begin...keys.length) {
            var newNode:NodeType<K, V> = Node(keys[i], []);
            current.appendChild(newNode);
            current = newNode;
        }

        if(current.getTerminalValue() == null) {
            current.appendChild(Terminal(value));
        } else {
            throw "Value is already set";
        }

        current = null;
    }

    public function set(keys:Array<K>, value:V) {
        var begin:Int = followPath(keys);

        for(i in begin...keys.length) {
            var newNode:NodeType<K, V> = Node(keys[i], []);
            current.appendChild(newNode);
            current = newNode;
        }

        current.updateTerminalValue(value);

        current = null;
    }

    public function clear() {
        root = Root([]);
    }

    private function followPath(keys:Array<K>):Int {
        current = root;
        var index:Int = 0;
        for(key in keys) {
            var node = getChildren(key, current);
            switch(node) {
                case null | Terminal(_) | Root(_):
                    return index;
                case Node(_, _):
                    ++index;
                    current = node;
            }
        }

        return index;
    }

    private function getChildren(key:K, node:NodeType<K, V>):NodeType<K, V> {
        switch(node) {
            case Root(children) | Node(_, children):
                for(child in children) {
                    switch(child) {
                        case Node(k, _) if (matcher(k, key)):
                            return child;
                        default:
                    }
                }
            default:
        }

        return null;
    }
}