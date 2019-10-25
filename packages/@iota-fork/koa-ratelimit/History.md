
4.0.0 / 2017-03-12
==================

  * Update signature to use async/await for koa@2

3.0.0 / 2017-03-12
==================

  * Update ratelimiter@3.0.2

2.4.0 / 2016-10-26
==================

  * Add custom error support

2.3.0 / 2016-05-12
==================

  * Add support for custom header names (#20)

2.2.0 / 2016-04-11
==================

  * Add option to throw error instead of setting body
  * bump deps

2.1.0 / 2015-01-04
==================

  * Merge pull request #11 from seegno/support/flush-redis-before-testing
  * Merge pull request #9 from seegno/enhancement/add-id-verification
  * Flush redis limit keys before running tests
  * Add id verification to bypass ratelimiting

2.0.0 / 2015-01-02
==================

  * Merge pull request #10 from seegno/support/update-ratelimiter-2-0-0
  * Update `debug@2.1.1` and `ms@0.7.0`
  * Update recommended node version to >= 0.11.13
  * Update dev dependencies
  * Update ratelimiter@2.0.0
  * Replace `thunkify` by `thenify`.

1.1.0 / 2014-12-03
==================

  * Adds callback for defining own comparator ID. Fixes #3

1.0.3 / 2014-05-24
==================

 * fix: don't yield to downstream middleware if ratelimit is hit.

1.0.2 / 2014-05-22
==================

 * yield to next only when rate limit isn't hit

1.0.1 / 2013-11-29
==================

 * fix ms dep
