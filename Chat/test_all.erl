-module(test_all).

-include_lib("eunit/include/eunit.hrl").

all_test_() ->
	[{module, test_fizzbuzz},
	 {module, test_fibber}] .