-module(message_router).
-export([start/0, stop/1, send_chat_message/3, route_messages/0]).

start() ->
	spawn(?MODULE, route_messages, []).
	
stop(RouterPid) ->
	RouterPid ! shutdown.	

send_chat_message(RouterPid, Addressee, MessageBody) ->
	RouterPid ! {send_chat_msg, Addressee, MessageBody}.

route_messages() ->
	receive 
		{send_chat_msg, Addressee, MessageBody} ->
			Addressee ! {recv_chat_msg, MessageBody},
			route_messages();
		{recv_chat_msg, MessageBody} -> 
			io:format("Received: ~p~n", [MessageBody]),
			route_messages();
		shutdown ->
			io:format("Shutting down~n");	
		Unknown ->
			io:format("Warning! Received: ~p~n", [Unknown]),
			route_messages()
	end.