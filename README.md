# std/assert

Test assertion utilities for the Doof test runner. Provides a single `Assert` class with static methods that call `assert()` on failure and optionally include a descriptive message.

## Documentation

- [Guide and API reference](docs/API.md) explains failure messages, assertion categories, and the complete `Assert` API.
- Tests can be run with `doof test assert`.

## Usage

```doof
import { Assert } from "std/assert"

export function testAddition(): none {
  Assert.equal(1 + 1, 2)
  Assert.isTrue(3 > 1, "expected 3 to be greater than 1")
  Assert.contains([1, 2, 3], 2)
}
```

Mutable results can be compared directly with readonly expectations without
copying or changing either collection:

```doof
export function testCollectedIds(): none {
  actual: int[] := collectIds()
  expected: readonly int[] := [1, 2, 3]

  Assert.mutableArrayEqual(actual, expected)
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

#### `Assert.equal<T>(actual: T, expected: T, message?: string | none, source?: SourceLocation): none`

Fails if `actual` and `expected` are not equal.

For arrays, maps, and sets this is reference equality. Use the collection
equality methods below when comparing contents.

```doof
Assert.equal(result, 42)
Assert.equal(name, "Alice", "display name")
```

---

#### `Assert.notEqual<T>(actual: T, expected: T, message?: string | none, source?: SourceLocation): none`

Fails if `actual` and `expected` are equal.

```doof
Assert.notEqual(a, b, "values should differ")
```

---

#### `Assert.arrayEqual<T>(actual: readonly T[], expected: readonly T[], message?: string | none, source?: SourceLocation): none`

Fails if the arrays differ in length or at any element.

```doof
Assert.arrayEqual(actualBytes, expectedBytes)
```

#### Mutable-to-readonly collection equality

- `Assert.mutableArrayEqual<T>(actual: T[], expected: readonly T[], message?: string | none, source?: SourceLocation): none`
- `Assert.mutableSetEqual<T>(actual: Set<T>, expected: ReadonlySet<T>, message?: string | none, source?: SourceLocation): none`
- `Assert.mutableMapEqual<K, V>(actual: Map<K, V>, expected: ReadonlyMap<K, V>, message?: string | none, source?: SourceLocation): none`

These compare collection contents and do not mutate either argument. Set and
map equality is independent of insertion order.

Readonly sets and maps have corresponding `setEqual` and `mapEqual` methods.

---

#### `Assert.approxEqual(actual: double, expected: double, tolerance?: double, message?: string | none, source?: SourceLocation): none`

Fails if the values differ by more than `tolerance`, which defaults to
`0.000001`.

```doof
Assert.approxEqual(actual, expected, 0.0001)
```

---

#### `Assert.isTrue(value: bool, message?: string | none, source?: SourceLocation): none`

Fails if `value` is `false`.

```doof
Assert.isTrue(list.length > 0)
```

---

#### `Assert.isFalse(value: bool, message?: string | none, source?: SourceLocation): none`

Fails if `value` is `true`.

```doof
Assert.isFalse(stream.done, "stream should still be open")
```

---

#### `Assert.contains<T>(values: readonly T[], expected: T, message?: string | none, source?: SourceLocation): none`

Fails if `values` does not contain `expected`.

```doof
Assert.contains(ids, "acct-1")
```

Use `mutableArrayContains` for a mutable array.

---

#### `Assert.notContains<T>(values: readonly T[], expected: T, message?: string | none, source?: SourceLocation): none`

Fails if `values` contains `expected`.

```doof
Assert.notContains(ids, "disabled")
```

Use `mutableArrayNotContains` for a mutable array.

---

#### `Assert.stringContains(value: string, expected: string, message?: string | none, source?: SourceLocation): none`

Fails if `value` does not contain `expected`.

```doof
Assert.stringContains(error.message, "timeout")
```

---

#### `Assert.stringNotContains(value: string, expected: string, message?: string | none, source?: SourceLocation): none`

Fails if `value` contains `expected`.

```doof
Assert.stringNotContains(output, "secret")
```

---

#### `Assert.fail(message?: string | none, source?: SourceLocation): none`

Unconditionally fails the test.

```doof
Assert.fail("reached an unreachable branch")
```
