# std/assert Guide

`std/assert` provides readable assertion helpers for Doof tests. Each helper
wraps the built-in `assert()` with a standard failure message and an optional
caller-supplied prefix. Helpers also capture the caller's `SourceLocation`
automatically, so failures identify the module and line where the helper was
used.

## Quick Start

```doof
import { Assert } from "std/assert"

export function testAddition(): none {
  Assert.equal(1 + 1, 2)
  Assert.isTrue(3 > 1, "expected ordering")
  Assert.contains([1, 2, 3], 2)
}
```

## Failure Messages

All assertion methods accept `message: string | none = none` and
`source: SourceLocation = @caller`. When present, the message is prepended to
the standard failure text. The source parameter is normally omitted; pass it
explicitly when forwarding or overriding a location:

```doof
Assert.equal(actual, expected, "decoded length")
```

Failures include the captured source location, for example:
`expected values to be equal at tests/example.test:12`.

This keeps individual test failures searchable while preserving consistent
assertion wording.

## API

All declarations are static methods on `Assert`, defined in [index.do](../index.do).

```doof
export class Assert
```

Equality:

- `equal<T>(actual: T, expected: T, message: string | none = none, source: SourceLocation = @caller): none`
- `notEqual<T>(actual: T, expected: T, message: string | none = none, source: SourceLocation = @caller): none`
- `arrayEqual<T>(actual: readonly T[], expected: readonly T[], message: string | none = none, source: SourceLocation = @caller): none`
- `mutableArrayEqual<T>(actual: T[], expected: readonly T[], message: string | none = none, source: SourceLocation = @caller): none`
- `setEqual<T>(actual: ReadonlySet<T>, expected: ReadonlySet<T>, message: string | none = none, source: SourceLocation = @caller): none`
- `mutableSetEqual<T>(actual: Set<T>, expected: ReadonlySet<T>, message: string | none = none, source: SourceLocation = @caller): none`
- `mapEqual<K, V>(actual: ReadonlyMap<K, V>, expected: ReadonlyMap<K, V>, message: string | none = none, source: SourceLocation = @caller): none`
- `mutableMapEqual<K, V>(actual: Map<K, V>, expected: ReadonlyMap<K, V>, message: string | none = none, source: SourceLocation = @caller): none`

`equal` and `notEqual` use the language's `==` operator. For arrays, maps, and
sets this is reference equality; use the collection-specific methods for
content comparisons.

Collection equality is structural and shallow. Set and map comparisons ignore
insertion order. The `mutable*Equal` forms are directional: a mutable actual
result is compared with a readonly expected fixture, and neither is mutated.

Approximate numeric equality:

- `approxEqual(actual: double, expected: double, tolerance: double = 0.000001, message: string | none = none, source: SourceLocation = @caller): none`

Booleans:

- `isTrue(value: bool, message: string | none = none, source: SourceLocation = @caller): none`
- `isFalse(value: bool, message: string | none = none, source: SourceLocation = @caller): none`

Arrays:

- `contains<T>(values: readonly T[], expected: T, message: string | none = none, source: SourceLocation = @caller): none`
- `notContains<T>(values: readonly T[], expected: T, message: string | none = none, source: SourceLocation = @caller): none`
- `mutableArrayContains<T>(values: T[], expected: T, message: string | none = none, source: SourceLocation = @caller): none`
- `mutableArrayNotContains<T>(values: T[], expected: T, message: string | none = none, source: SourceLocation = @caller): none`

Strings:

- `stringContains(value: string, expected: string, message: string | none = none, source: SourceLocation = @caller): none`
- `stringNotContains(value: string, expected: string, message: string | none = none, source: SourceLocation = @caller): none`

Unconditional failure:

- `fail(message: string | none = none, source: SourceLocation = @caller): none`
