package;

import NodeType;

class NodeTypeUtil {
    public static function getTerminalValue<K, V>(node:NodeType<K, V>) : V {
        switch(node) {
            case null:
                return null;
            case Terminal(v):
                return v;
            case Node(_, children) | Root(children):
                for(child in children) {
                    switch(child) {
                        case Terminal(v):
                            return v;
                        default:
                    }
                }
                return null;
        }
    }

    public static function updateTerminalValue<K, V>(node:NodeType<K, V>, value:V) {
        switch(node) {
            case Node(_, children) | Root(children):
                var hasChanged:Bool = false;
                for(i in 0...children.length) {
                    switch(children[i]) {
                        case Terminal(_):
                            children[i] = Terminal(value);
                            hasChanged = true;
                        default:
                    }
                }
                if(!hasChanged) {
                    children.push(Terminal(value));
                }
            default:
        }
    }

    public static function appendChild<K, V>(node:NodeType<K, V>, child:NodeType<K, V>) : Void {
        switch(node) {
            case Node(_, children) | Root(children):
                children.push(child);
            default:
        }
    }
}