-module(fizzbuzz).

-export([start/0, calc/2, generate_sequence/2, shutdown/1]).

start() ->
	spawn(fun() -> loop() end).

calc(Pid, Value) ->
	Pid ! {analyze, self(), Value},
	receive
		Result -> Result
	end.
	
generate_sequence(Pid, N) ->
	case is_number(N) of
		false ->
			exit({badarg, N});
		true ->
			Pid ! {generate, self(), N},
			receive
				{ok, Result} ->
					Result
			after 1000 ->
				{error, timeout}			
			end
	end.	
	
shutdown(Pid) ->
	Pid ! shutdown.	

analyze(N) ->
	if  
		N rem 15 == 0 ->
			fizzbuzz;
		N rem 3 == 0 ->
			fizz;
		N rem 5 == 0 ->
			buzz;  
		true ->
			N
	end.
	
loop() ->
	receive
		{analyze, Caller, Value} ->
			Caller ! analyze(Value),
			loop();
		{generate, Caller, N} ->
			Caller ! {ok, lists:map(fun(Value) -> analyze(Value) end, lists:seq(1,N))},
			loop();	
		shutdown ->
			io:format("Shutting down... ~n"),
			ok
	end.	