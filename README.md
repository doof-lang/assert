# std/assert

Test assertion utilities for the Doof test runner. Provides a single `Assert` class with static methods that call `assert()` on failure and optionally include a descriptive message.

## Documentation

- [Guide and API reference](docs/API.md) explains failure messages, assertion categories, and the complete `Assert` API.
- Tests can be run with `doof test assert`.

## Usage

```doof
import { Assert } from "std/assert"

export function testAddition(): void {
  Assert.equal(1 + 1, 2)
  Assert.isTrue(3 > 1, "expected 3 to be greater than 1")
  Assert.contains([1, 2, 3], 2)
}
```

## Exports

### `Assert`

A class with static assertion methods. All methods accept an optional trailing
`message` parameter that is prepended to the failure message and a
`source: SourceLocation = @caller` parameter. The source is captured
automatically, so failures identify the module and line where the assertion was
called.

---

#### `Assert.equal<T>(actual: T, expected: T, message?: string | null, source?: SourceLocation): void`

Fails if `actual` and `expected` are not equal.

```doof
Assert.equal(result, 42)
Assert.equal(name, "Alice", "display name")
```

---

#### `Assert.notEqual<T>(actual: T, expected: T, message?: string | null, source?: SourceLocation): void`

Fails if `actual` and `expected` are equal.

```doof
Assert.notEqual(a, b, "values should differ")
```

---

#### `Assert.arrayEqual<T>(actual: readonly T[], expected: readonly T[], message?: string | null, source?: SourceLocation): void`

Fails if the arrays differ in length or at any element.

```doof
Assert.arrayEqual(actualBytes, expectedBytes)
```

---

#### `Assert.approxEqual(actual: double, expected: double, tolerance?: double, message?: string | null, source?: SourceLocation): void`

Fails if the values differ by more than `tolerance`, which defaults to
`0.000001`.

```doof
Assert.approxEqual(actual, expected, 0.0001)
```

---

#### `Assert.isTrue(value: bool, message?: string | null, source?: SourceLocation): void`

Fails if `value` is `false`.

```doof
Assert.isTrue(list.length > 0)
```

---

#### `Assert.isFalse(value: bool, message?: string | null, source?: SourceLocation): void`

Fails if `value` is `true`.

```doof
Assert.isFalse(stream.done, "stream should still be open")
```

---

#### `Assert.contains<T>(values: readonly T[], expected: T, message?: string | null, source?: SourceLocation): void`

Fails if `values` does not contain `expected`.

```doof
Assert.contains(ids, "acct-1")
```

---

#### `Assert.notContains<T>(values: readonly T[], expected: T, message?: string | null, source?: SourceLocation): void`

Fails if `values` contains `expected`.

```doof
Assert.notContains(ids, "disabled")
```

---

#### `Assert.stringContains(value: string, expected: string, message?: string | null, source?: SourceLocation): void`

Fails if `value` does not contain `expected`.

```doof
Assert.stringContains(error.message, "timeout")
```

---

#### `Assert.stringNotContains(value: string, expected: string, message?: string | null, source?: SourceLocation): void`

Fails if `value` contains `expected`.

```doof
Assert.stringNotContains(output, "secret")
```

---

#### `Assert.fail(message?: string | null, source?: SourceLocation): void`

Unconditionally fails the test.

```doof
Assert.fail("reached an unreachable branch")
```
