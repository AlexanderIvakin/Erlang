-module(recursive).
-export([fac/1, len/1, tail_fac/1, tail_len/1, duplicate/2, tail_duplicate/2,
		 tail_reverse/1, tail_sublist/2, tail_zip/2, tail_lenient_zip/2,
		 quicksort/1, lc_quicksort/1]).

fac(0) -> 1;
fac(N) when N > 0 -> N*fac(N - 1).

len([]) -> 0;
len([_]) -> 1;
len([_|T]) -> len(T) + 1.

tail_fac(N) -> tail_fac(N, 1).

tail_fac(0, Acc) -> Acc;
tail_fac(N, Acc) when N > 0 -> tail_fac(N - 1, N * Acc).

tail_len(L) -> tail_len(L, 0).

tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T, 1 + Acc).

duplicate(0, _) -> [];
duplicate(N, Term) when N > 0 ->
	[Term | duplicate(N - 1, Term)].
	
tail_duplicate(N, Term) ->
	tail_duplicate(N, Term, []).
	
tail_duplicate(0, _, List) -> List;
tail_duplicate(N, Term, List) when N > 0 ->
	tail_duplicate(N - 1, Term, [Term | List]).	
	
tail_reverse(List) -> tail_reverse(List, []).

tail_reverse([], Acc) -> Acc;
tail_reverse([H|T], Acc) -> tail_reverse(T, [H | Acc]).

tail_sublist(List, N) -> tail_reverse(tail_sublist(List, N, [])).

tail_sublist(_, 0, SubList) -> SubList;
tail_sublist([], _, SubList) -> SubList;
tail_sublist([H|T], N, SubList) when N > 0 ->
	tail_sublist(T, N - 1, [H|SubList]).
	
tail_zip(ListX, ListY) ->  
    lists:reverse(tail_zip(ListX, ListY, [])).

tail_zip([], [], Zip) -> Zip;
tail_zip([X|Xs], [Y|Ys], Zip) ->
	tail_zip(Xs, Ys, [{X, Y} | Zip]).
	
tail_lenient_zip(ListX, ListY) ->
	lists:reverse(tail_lenient_zip(ListX, ListY, [])).
	
tail_lenient_zip(_, [], Zip) -> Zip;
tail_lenient_zip([], _, Zip) -> Zip;
tail_lenient_zip([X|Xs], [Y|Ys], Zip) ->
	tail_lenient_zip(Xs, Ys, [{X, Y} | Zip]).

quicksort([]) -> [];
quicksort([Pivot | Rest]) ->
	{Smaller, Larger} = partition(Pivot, Rest, [], []),
	quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).
	
partition(_, [], Smaller, Larger) -> {Smaller, Larger};
partition(Pivot, [H|T], Smaller, Larger) ->
	if H =< Pivot -> partition(Pivot, T, [H|Smaller], Larger);
		H > Pivot -> partition(Pivot, T, Smaller, [H|Larger])
	end.

lc_quicksort([]) -> [];
lc_quicksort([Pivot | Rest]) ->
	lc_quicksort([Smaller || Smaller <- Rest, Smaller =< Pivot])
	++ [Pivot] ++
	lc_quicksort([Larger || Larger <- Rest, Larger > Pivot]).







	