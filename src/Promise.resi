type rec testFunction<'a> = Internal.FunctionType.test<unit, Js.Promise.t<'a>>
and hook<'a> = Internal.FunctionType.hookFunction<unit, Js.Promise.t<'a>>

let it: testFunction<'a>
let it_only: testFunction<'a>
let it_skip: testFunction<'a>
let before: hook<'a>
let after: hook<'a>
let beforeEach: hook<'a>
let afterEach: hook<'a>
