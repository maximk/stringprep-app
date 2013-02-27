%%%----------------------------------------------------------------------
%%% File    : stringprep.erl
%%% Author  : Alexey Shchepin <alexey@process-one.net>
%%% Purpose : Interface to stringprep_drv
%%% Created : 16 Feb 2003 by Alexey Shchepin <alexey@proces-one.net>
%%%
%%%
%%% ejabberd, Copyright (C) 2002-2011   ProcessOne
%%%
%%% This program is free software; you can redistribute it and/or
%%% modify it under the terms of the GNU General Public License as
%%% published by the Free Software Foundation; either version 2 of the
%%% License, or (at your option) any later version.
%%%
%%% This program is distributed in the hope that it will be useful,
%%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%%% General Public License for more details.
%%%
%%% You should have received a copy of the GNU General Public License
%%% along with this program; if not, write to the Free Software
%%% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
%%% 02111-1307 USA
%%%
%%%----------------------------------------------------------------------

-module(stringprep).
-author('alexey@process-one.net').

-behaviour(gen_server).

-export([start/0, start_link/0,
         tolower/1,
         nameprep/1,
         nodeprep/1,
         resourceprep/1]).

%% Internal exports, call-back functions.
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         code_change/3,
         terminate/2]).

-define(NAMEPREP_COMMAND, 1).
-define(NODEPREP_COMMAND, 2).
-define(RESOURCEPREP_COMMAND, 3).

start() ->
    gen_server:start({local, ?MODULE}, ?MODULE, [], []).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
	{ok,[]}.

%%% --------------------------------------------------------
%%% The call-back functions.
%%% --------------------------------------------------------

handle_call(_, _, State) ->
    {noreply, State}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(_, State) ->
    {noreply, State}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(_Reason, Port) ->
    Port ! {self, close},
    ok.



tolower(String) ->
	io:format("//// stringprep:tolower(~s)~n", [String]),
    control(0, String).

nameprep(String) ->
	io:format("//// stringprep:nameprep(~s)~n", [String]),
    control(?NAMEPREP_COMMAND, String).

nodeprep(String) ->
	io:format("//// stringprep:nodeprep(~s)~n", [String]),
    control(?NODEPREP_COMMAND, String).

resourceprep(String) ->
	io:format("//// stringprep:resourceprep(~s)~n", [String]),
    control(?RESOURCEPREP_COMMAND, String).

control(Command, String) ->
	io:format("//// stringprep:control(~w, ~s)~n", [Command,String]),
	String.	%%XXX

%%EOF
