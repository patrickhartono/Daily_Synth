///////////////////////////////////////////////
//////        Additive_Feedback       /////////
///////////////////////////////////////////////

/////by: Patrick Hartono////////
//www.patrickhartono.com////////

Be careful with sound volumes, uperhaps use StageLimiter
included in the BatLib Quark, activate and it will limit the
sound output.

StageLimiter.activate


//To instal Quarks mathlib
Quarks.install("MathLib");


(

SynthDef(\add_fdk, {
	|out= 0, amp= 0.1, atk= 0.05, sus= 1.0, rel= 1.0, freq= 10, mix= 1, room= 0.5, damp= 0.5, freq2= 200, maxdel= 0.5, deltime= 1|

	var env, osc, pan, shape, spat, reverb, delay, sum;

	sum= 0;



	shape= Env([0, 1, 1, 0], [atk, sus, rel]);
	env= EnvGen.kr(shape, doneAction:2);

	10.do{
		osc= SinOscFB.ar(Rand(0,
			freq),
		LFNoise0.kr(0.1,
			freq2)) * env;

		sum= sum + osc;
	};

	sum= sum * 0.2;


	delay= AllpassC.ar(sum, maxdel, deltime, 1, 0.5);
	reverb= FreeVerb2.ar(delay, sum, mix, room, damp, 0.5);

	spat= LFNoise0.kr([-1, 1]);

	reverb= reverb * 0.4;

	Out.ar(spat, reverb);

}).add;



m = MarkovSetN(
			[ [[ 0 ], 	[ 5, 50 ], 	[ 0.9, 0.1 ]],
				[[ 11 ], 	[ 50 ], 			[ 1 ]],
				[[ 10 ], 	[ 5, 50 ], 	[ 0.9, 0.1 ]],
		[[ 11 ], 	[ 50 ],  [ 1 ]]
			], 1);

m.makeSeeds;

Pbind(\instrument, \add_fdk,
	\freq, Pwhite(0.5, 10, inf),
	\freq2, Prand([9000, 10000, 5000, 4000, 10000, 3500, 5000], inf),
	//\freq, m,
	\atk, Prand([1, 0.1, 0.05, 2], inf),
	\maxdel, Pseq([0.1, 0.1, 1, 0.01, 0.5, 0.75], inf),
	\deltime, Pwhite(0.1, 0.75, inf),
	\mix, Pwhite(0, 0.5, inf),
	\room, Pwhite(0.1, 0.5, inf),
	\damp, Pwhite(0, 0.5, inf),
	\dur, Prand([0.25, 0.1, 0.5], inf),
	\amp, 0.25,
).play;

)


