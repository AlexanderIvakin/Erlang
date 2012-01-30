%% Demo module, a nagger for tasks,
%% because the previous one wasn't good enough
-module(ppool_nagger).
-behaviour(gen_server).

%% Public API
-export([start_link/4, stop/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2,
		 handle_info/2, code_change/3, terminate/2]).

%% Public API
start_link(Task, Delay, Max, SendTo) ->
	gen_server:start_link(?MODULE, {Task, Delay, Max, SendTo}, []).

stop(Pid) ->
    gen_server:call(Pid, stop).

%% gen_server callbacks
init({Task, Delay, Max, SendTo}) ->
	{ok, {Task, Delay, Max, SendTo}, Delay}.

handle_call(stop, _From, State) ->
	{stop, normal, ok, State};
	
handle_call(_Msg, _From, State) ->
	{noreply, State}.

handle_cast(_Msg, State) ->
	{noreply, State}.

handle_info(timeout, {Task, Delay, Max, SendTo}) ->
	SendTo ! {self(), Task},
	if Max =:= infinity ->
		{noreply, {Task, Delay, Max, SendTo}, Delay};
	   Max =< 1 ->
		{stop, normal, {Task, Delay, 0, SendTo}};
	   Max > 1  ->
		{noreply, {Task, Delay, Max-1, SendTo}, Delay}
	end;
	
handle_info(_Msg, State) ->
	{noreply, State}.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.

terminate(_Reason, _State) -> ok.

%% Private server functions