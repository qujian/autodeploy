-module(generic_handler).
-behaviour(cowboy_middleware).

-export([init/3]).
-export([execute/2]).
-export([terminate/3]).

-record(state, {
}).

init({tcp, http}, Req, _Opts) ->
	{ok, Req, #state{}}.

execute(Req, State=#state{}) ->
    {ok, Req2} = cowboy_req:reply(200,
        [{<<"content-type">>, <<"text/plain">>}],
        <<"Hello From Autodeploy!">>,
        Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
	ok.
