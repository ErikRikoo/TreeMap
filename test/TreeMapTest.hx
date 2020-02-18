package ;

import tink.unit.AssertionBuffer;
import TreeMap;

import tink.testrunner.Assertion;
import tink.unit.Assert.*;

@:access(TreeMap.root)
@:access(TreeMap.NodeType)
@:access(TreeMap.Pair)
class TreeMapTest {
    var tree:TreeMap<String, Int>;

    public function new() {
        tree = new TreeMap();
    }

    @:describe("Should create a one branch tree for the first insert")
    public function insertOne() {
        tree.add(["a", "b"], 5);

        switch(tree.root) {
            case Root([
                Node(
                    "a", [
                        Node("b", [
                            Terminal(5)
                        ])
                    ])
                ]):
                return new Assertion(true, "Passing");
            default:
                return new Assertion(false, "Not Passing");
        }
    }

    @:describe("Should create new nodes on the same branchs if the keys are the same")
    public function insertOnSameBranch() {
        tree.add(["a", "b", "c"], 6);

        switch(tree.root) {
            case Root([
                Node(
                    "a", [
                        Node("b", [
                            Terminal(5), Node("c", [Terminal(6)])
                        ])
                    ])
                ]):
                return new Assertion(true, "Passing");
            default:
                return new Assertion(false, "Not Passing");
        }
    }

    @:describe("Should create a new branch if keys are different at some point")
    public function insertOnAnotherBranch() {
        tree.add(["a", "c", "c"], 7);

        switch(tree.root) {
            case Root([
                Node(
                    "a", [
                        _, Node("c", [
                            Node("c", [Terminal(7)])
                        ])
                    ])
                ]):
                return new Assertion(true, "Passing");
            default:
                return new Assertion(false, "Not Passing");
        }
    }

    @describe("Should throw an exception if the pair (kays, value) is already added")
    public function insertErrorTesting() {
        try{
            tree.add(["a", "c", "c"], 7);
            return new Assertion(false, "The methods has not returned an exception");
        } catch(e:Any) {
            return new Assertion(true, "The methods has returned an exception");
        }
    }

    @:describe("Should be able to access a value added to the tree")
    public function getValues() {
        tree.clear();
        tree.add(["a", "b"], 5);
        tree.add(["a", "b", "c"], 6);
        tree.add(["a", "c", "c"], 7);

        var asserts = new AssertionBuffer();
        asserts.assert(tree.get(["a", "b"]) == 5, "Returns: " + 5);
        asserts.assert(tree.get(["a", "b", "c"]) == 6, "Returns: " + 6);
        asserts.assert(tree.get(["a", "c", "c"]) == 7, "Returns: " + 7);
        return asserts.done();
    }

    @:describe("Should return null if the keys are not in the tree")
    public function gettingNullOnInvalidKeys() {
        tree.clear();

        return new Assertion(tree.get(["a"]) == null, "Returns null");
    }

    @:describe("Should return right boolean if or not in the tree")
    public function testHas() {
        tree.clear();
        tree.add(["a", "b"], 5);

        var asserts = new AssertionBuffer();
        asserts.assert(tree.has(["a", "b"]), "Returns the true");
        asserts.assert(!tree.has(["a", "b", "c"]), "Returns false");
        return asserts.done();
    }

    @:describe("Should be able to use the given matcher")
    public function testMatcher() {
        var caseInsensitiveTree = new TreeMap<String, Int>((s1:String, s2:String) -> s1.toLowerCase() == s2.toLowerCase());
        caseInsensitiveTree.add(["a", "b"], 5);
        return new Assertion(caseInsensitiveTree.has(["A", "B"]), "Returns true");
    }

    
    @:describe("Set should update a value already created if it is the same keys")
    public function testSetUpdatingValue() {
        tree.clear();
        tree.add(["a", "b"], 5);
        tree.set(["a", "b"], 6);

        switch(tree.root) {
            case Root([
                Node(
                    "a", [
                        Node("b", [
                            Terminal(6)
                        ])
                    ])
                ]):
                return new Assertion(true, "Passing");
            default:
                return new Assertion(false, "Not Passing");
        }
    }

    @:describe("Set should create a one branch tree for the first insert")
    public function setTestInsertOne() {
        tree.clear();
        tree.set(["a", "b"], 5);

        switch(tree.root) {
            case Root([
                Node(
                    "a", [
                        Node("b", [
                            Terminal(5)
                        ])
                    ])
                ]):
                return new Assertion(true, "Passing");
            default:
                return new Assertion(false, "Not Passing");
        }
    }

    @:describe("Should create new nodes on the same branchs if the keys are the same")
    public function setInsertOnSameBranch() {
        tree.set(["a", "b", "c"], 6);

        switch(tree.root) {
            case Root([
                Node(
                    "a", [
                        Node("b", [
                            Terminal(5), Node("c", [Terminal(6)])
                        ])
                    ])
                ]):
                return new Assertion(true, "Passing");
            default:
                return new Assertion(false, "Not Passing");
        }
    }

    @:describe("Should create a new branch if keys are different at some point")
    public function setInsertOnAnotherBranch() {
        tree.set(["a", "c", "c"], 7);

        switch(tree.root) {
            case Root([
                Node(
                    "a", [
                        _, Node("c", [
                            Node("c", [Terminal(7)])
                        ])
                    ])
                ]):
                return new Assertion(true, "Passing");
            default:
                return new Assertion(false, "Not Passing");
        }
    }
}