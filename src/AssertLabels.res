@module("assert")
external strictEqual: (~actual: 'a, ~expected: 'a, ~message: string) => unit = "strictEqual"
@module("assert")
external notStrictEqual: (~actual: 'a, ~expected: 'a, ~message: string) => unit = "notStrictEqual"

@module("assert")
external deepStrictEqual: (~actual: 'a, ~expected: 'a, ~message: string) => unit = "deepStrictEqual"
@module("assert")
external notDeepStrictEqual: (~actual: 'a, ~expected: 'a, ~message: string) => unit =
  "notDeepStrictEqual"

@module("assert") external ifError: (~value: 'a) => unit = "ifError"

@module("assert")
external throws: (~block: 'a => 'b, ~error: Js.Exn.t, ~message: string) => unit = "throws"
@module("assert")
external doesNotThrow: (~block: 'a => 'b, ~error: Js.Exn.t, ~message: string) => unit =
  "doesNotThrow"

@module("assert") external ok: (~value: 'a) => unit = "ok"
@module("assert") external fail: (~message: 'a) => unit = "fail"

@deprecated("use strictEqual instead") @module("assert")
external equal: (~actual: 'a, ~expected: 'a, ~message: string) => unit = "equal"

@deprecated("use notStrictEqual instead") @module("assert")
external notEqual: (~actual: 'a, ~expected: 'a, ~message: string) => unit = "notEqual"

@deprecated("use deepStrictEqual instead") @module("assert")
external deepEqual: (~actual: 'a, ~expected: 'a, ~message: string) => unit = "deepEqual"

@deprecated("use notDeepStrictEqual instead") @module("assert")
external notDeepEqual: (~actual: 'a, ~expected: 'a, ~message: string) => unit = "notDeepEqual"

@deprecated("use fail instead") @module("assert")
external fail': (
  ~actual: 'a,
  ~expected: 'a,
  ~message: string,
  ~operator: string=?,
  ~stackStartFn: 'b => 'c=?,
) => unit = "fail"
