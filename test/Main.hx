package ;

import tink.unit.*;
import tink.testrunner.*;

class Main {
    public static function main():Void {
        Runner.run(TestBatch.make([
            new TreeMapTest(),
        ]));
    }
}