module db.lua;

import fuji.dbg;

import luad.all;

LuaState initLua()
{
	LuaState lua = new LuaState;
	lua.openLibs();

	lua["print"] = &luaPrint;
	lua["error"] = &luaError;
	lua["warn"] = &luaWarn;
	lua["log"] = &luaLog;

	return lua;
}

private:
extern(C) void luaPrint(LuaObject[] params...)
{
	string msg;
	if(params.length > 0)
	{
		foreach(param; params[0..$-1])
			msg ~= param.toString() ~ '\t';
		msg ~= params[$-1].toString();
	}
	MFDebug_Message(msg);
}

extern(C) void luaError(LuaObject[] params...)
{
	string msg;
	if(params.length > 0)
	{
		foreach(param; params[0..$-1])
			msg ~= param.toString() ~ '\t';
		msg ~= params[$-1].toString();
	}
	MFDebug_Error(msg);
}

extern(C) void luaWarn(int level, LuaObject[] params...)
{
	string msg;
	if(params.length > 0)
	{
		foreach(param; params[0..$-1])
			msg ~= param.toString() ~ '\t';
		msg ~= params[$-1].toString();
	}
	MFDebug_Warn(level, msg);
}

extern(C) void luaLog(int level, LuaObject[] params...)
{
	string msg;
	if(params.length > 0)
	{
		foreach(param; params[0..$-1])
			msg ~= param.toString() ~ '\t';
		msg ~= params[$-1].toString();
	}
	MFDebug_Log(level, msg);
}
