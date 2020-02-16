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

    public static function appendChild<K, V>(node:NodeType<K, V>, child:NodeType<K, V>) : Void {
        switch(node) {
            case Node(_, children) | Root(children):
                children.push(child);
            default:
        }
    }
}