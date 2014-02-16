module db.i.scorekeeper;

import db.i.inputdevice;
import db.i.syncsource;
import db.sequence;

import std.signals;

abstract class ScoreKeeper
{
	this(Sequence sequence, InputDevice input)
	{
		this.sequence = sequence;
		this.inputDevice = input;
	}

	void Begin(SyncSource sync)
	{
		inputDevice.Begin(sync);
	}

	void Update();

	@property long averageError() { return numErrorSamples ? cumulativeError / numErrorSamples : 0; }

	Sequence sequence;
	InputDevice inputDevice;

	long cumulativeError;
	int numErrorSamples;

	long window = 200; // in milliseconds

	// shared
	mixin Signal!(int, long) noteHit;	// (note, precision) precision is microseconds from the precise note time
	mixin Signal!(int) noteMiss;		// (note)
	mixin Signal!(int) badNote;			// (note)
	mixin Signal!(int) trigger;			// (trigger type)
}