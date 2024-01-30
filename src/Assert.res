@deprecated("use strictEqual instead") @module("assert")
external equal: ('a, 'a, ~message: string=?) => unit = "equal"

@deprecated("use notStrictEqual instead") @module("assert")
external notEqual: ('a, 'a, ~message: string=?) => unit = "notEqual"

@deprecated("use deepStrictEqual instead") @module("assert")
external deepEqual: ('a, 'a, ~message: string=?) => unit = "deepEqual"

@deprecated("use notDeepStrictEqual instead") @module("assert")
external notDeepEqual: ('a, 'a, ~message: string=?) => unit = "notDeepEqual"

@module("assert")
external strictEqual: ('a, 'a, ~message: string=?) => unit = "strictEqual"

@module("assert")
external notStrictEqual: ('a, 'a, ~message: string=?) => unit = "notStrictEqual"

@module("assert")
external deepStrictEqual: ('a, 'a, ~message: string=?) => unit = "deepStrictEqual"

@module("assert")
external notDeepStrictEqual: ('a, 'a, ~message: string=?) => unit = "notDeepStrictEqual"

@module("assert") external ifError: (~value: 'a) => unit = "ifError"

@module("assert")
external throws: ('a => 'b, Js.Exn.t, ~message: string=?) => unit = "throws"
@module("assert")
external doesNotThrow: ('a => 'b, Js.Exn.t, ~message: string=?) => unit = "doesNotThrow"

@module("assert") external ok: 'a => unit = "ok"
@module("assert") external fail: 'a => unit = "fail"

@deprecated("use fail instead") @module("assert")
external fail': (
  'a,
  'a,
  ~message: string=?,
  ~operator: string=?,
  ~stackStartFn: 'b => 'c=?,
) => unit = "fail"
