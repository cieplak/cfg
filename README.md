cfg
=====

cfg is a configuration registry for OTP applications.

usage
-----

Add cfg to your rebar3 dependencies:
```
{deps, [
  ...
  {cfg, {git, "https://github.com/cieplak/cfg.git", {branch, "master"}}}
]}.
```

Add cfg to your app.src:
```
{applications, [
  kernel,
  stdlib,
  ...,
  cfg
]},
```

Get and set configuration values:
```
(erl)> cfg:get('users.db.host').
undefined
(erl)> cfg:set('users.db.host', <<"localhost">>).
<<"localhost">>
(erl)> cfg:get('users.db.host').
<<"localhost">>
```

design
------

```
+-------------------------------+
|                               |
|                               |
|           cfg app             |
|                               |
|      +----------------+       |
|      |                |       |
|      | cfg supervisor |       |
|      |                |       |
|      +-------+--------+       |
|              |                |
|              |                |
|      +-------+--------+       |
|      |                |       |
|      |                |       |
|      | cfg gen_server |       |
|      |                |       |
|      | +-----------+  |       |
|      | | ets table |  |       |
|      | +-----------+  |       |
|      |                |       |
|      +----------------+       |
|                               |
|                               |
+-------------------------------+
```

testing
-------

Run `Common Test` suite:
```
[~/code/cfg] $ rebar3 ct
===> Verifying dependencies...
===> Compiling cfg
===> Running Common Test suites...
%%% cfg_SUITE ==> test_cfg: OK
All 1 tests passed.
```
