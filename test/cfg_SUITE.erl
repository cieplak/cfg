-module(cfg_SUITE).
-compile(export_all).
-include_lib("common_test/include/ct.hrl").

all() ->
  [test_cfg].

test_cfg(_Config) ->
  {ok,_} = application:ensure_all_started(cfg),
  undefined = cfg:get('users.db.host'),
  cfg:set('users.db.host', <<"localhost">>),
  <<"localhost">> = cfg:get('users.db.host').
