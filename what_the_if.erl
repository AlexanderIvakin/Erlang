-module(what_the_if).
-export([oh_god/1, help_me/1, prepend/2]).
%-export([heh_fine/0]).

% heh_fine() ->
% 	if 1 =:= 1 ->
% 		works
% 	end,
% 	if 1 =:= 2; 1 =:= 1 ->
% 		works
% 	end,
% 	if 1 =:= 2, 1 =:= 1 ->
% 		fails
% 	end.

oh_god(N) ->
	if N =:= 2 -> might_succeed;
		true -> always_does		%% this is Erlang's if's else
	end.
	
help_me(Animal) ->
	Talk = if Animal == cat -> "meow";
			  Animal == beef -> "mooo";
			  Animal == dog	 -> "bark";
			  Animal == tree -> "bark";
			  true -> "fgdadfgna"
		   end,
	{Animal, "says " ++ Talk ++ "!"}.
	
prepend(X, []) ->
	[X];

prepend(X, Set) ->
	case lists:member(X, Set) of
		true -> Set;
		false -> [X|Set]
	end.












	
	 