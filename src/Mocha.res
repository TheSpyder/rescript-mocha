type rec testFunction = Internal.FunctionType.test<unit, unit>
and hook = Internal.FunctionType.hookFunction<unit, unit>

let describe: testFunction = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeTest(Internal.Sync.describe, description, ~timeout?, ~retries?, ~slow?, doneCallback)
let describe_only: testFunction = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeTest(Internal.Sync.describe_only, description, ~timeout?, ~retries?, ~slow?, doneCallback)
let describe_skip: testFunction = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeTest(Internal.Sync.describe_skip, description, ~timeout?, ~retries?, ~slow?, doneCallback)

let it = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeTest(Internal.Sync.it, description, ~timeout?, ~retries?, ~slow?, doneCallback)
let it_only = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeTest(Internal.Sync.it_only, description, ~timeout?, ~retries?, ~slow?, doneCallback)
let it_skip = (description, ~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeTest(Internal.Sync.it_skip, description, ~timeout?, ~retries?, ~slow?, doneCallback)
let before = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeHook(Internal.Sync.before, ~timeout?, ~retries?, ~slow?, doneCallback)
let after = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeHook(Internal.Sync.after, ~timeout?, ~retries?, ~slow?, doneCallback)
let beforeEach = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeHook(Internal.Sync.beforeEach, ~timeout?, ~retries?, ~slow?, doneCallback)
let afterEach = (~timeout=?, ~retries=?, ~slow=?, doneCallback) =>
  Internal.makeHook(Internal.Sync.afterEach, ~timeout?, ~retries?, ~slow?, doneCallback)
