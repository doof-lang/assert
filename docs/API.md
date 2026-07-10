# std/assert Guide

`std/assert` provides readable assertion helpers for Doof tests. Each helper
wraps the built-in `assert()` with a standard failure message and an optional
caller-supplied prefix. Helpers also capture the caller's `SourceLocation`
automatically, so failures identify the module and line where the helper was
used.

## Quick Start

```doof
import { Assert } from "std/assert"

export function testAddition(): void {
  Assert.equal(1 + 1, 2)
  Assert.isTrue(3 > 1, "expected ordering")
  Assert.contains([1, 2, 3], 2)
}
```

## Failure Messages

All assertion methods accept `message: string | null = null` and
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

- `equal<T>(actual: T, expected: T, message: string | null = null, source: SourceLocation = @caller): void`
- `notEqual<T>(actual: T, expected: T, message: string | null = null, source: SourceLocation = @caller): void`
- `arrayEqual<T>(actual: readonly T[], expected: readonly T[], message: string | null = null, source: SourceLocation = @caller): void`

Approximate numeric equality:

- `approxEqual(actual: double, expected: double, tolerance: double = 0.000001, message: string | null = null, source: SourceLocation = @caller): void`

Booleans:

- `isTrue(value: bool, message: string | null = null, source: SourceLocation = @caller): void`
- `isFalse(value: bool, message: string | null = null, source: SourceLocation = @caller): void`

Arrays:

- `contains<T>(values: readonly T[], expected: T, message: string | null = null, source: SourceLocation = @caller): void`
- `notContains<T>(values: readonly T[], expected: T, message: string | null = null, source: SourceLocation = @caller): void`

Strings:

- `stringContains(value: string, expected: string, message: string | null = null, source: SourceLocation = @caller): void`
- `stringNotContains(value: string, expected: string, message: string | null = null, source: SourceLocation = @caller): void`

Unconditional failure:

- `fail(message: string | null = null, source: SourceLocation = @caller): void`
