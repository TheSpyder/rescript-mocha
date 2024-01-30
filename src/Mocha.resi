type rec testFunction = Internal.FunctionType.test<unit, unit>
and hook = Internal.FunctionType.hookFunction<unit, unit>

let describe: testFunction
let describe_only: testFunction
let describe_skip: testFunction
let it: testFunction
let it_only: testFunction
let it_skip: testFunction
let before: hook
let after: hook
let beforeEach: hook
let afterEach: hook
