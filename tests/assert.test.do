import { Assert } from "std/assert"

export function testEqualityAndBooleans(): void {
    Assert.equal(1 + 1, 2)
    Assert.notEqual("alpha", "beta")
    Assert.isTrue(3 > 1)
    Assert.isFalse(1 > 3)
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
