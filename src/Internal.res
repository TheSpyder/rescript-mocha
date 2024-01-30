type rec mocha
and doneCallback = Js.Nullable.t<Js.Exn.t> => unit
and testFunction<'arg, 'result> = (string, @this (mocha, 'arg) => 'result) => unit

module FunctionType = {
  /* Internal representation of mocha test functions */
  type rec internal_callback = (
    . string,
    @this (mocha, doneCallback) => unit,
  ) => unit
  and internal_callback_anon = (. @this (mocha, doneCallback) => unit) => unit
  /* Internal representation with `unit => unit` callback (special-cased to
   ensure compiled JS is a nullary function) */
  and internal_nullary<'result> = (. string, @this (mocha => 'result)) => unit
  and internal_anon<'result> = (. @this (mocha => 'result)) => unit
  /* Nicer representation of mocha test functions */
  and hookFunction<'arg, 'result> = (
    ~timeout: int=?,
    ~retries: int=?,
    ~slow: int=?,
    'arg => 'result,
  ) => unit
  /* For `describe` and `it`, which require a description */
  and test<'arg, 'result> = (
    string,
    ~timeout: int=?,
    ~retries: int=?,
    ~slow: int=?,
    'arg => 'result,
  ) => unit
}

/* Mocha bindings on `this` for `describe` and `it` functions */
module This = {
  @send external timeout: (mocha, int) => unit = "timeout"
  @send external retries: (mocha, int) => unit = "retries"
  @send external slow: (mocha, int) => unit = "slow"
}

module Sync = {
  @val
  external describe: (. string, @this (mocha => unit)) => unit = "describe"
  @val
  external describe_only: (. string, @this (mocha => unit)) => unit = "describe.only"
  @val
  external describe_skip: (. string, @this (mocha => unit)) => unit = "describe.skip"
  @val
  external it: (. string, @this (mocha => unit)) => unit = "it"
  @val
  external it_only: (. string, @this (mocha => unit)) => unit = "it.only"
  @val
  external it_skip: (. string, @this (mocha => unit)) => unit = "it.skip"
  @val
  external before: (. @this (mocha => unit)) => unit = "before"
  @val
  external after: (. @this (mocha => unit)) => unit = "after"
  @val
  external beforeEach: (. @this (mocha => unit)) => unit = "beforeEach"
  @val
  external afterEach: (. @this (mocha => unit)) => unit = "afterEach"
}

module Async = {
  @val
  external it: (. string, @this (mocha, doneCallback) => unit) => unit = "it"
  @val
  external it_only: (. string, @this (mocha, doneCallback) => unit) => unit =
    "it.only"
  @val
  external it_skip: (. string, @this (mocha, doneCallback) => unit) => unit =
    "it.skip"
  @val
  external before: (. @this (mocha, doneCallback) => unit) => unit = "before"
  @val
  external after: (. @this (mocha, doneCallback) => unit) => unit = "after"
  @val
  external beforeEach: (. @this (mocha, doneCallback) => unit) => unit = "beforeEach"
  @val
  external afterEach: (. @this (mocha, doneCallback) => unit) => unit = "afterEach"
}

module Promise = {
  @val
  external it: (. string, @this (mocha => Js.Promise.t<'a>)) => unit = "it"
  @val
  external it_only: (. string, @this (mocha => Js.Promise.t<'a>)) => unit = "it.only"
  @val
  external it_skip: (. string, @this (mocha => Js.Promise.t<'a>)) => unit = "it.skip"
  @val
  external before: (. @this (mocha => Js.Promise.t<'a>)) => unit = "before"
  @val
  external after: (. @this (mocha => Js.Promise.t<'a>)) => unit = "after"
  @val
  external beforeEach: (. @this (mocha => Js.Promise.t<'a>)) => unit = "beforeEach"
  @val
  external afterEach: (. @this (mocha => Js.Promise.t<'a>)) => unit = "afterEach"
}

%%private(
  let applyOptions = (~timeout=?, ~retries=?, ~slow=?, mocha) => {
    switch timeout {
    | Some(milliseconds) => This.timeout(mocha, milliseconds)
    | None => ()
    }
    switch retries {
    | Some(max_retries) => This.retries(mocha, max_retries)
    | None => ()
    }
    switch slow {
    | Some(milliseconds) => This.slow(mocha, milliseconds)
    | None => ()
    }
  }
)
/* Wraps the options normally set with `this` in mocha and makes them optional arguments */
let makeTest: FunctionType.internal_nullary<'result> => FunctionType.test<unit, 'result> = (
  fn,
  description,
  ~timeout=?,
  ~retries=?,
  ~slow=?,
  doneCallback,
) =>
  fn(.description, @this mocha => {
    applyOptions(~timeout?, ~retries?, ~slow?, mocha)
    doneCallback()
  })
let makeHook: FunctionType.internal_anon<'result> => FunctionType.hookFunction<unit, 'result> = (
  fn,
  ~timeout=?,
  ~retries=?,
  ~slow=?,
  doneCallback,
) =>
  fn(.@this mocha => {
    applyOptions(~timeout?, ~retries?, ~slow?, mocha)
    doneCallback()
  })

let makeAsyncTest: FunctionType.internal_callback => FunctionType.test<(~error: Js.Exn.t=?, unit) => unit, unit> = (
  fn,
  description,
  ~timeout=?,
  ~retries=?,
  ~slow=?,
  doneCallback,
) =>
  fn(.description, @this (mocha, doneCallback') => {
    applyOptions(~timeout?, ~retries?, ~slow?, mocha)

    let done_fn = (~error=?, ()) => doneCallback'(Js.Nullable.fromOption(error))
    doneCallback(done_fn)
  })

let makeAsyncHook: FunctionType.internal_callback_anon => FunctionType.hookFunction<
  (~error: Js.Exn.t=?, unit) => unit,
  unit,
> = (fn, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  fn(.@this (mocha, doneCallback') => {
    applyOptions(~timeout?, ~retries?, ~slow?, mocha)

    let done_fn = (~error=?, ()) => doneCallback'(Js.Nullable.fromOption(error))
    doneCallback(done_fn)
  })
