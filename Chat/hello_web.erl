-module(hello_web).

-export([start/1, stop/0]).   

-define(CONTENT, <<"<html><head><title>Hello, Web!</title></head><body>Hello, Web!</body></html>">>).

start(Port) ->
	mochiweb_http:start([{port, Port}, {loop, fun(Req) ->
													Req:ok({"text/html", ?CONTENT}) end}]).
													
stop() ->
	mochiweb_http:stop().													