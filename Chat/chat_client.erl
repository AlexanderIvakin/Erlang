-module(chat_client).
-export([send_message/3]).

send_message(RouterPid, Addressee, MessageBody) ->
	message_router:send_chat_message(RouterPid, Addressee, MessageBody).