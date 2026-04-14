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

    static fail(message: string | null = null): void {
        if message == null {
            assert(false, "test failed")
        } else {
            assert(false, message ?? "test failed")
        }
    }
}
