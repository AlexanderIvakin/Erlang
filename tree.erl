-module(tree).
-export([empty/0, insert/3, lookup/2, has_value/2]).

empty() -> {node, 'nil'}.

insert(Key, Val, {node, 'nil'}) ->
	{node, {Key, Val, {node, 'nil'}, {node, 'nil'}}};
	
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey < Key ->
	{node, {Key, Val, insert(NewKey, NewVal, Smaller), Larger}};
	
insert(NewKey, NewVal, {node, {Key, Val, Smaller, Larger}}) when NewKey > Key ->
	{node, {Key, Val, Smaller, insert(NewKey, NewVal, Larger)}};
	
insert(Key, NewVal, {node, {Key, _, Smaller, Larger}}) ->
	{node, {Key, NewVal, Smaller, Larger}}.
	
lookup(_, {node, 'nil'}) ->
	undefined;
	
lookup(Key, {node, {Key, Val, _, _}}) -> {ok, Val};
lookup(Key, {node, {NodeKey, _, Smaller, _}}) when Key < NodeKey ->
	lookup(Key, Smaller);
lookup(Key, {node, {NodeKey, _, _, Larger}}) when Key > NodeKey ->
	lookup(Key, Larger).
	
has_value(Val, Tree) ->
	try has_value_impl(Val, Tree) of
		false -> false
	catch
		true -> true
	end.
	
has_value_impl(_, {node, 'nil'}) ->
	false;
has_value_impl(Val, {node, {_, Val, _, _}}) ->
	throw(true);
has_value_impl(Val, {node, {_, _, Left, Right}}) ->
	has_value_impl(Val, Left),
	has_value_impl(Val, Right).	
	
	
	
	
	
	
	