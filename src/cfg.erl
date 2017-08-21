-module(cfg).
-behaviour(gen_server).

-export([
  start_link/0,
  get/1,
  set/2
]).

-export([
  init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3
]).

-define(SERVER, ?MODULE).

-record(state, {}).

start_link() ->
  gen_server:start_link({global, ?SERVER}, ?MODULE, [], []).

get(Key) ->
  {ok, Value} = gen_server:call({global, ?SERVER}, {get, Key}),
  Value.

set(Key, Value) ->
  {ok, Value} = gen_server:call({global, ?SERVER}, {set, Key, Value}),
  Value.

init([]) ->
  ets:new(?SERVER, [set, named_table, public]),
  {ok, #state{}}.

handle_call({get, Key}, _From, State) ->
  Value = case ets:lookup(?SERVER, Key) of
    [{Key, Val}] -> Val;
    [] -> undefined
  end,
  {reply, {ok, Value}, State};
handle_call({set, Key, Value}, _From, State) ->
  ets:insert(?SERVER, {Key, Value}),
  {reply, {ok, Value}, State};
handle_call(_Message, _From, State) ->
  {reply, error, State}.

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.
