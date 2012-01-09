-module(chat_client).
-export([send_message/2, start_router/0,
		 register_nickname/1, unregister_nickname/1,
		 handle_messages/1]).

register_nickname(Nickname) ->
	Pid = spawn(?MODULE, handle_messages, [Nickname]),
	message_router:register_nick(Nickname, Pid).
	
unregister_nickname(Nickname) ->
	message_router:unregister_nick(Nickname).   

send_message(Addressee, MessageBody) ->
	message_router:send_chat_message(Addressee, MessageBody).  
		
start_router() ->
	message_router:start_link().
	
handle_messages(Nickname) ->
	receive
		{printmsg, MessageBody} ->
			io:format("~p received: ~p~n", [Nickname, MessageBody]),
			handle_messages(Nickname);
		stop ->
			ok
	end.	