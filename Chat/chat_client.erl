-module(chat_client).
-export([send_message/2, print_message/2, start_router/0,
		 register_nickname/1, unregister_nickname/1]).

register_nickname(Nickname) ->
	message_router:register_nick(Nickname, fun(Msg) -> chat_client:print_message(Nickname, Msg) end).
	
unregister_nickname(Nickname) ->
	message_router:unregister_nick(Nickname).   

send_message(Addressee, MessageBody) ->
	message_router:send_chat_message(Addressee, MessageBody).  
	
print_message(Who, MessageBody) ->
	io:format("~p received: ~p~n", [Who, MessageBody]).         
	
start_router() ->
	message_router:start().	