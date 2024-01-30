type rec testFunction = Internal.FunctionType.test<(~error: Js.Exn.t=?, unit) => unit, unit>
and hook = Internal.FunctionType.hookFunction<(~error: Js.Exn.t=?, unit) => unit, unit>

let it: testFunction
let it_only: testFunction
let it_skip: testFunction
let before: hook
let after: hook
let beforeEach: hook
let afterEach: hook
