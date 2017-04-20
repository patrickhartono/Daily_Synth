
///////////////////////////////////////////////
//////        moog_wanna_be           /////////
///////////////////////////////////////////////

/////by: Patrick Hartono////////
//www.patrickhartono.com////////

Be careful with sound volumes, uperhaps use StageLimiter
included in the BatLib Quark, activate and it will limit the
sound output.


StageLimiter.activate;

s.quit;

(
SynthDef.new(\moog_wanna_be, {

	|noiseHz= 8, noiseHz_2= 20, out= 0, amp= 0.75, atk= 0.01, sus= 0.5, rel= 3.35, gain=2.1|

	var freq_1, freq_2, osc, sig, env, shape, pan;

	shape= Env([0, 1, 1, 0], [atk, sus, rel]);

	env= EnvGen.kr(shape, doneAction:2);

	freq_1= LFNoise0.ar(noiseHz).exprange(50.0, 350.0);

	freq_2= LFNoise0.ar(noiseHz_2).exprange(100.0, 10000.0);

	osc= Saw.ar(freq_1, 0.75);

	sig= MoogFF.ar(osc, freq_2, gain, 0, amp);

	pan= LFNoise0.kr(rrand(-1.0, 1.0));

	sig= Pan2.ar(sig, pan, 1);

	sig = sig * env;

	Out.ar(out, sig);

}).add;


Pbind(\instrument, \moog_wanna_be,
	\noiseHz, Pwhite(0.5, 8.5, inf),
	\noiseHz_2, Prand([20.1, 10.1, 5.5, 8.0, 1, 20.0], inf),
	\gain, Pwhite(1.5, 3.5, inf),
	\dur, 3.8,
	\amp, 2.5,

).play;
)

