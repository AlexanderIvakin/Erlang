-module(ppool_sup).
-behaviour(supervisor).

%% Public API
-export([start_link/3]).

%% supervisor callbacks
-export([init/1]).

%% Public API
start_link(Name, Limit, MFA) ->
	supervisor:start_link(?MODULE, {Name, Limit, MFA}).

%% supervisor callbacks
init({Name, Limit, MFA}) ->
	MaxRestart = 1,
	MaxTime = 3600,
	{ok, {{one_for_all, MaxRestart, MaxTime},
		  [{serv,
			{ppool_serv, start_link, [Name, Limit, self(), MFA]},
			permanent, 5000, worker, [ppool_serv]}]
		 }
	}.