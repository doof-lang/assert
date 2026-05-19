export class Assert {
    static equal<T>(actual: T, expected: T, message: string | null = null): void {
        if actual == expected {
            return
        }
        if message == null {
            assert(false, "expected values to be equal")
        } else {
            assert(false, (message ?? "") + ": expected values to be equal")
        }
    }

    static notEqual<T>(actual: T, expected: T, message: string | null = null): void {
        if !(actual == expected) {
            return
        }
        if message == null {
            assert(false, "expected values to differ")
        } else {
            assert(false, (message ?? "") + ": expected values to differ")
        }
    }

    static isTrue(value: bool, message: string | null = null): void {
        if value {
            return
        }
        if message == null {
            assert(false, "expected value to be true")
        } else {
            assert(false, (message ?? "") + ": expected value to be true")
        }
    }

    static isFalse(value: bool, message: string | null = null): void {
        if !value {
            return
        }
        if message == null {
            assert(false, "expected value to be false")
        } else {
            assert(false, (message ?? "") + ": expected value to be false")
        }
    }

    static contains<T>(values: readonly T[], expected: T, message: string | null = null): void {
        if values.contains(expected) {
            return
        }
        if message == null {
            assert(false, "expected array to contain value")
        } else {
            assert(false, (message ?? "") + ": expected array to contain value")
        }
    }

    static notContains<T>(values: readonly T[], expected: T, message: string | null = null): void {
        if !values.contains(expected) {
            return
        }
        if message == null {
            assert(false, "expected array not to contain value")
        } else {
            assert(false, (message ?? "") + ": expected array not to contain value")
        }
    }

    static stringContains(value: string, expected: string, message: string | null = null): void {
        if value.contains(expected) {
            return
        }
        expectation := "expected string to contain \"" + expected + "\""
        if message == null {
            assert(false, expectation)
        } else {
            assert(false, (message ?? "") + ": " + expectation)
        }
    }

    static stringNotContains(value: string, expected: string, message: string | null = null): void {
        if !value.contains(expected) {
            return
        }
        expectation := "expected string not to contain \"" + expected + "\""
        if message == null {
            assert(false, expectation)
        } else {
            assert(false, (message ?? "") + ": " + expectation)
        }
    }

    static fail(message: string | null = null): void {
        if message == null {
            assert(false, "test failed")
        } else {
            assert(false, message ?? "test failed")
        }
    }
}
