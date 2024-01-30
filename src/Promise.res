type rec testFunction<'a> = Internal.FunctionType.test<unit, Js.Promise.t<'a>>
and hook<'a> = Internal.FunctionType.hookFunction<unit, Js.Promise.t<'a>>
module WithOptions = {
  let it = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
    Internal.makeTest(Internal.Promise.it, description, ~timeout?, ~retries?, ~slow?, doneCallback)

  let it_only = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
    Internal.makeTest(
      Internal.Promise.it_only,
      description,
      ~timeout?,
      ~retries?,
      ~slow?,
      doneCallback,
    )
  let it_skip = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
    Internal.makeTest(
      Internal.Promise.it_skip,
      description,
      ~timeout?,
      ~retries?,
      ~slow?,
      doneCallback,
    )
  let before = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
    Internal.makeHook(Internal.Promise.before, ~timeout?, ~retries?, ~slow?, doneCallback)
  let after = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
    Internal.makeHook(Internal.Promise.after, ~timeout?, ~retries?, ~slow?, doneCallback)
  let beforeEach = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
    Internal.makeHook(Internal.Promise.beforeEach, ~timeout?, ~retries?, ~slow?, doneCallback)
  let afterEach = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
    Internal.makeHook(Internal.Promise.afterEach, ~timeout?, ~retries?, ~slow?, doneCallback)
}

@val
external it: (string, unit => Js.Promise.t<'a>) => unit = "it"
@val
external it_only: (string, unit => Js.Promise.t<'a>) => unit = "it.only"
@val
external it_skip: (string, unit => Js.Promise.t<'a>) => unit = "it.skip"
@val
external before: (unit => Js.Promise.t<'a>) => unit = "before"
@val
external after: (unit => Js.Promise.t<'a>) => unit = "after"
@val
external beforeEach: (unit => Js.Promise.t<'a>) => unit = "beforeEach"
@val
external afterEach: (unit => Js.Promise.t<'a>) => unit = "afterEach"
