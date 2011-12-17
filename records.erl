-module(records).
-include("records.hrl").
-compile(export_all).

-record(robot, {name,
				type = industrial,
				hobbies,
				details = []}).
				
first_robot() ->
	#robot{name = "Mechatron",
		   type = handmade,
		   details = ["Moved by a small man inside"]}.
		
car_factory(CorpName) ->
	#robot{name = CorpName, hobbies = "building cars"}.
	
-record(user, {id, name, group, age}).

%% use pattern matching to filter
admin_panel(#user{name = Name, group = admin}) ->
	Name ++ " is allowed!";
admin_panel(#user{name = Name}) ->
	Name ++ " is not allowed.".
	
%% can extend user without a problem
adult_section(U = #user{}) when U#user.age >= 18 ->
	allowed;
adult_section(_) ->
	forbidden.
	
repairman(Rob) ->
	Details = Rob#robot.details,
	NewRob = Rob#robot{details = ["Repaired by repairman" | Details]},
	{repaired, NewRob}.

included() -> #included{some_field = "some value"}.















