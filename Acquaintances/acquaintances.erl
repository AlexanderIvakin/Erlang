-module(acquaintances).
-export([main/1]).

-record(person, {name, wishes = 0, acquaintances = []}).

main([FileName]) ->
	{ok, Bin} = file:read_file(FileName),
	Persons = parse_data(Bin),
	io:format("Input data: ~p~n", [Persons]),
	AcqMap = resolve_acquaintances(Persons),
	io:format("Resolved acquaintances: ~p~n", [AcqMap]),
	erlang:halt().
	
parse_data(Bin) when is_binary(Bin) ->
	parse_data(binary_to_list(Bin));
	
parse_data(Str) when is_list(Str) ->
	Wishes = lists:map(fun(Line) -> string:tokens(Line, "\t:") end, string:tokens(Str, "\n")),
	lists:map(fun([X, N]) -> 
		make_person(string:strip(X), element(1, string:to_integer(string:strip(N)))) end, 
		Wishes).
	
make_person(X, N) -> make_person(X, N, []).
make_person(X, N, A) -> #person{name = X, wishes = N, acquaintances = A}.

resolve_impl([], SatisfiedList) -> SatisfiedList;
resolve_impl([_P = #person{}], _) -> erlang:error("No solution");
resolve_impl(UnsatisfiedList, SatisfiedList) ->
	Top = hd(UnsatisfiedList),
	if Top#person.wishes > length(tl(UnsatisfiedList)) ->
		erlang:error("No solution");
	   true ->
		TopsAcquaintances = lists:nthtail(length(tl(UnsatisfiedList)) - Top#person.wishes,
									  tl(UnsatisfiedList)),
		NewSatisfiedList = 
			lists:append([[make_person(Top#person.name, 0, 
									   lists:append([[P#person.name || P <- TopsAcquaintances],Top#person.acquaintances]))],
						  [make_person(P#person.name, 0,
									   [Top#person.name | P#person.acquaintances]) 
									|| P <- TopsAcquaintances, P#person.wishes == 1],
						  SatisfiedList]),
		NewUnsatisfiedList = 
			lists:append([lists:sublist(UnsatisfiedList, 2, 
										length(UnsatisfiedList) - Top#person.wishes - 1),
						  [make_person(P#person.name, P#person.wishes - 1,
									   [Top#person.name | P#person.acquaintances])
									|| P <- TopsAcquaintances, P#person.wishes > 1]]),
		resolve_impl(NewUnsatisfiedList, NewSatisfiedList)
	end.

resolve_acquaintances(Persons) ->
	N = length(Persons),
	Total = lists:foldl(fun(P, Sum) -> P#person.wishes + Sum end, 0, Persons),
    if 0 =< Total andalso Total =< N*(N - 1) ->
		io:format("Proceeding to solution.~n",[]),
		Sorted = lists:sort(fun(P1, P2) -> P1#person.wishes > P2#person.wishes end, Persons),		
		resolve_impl(Sorted, []);
	   true -> 
		io:format("Can't resolve the puzzle!~n",[]),
		Persons
	end.