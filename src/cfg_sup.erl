-module(cfg_sup).
-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
  supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init(_Args) ->
  RestartStrategy = {one_for_one, 10, 60},
  Actor = {cfg, {cfg, start_link, []}, permanent, 2000, worker, [cfg]},
  Children = [Actor],
  {ok, {RestartStrategy, Children}}.
