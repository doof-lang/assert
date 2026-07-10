import { approxEqual as mathApproxEqual } from "std/math"

export class Assert {
    private static check(
        condition: bool,
        expectation: string,
        message: string | null,
        source: SourceLocation,
    ): void {
        if condition {
            return
        }

        failure := if message == null then expectation else
            (message ?? "") + ": " + expectation
        assert(false, failure + " at " + source.fileName + ":" + string(source.line))
    }

    static equal<T>(
        actual: T,
        expected: T,
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        Assert.check(actual == expected, "expected values to be equal", message, source)
    }

    static arrayEqual<T>(
        actual: readonly T[],
        expected: readonly T[],
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        Assert.check(actual.length == expected.length, "expected arrays to have equal length", message, source)

        for index of 0..<actual.length {
            if actual[index] == expected[index] {
                continue
            }
            Assert.check(
                false,
                "expected arrays to be equal at index " + string(index),
                message,
                source,
            )
        }
    }

    static approxEqual(
        actual: double,
        expected: double,
        tolerance: double = 0.000001,
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        Assert.check(
            mathApproxEqual(actual, expected, tolerance),
            "expected values to be approximately equal",
            message,
            source,
        )
    }

    static notEqual<T>(
        actual: T,
        expected: T,
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        Assert.check(!(actual == expected), "expected values to differ", message, source)
    }

    static isTrue(
        value: bool,
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        Assert.check(value, "expected value to be true", message, source)
    }

    static isFalse(
        value: bool,
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        Assert.check(!value, "expected value to be false", message, source)
    }

    static contains<T>(
        values: readonly T[],
        expected: T,
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        Assert.check(values.contains(expected), "expected array to contain value", message, source)
    }

    static notContains<T>(
        values: readonly T[],
        expected: T,
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        Assert.check(!values.contains(expected), "expected array not to contain value", message, source)
    }

    static stringContains(
        value: string,
        expected: string,
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        expectation := "expected string to contain \"" + expected + "\""
        Assert.check(value.contains(expected), expectation, message, source)
    }

    static stringNotContains(
        value: string,
        expected: string,
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        expectation := "expected string not to contain \"" + expected + "\""
        Assert.check(!value.contains(expected), expectation, message, source)
    }

    static fail(
        message: string | null = null,
        source: SourceLocation = @caller,
    ): void {
        if message == null {
            Assert.check(false, "test failed", null, source)
        } else {
            Assert.check(false, message ?? "test failed", null, source)
        }
    }
}
