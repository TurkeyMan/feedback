module db.sequence;

import db.instrument;


enum Part
{
	Unknown,		// if the instrument type is unknown, or has not been assigned

	LeadGuitar,		// lead guiutar
	RhythmGuitar,	// rhythm guitar
	Bass,			// bass guitar
	Drums,			// drums
	Vox,			// lead vocals
	Vox2,			// secondary/backing vocals
	Keys,			// keyboard
	ProGuitar,		// pro guitar
	ProDrums,		// pro drums
	DJ,				// DJ hero

	// Bemani games
	Dance,			// dance mat
	DanceDouble,	// double dance mat
	DanceSolo,		// dance mat
	Pump,			// pump it up
	Beatmania,		// beatmania controller

	// Silly (fun!) shit
	Conga,			// ie, Donkey Conga
	Taiko,			// http://www.screwattack.com/sites/default/files/image/images/News/2012/0402/261_560635649740_23911393_36125747_3873_n.jpg

	Count
}

enum EventType
{
	Unknown,

	BPM,
	Anchor,
	TimeSignature,

	Note,
	Special,		// special sections
	Event,			// text events
	Lyric,			// lyrics
	Section,		// song section names
	Lighting,		// lighting events
	DirectedCut,	// directed camera cut
	MIDI,			// raw midi event (for stuff we haven't decoded yet)
}

enum SpecialType
{
	StarPower,
	Overdrive,
	FreeStyle,
	Solo,			// RB solo keys
	Slide,			// GH4 slider
	LeftPlayer,		// GH1/2 co-op mode
	RightPlayer		// GH1/2 co-op mode
}

struct Event
{
	long time;		// the physical time of the note (in microseconds)

	int tick;		// in ticks
	int duration;	// note duration

	EventType event;

	struct BPM
	{
		int usPerBeat;
	}
	struct TimeSig
	{
		int numerator;
		int denominator;
	}
	struct Note
	{
		int key;
		uint flags;
	}
	struct MIDI
	{
		ubyte type;
		ubyte subType;
		ubyte channel;
		int note;
		int velocity;
	}

	union
	{
		BPM bpm;
		TimeSig ts;
		Note note;
		SpecialType special;
		MIDI midi;
		string text;
	}
}

class Sequence
{
	Part part;

	string variation;
	string difficulty;
	int difficultyMeter;	// from 1 - 10

	Event[] notes;

	// instrument specific parameters
	int numDoubleKicks; // keep a counter so we know if the drums have double kicks or not
}

immutable InstrumentType[Part.Count] instrumentForPart =
[
	InstrumentType.Unknown,				// Unknown
	InstrumentType.GuitarController,	// LeadGuitar
	InstrumentType.GuitarController,	// RhythmGuitar
	InstrumentType.GuitarController,	// Bass
	InstrumentType.Drums,				// Drums
	InstrumentType.Vocals,				// Vox
	InstrumentType.Vocals,				// Vox2
	InstrumentType.Keyboard,			// Keys
	InstrumentType.Guitar,				// ProGuitar
	InstrumentType.DJ,					// DJ
	InstrumentType.Dance,				// Dance
	InstrumentType.Dance,				// DanceDouble
	InstrumentType.Dance,				// DanceSolo
	InstrumentType.Dance,				// Pump
	InstrumentType.Beatmania,			// Beatmania
	InstrumentType.Conga,				// Conga
	InstrumentType.Taiko				// Taiko
];

template instrumentFor(Part part)		{ enum instrumentOf = instrumentForPart[part]; }
