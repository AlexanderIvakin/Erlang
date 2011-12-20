-module(multiproc).
-compile(export_all).

important() ->
	receive
		{Priority, Message} when Priority > 10 ->
			[Message | important()]
	after 0 ->
		normal()
	end.
	
normal() ->
	receive
		{_, Message} -> [Message | normal()]
	after 0 ->
		[]
	end.   
