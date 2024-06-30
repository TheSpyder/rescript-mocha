open Mocha

exception RejectedError(string)

describe("Promise", () => {
  let empty = () => Js.Promise.make((~resolve, ~reject as _) => resolve())

  /* Calls given function after a small delay */
  let delay = fn => {
    Js.Promise.make((~resolve, ~reject as _) =>
      ignore(
        Js.Global.setTimeout(
          () => {
            fn()
            resolve()
          },
          300,
        ),
      )
    )
  }

  /* Rejects the promise after a small delay */
  let delay_reject = () =>
    Js.Promise.make((~resolve as _, ~reject) =>
      ignore(
        Js.Global.setTimeout(() => reject(RejectedError("promise successfully rejected")), 300),
      )
    )

  describe("Success", () => {
    Async.it("should be successful", () => delay(() => Assert.equal(3, 3)))
  })

  describe_skip("Error", () => Async.it("should error out", () => delay_reject()))

  describe("Hooks", () => {
    let hooks = ref({
      "before": false,
      "beforeEach": 0,
      "after": false,
      "afterEach": 0,
    })

    Async.before(
      () => delay(() => hooks := {"before": true, "beforeEach": 0, "after": false, "afterEach": 0}),
    )

    Async.beforeEach(
      () =>
        delay(
          () => {
            let hooks' = hooks.contents
            hooks :=
              {
                "before": hooks'["before"],
                "beforeEach": hooks'["beforeEach"] + 1,
                "after": hooks'["after"],
                "afterEach": hooks'["afterEach"],
              }
          },
        ),
    )

    Async.it("is the first test", () => empty())
    Async.it("is the second test", () => empty())
    Async.it("is the third test", () => empty())

    Async.afterEach(
      () =>
        delay(
          () => {
            let hooks' = hooks.contents
            hooks :=
              {
                "before": hooks'["before"],
                "beforeEach": hooks'["beforeEach"],
                "after": hooks'["after"],
                "afterEach": hooks'["afterEach"] + 1,
              }
          },
        ),
    )

    Async.after(
      () =>
        delay(
          () => {
            let hooks' = hooks.contents
            hooks :=
              {
                "before": hooks'["before"],
                "beforeEach": hooks'["beforeEach"],
                "after": true,
                "afterEach": hooks'["afterEach"],
              }

            /* TODO: this is pretty ugly, caused by (facebook/reason issue #2108) */
            let hooks'' = hooks.contents
            Assert.ok(hooks''["before"])
            Assert.equal(hooks''["beforeEach"], 3)
            Assert.equal(hooks''["afterEach"], 3)
            Assert.ok(hooks''["after"])
          },
        ),
    )
  })

  describe("Timeout", () => {
    Async.it_skip(
      "should time out",
      () => {
        This.timeout(50)
        Js.Promise.make(
          (~resolve, ~reject as _) => ignore(Js.Global.setTimeout(() => resolve(), 51)),
        )
      },
    )

    Async.it(
      "should not time out",
      () => {
        This.timeout(50)
        Js.Promise.make(
          (~resolve, ~reject as _) => ignore(Js.Global.setTimeout(() => resolve(), 40)),
        )
      },
    )
  })

  describe("Retries", () => {
    let retry_count = ref(0)
    Async.it(
      "should succeed",
      () => {
        This.retries(2)
        Js.Promise.make(
          (~resolve, ~reject as _) => {
            retry_count := retry_count.contents + 1
            Assert.ok(retry_count.contents == 1)
            resolve()
          },
        )
      },
    )

    Async.it_skip(
      "should fail",
      () => {
        This.retries(3)
        Js.Promise.make(
          (~resolve, ~reject as _) => {
            retry_count := retry_count.contents + 1
            Assert.ok(retry_count.contents == 6)
            resolve()
          },
        )
      },
    )
  })

  describe("Slow", () =>
    Async.it(
      "should be considered slow",
      () => {
        This.slow(50)
        Js.Promise.make(
          (~resolve, ~reject as _) => ignore(Js.Global.setTimeout(() => resolve(), 60)),
        )
      },
    )
  )
})
