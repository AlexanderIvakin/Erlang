-module(ppool_worker_sup).
-behaviour(supervisor).

%% Public API
-export([start_link/1]).

%% supervisor callbacks
-export([init/1]).

%% Public API
start_link(MFA = {_, _, _}) ->
	supervisor:start_link(?MODULE, MFA).

%% supervisor callbacks
init({M, F, A}) ->
	MaxRestart = 5,
	MaxTime = 3600,
	{ok, {{simple_one_for_one, MaxRestart, MaxTime},
		  [{pool_worker,
		 	{M, F, A},
			temporary, 5000, worker, [M]}]
		 }
	}.