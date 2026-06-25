# std/assert Guide

`std/assert` provides readable assertion helpers for Doof tests. Each helper
wraps the built-in `assert()` with a standard failure message and an optional
caller-supplied prefix.

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

All assertion methods accept `message: string | null = null`. When present, the
message is prepended to the standard failure text:

```doof
Assert.equal(actual, expected, "decoded length")
```

This keeps individual test failures searchable while preserving consistent
assertion wording.

## API

All declarations are static methods on `Assert`, defined in [index.do](../index.do).

```doof
export class Assert
```

Equality:

- `equal<T>(actual: T, expected: T, message: string | null = null): void`
- `notEqual<T>(actual: T, expected: T, message: string | null = null): void`

Booleans:

- `isTrue(value: bool, message: string | null = null): void`
- `isFalse(value: bool, message: string | null = null): void`

Arrays:

- `contains<T>(values: readonly T[], expected: T, message: string | null = null): void`
- `notContains<T>(values: readonly T[], expected: T, message: string | null = null): void`

Strings:

- `stringContains(value: string, expected: string, message: string | null = null): void`
- `stringNotContains(value: string, expected: string, message: string | null = null): void`

Unconditional failure:

- `fail(message: string | null = null): void`
