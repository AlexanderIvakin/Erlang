%% @author Alexander Ivakin <alex.ivakin@icloud.com>
%% @doc Functions for calculating areas of geometric shapes
%% @copyright 2015 Alexander Ivakin
%% @version 0.1

-module(geom).
-export([area/2]).

%% @doc Calculates the area of a rectangle, given the
%% length and width.

-spec(area(number(), number()) -> number()).

area(L, W) ->
  L * W.