type rec testFunction = Internal.FunctionType.test<(~error: Js.Exn.t=?, unit) => unit, unit>
and hook = Internal.FunctionType.hookFunction<(~error: Js.Exn.t=?, unit) => unit, unit>

let it = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeAsyncTest(Internal.Async.it, description, ~timeout?, ~retries?, ~slow?, doneCallback)
let it_only = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeAsyncTest(Internal.Async.it_only, description, ~timeout?, ~retries?, ~slow?, doneCallback)
let it_skip = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeAsyncTest(Internal.Async.it_skip, description, ~timeout?, ~retries?, ~slow?, doneCallback)
let before = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeAsyncHook(Internal.Async.before, ~timeout?, ~retries?, ~slow?, doneCallback)
let after = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeAsyncHook(Internal.Async.after, ~timeout?, ~retries?, ~slow?, doneCallback)
let beforeEach = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeAsyncHook(Internal.Async.beforeEach, ~timeout?, ~retries?, ~slow?, doneCallback)
let afterEach = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeAsyncHook(Internal.Async.afterEach, ~timeout?, ~retries?, ~slow?, doneCallback)
