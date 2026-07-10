import { Assert } from "std/assert"

export function testEqualityAndBooleans(): void {
    Assert.equal(1 + 1, 2)
    Assert.notEqual("alpha", "beta")
    Assert.isTrue(3 > 1)
    Assert.isFalse(1 > 3)
}

export function testArrayAndApproximateEquality(): void {
    actual: readonly int[] := [1, 2, 3]
    expected: readonly int[] := [1, 2, 3]
    Assert.arrayEqual(actual, expected)
    Assert.approxEqual(0.1 + 0.2, 0.3)
    Assert.approxEqual(1.0, 1.01, 0.02)
}

export function testArrayContainsChecks(): void {
    readonly values: readonly int[] = [1, 2, 3]

    Assert.contains(values, 2)
    Assert.notContains(values, 4)
}

export function testStringContainsChecks(): void {
    Assert.stringContains("stdlib assertions", "assert")
    Assert.stringNotContains("stdlib assertions", "panic")
}

export function testFailureIncludesCallerSource(): void {
    result := catchPanic(=> Assert.fail("expected failure"))

    case result {
        s: Success -> Assert.fail("expected assertion to fail")
        f: Failure -> Assert.stringContains(f.error, "tests/assert.test:")
    }
}
