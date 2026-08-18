import { Assert } from "std/assert"

export function testEqualityAndBooleans() {
    Assert.equal(1 + 1, 2)
    Assert.notEqual("alpha", "beta")
    Assert.isTrue(3 > 1)
    Assert.isFalse(1 > 3)
}

export function testArrayAndApproximateEquality() {
    actual: readonly int[] := [1, 2, 3]
    expected: readonly int[] := [1, 2, 3]
    Assert.arrayEqual(actual, expected)
    Assert.approxEqual(0.1 + 0.2, 0.3)
    Assert.approxEqual(1.0, 1.01, 0.02)
}

export function testMutableCollectionEqualityAgainstReadonlyExpectations() {
    actualArray: int[] := [1, 2, 3]
    expectedArray: readonly int[] := [1, 2, 3]
    Assert.mutableArrayEqual(actualArray, expectedArray)
    Assert.equal(actualArray.length, 3)

    actualSet: Set<int> := [3, 1, 2]
    expectedSet: ReadonlySet<int> := [1, 2, 3]
    Assert.mutableSetEqual(actualSet, expectedSet)
    Assert.equal(actualSet.size, 3)

    actualMap: Map<string, int> := { "two": 2, "one": 1 }
    expectedMap: ReadonlyMap<string, int> := { "one": 1, "two": 2 }
    Assert.mutableMapEqual(actualMap, expectedMap)
    Assert.equal(actualMap.size, 2)
}

export function testReadonlySetAndMapEquality() {
    actualSet: ReadonlySet<int> := [3, 1, 2]
    expectedSet: ReadonlySet<int> := [1, 2, 3]
    Assert.setEqual(actualSet, expectedSet)

    actualMap: ReadonlyMap<string, int> := { "two": 2, "one": 1 }
    expectedMap: ReadonlyMap<string, int> := { "one": 1, "two": 2 }
    Assert.mapEqual(actualMap, expectedMap)
}

export function testMutableArrayContainsChecks() {
    values: int[] := [1, 2, 3]

    Assert.mutableArrayContains(values, 2)
    Assert.mutableArrayNotContains(values, 4)
}

export function testMutableCollectionFailureMessages() {
    actualArray: int[] := [1, 9, 3]
    expectedArray: readonly int[] := [1, 2, 3]
    arrayResult := catchPanic(=> Assert.mutableArrayEqual(actualArray, expectedArray, "array result"))
    case arrayResult {
        _: Success -> Assert.fail("expected mutable array assertion to fail")
        failure: Failure -> Assert.stringContains(failure.error, "array result: expected arrays to be equal at index 1")
    }

    actualSet: Set<int> := [1, 4]
    expectedSet: ReadonlySet<int> := [1, 2]
    setResult := catchPanic(=> Assert.mutableSetEqual(actualSet, expectedSet))
    case setResult {
        _: Success -> Assert.fail("expected mutable set assertion to fail")
        failure: Failure -> Assert.stringContains(failure.error, "expected sets to contain equal values")
    }

    actualMap: Map<string, int> := { "one": 1, "two": 9 }
    expectedMap: ReadonlyMap<string, int> := { "one": 1, "two": 2 }
    mapResult := catchPanic(=> Assert.mutableMapEqual(actualMap, expectedMap))
    case mapResult {
        _: Success -> Assert.fail("expected mutable map assertion to fail")
        failure: Failure -> Assert.stringContains(failure.error, "expected maps to contain equal entries")
    }
}

export function testArrayContainsChecks() {
    readonly values: readonly int[] = [1, 2, 3]

    Assert.contains(values, 2)
    Assert.notContains(values, 4)
}

export function testStringContainsChecks() {
    Assert.stringContains("stdlib assertions", "assert")
    Assert.stringNotContains("stdlib assertions", "panic")
}

export function testFailureIncludesCallerSource() {
    result := catchPanic(=> Assert.fail("expected failure"))

    case result {
        s: Success -> Assert.fail("expected assertion to fail")
        f: Failure -> Assert.stringContains(f.error, "tests/assert.test:")
    }
}
