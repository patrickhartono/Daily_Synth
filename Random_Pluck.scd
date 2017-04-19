///////////////////////////////////////////////
//////        Random_'Pluck'          /////////
///////////////////////////////////////////////

/////by: Patrick Hartono////////
//www.patrickhartono.com////////

Be careful with sound volumes, uperhaps use StageLimiter
included in the BatLib Quark, activate and it will limit the
sound output.


///WATCH OUT! VERY NOISY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

StageLimiter.activate;

(

SynthDef(\random_pluck, {

	|out=1, amp= 0.2, freq= 2, maxdel= 0.002, deltime= 0.001, dectime= 1,
	 trig= 0.02, coef= 0.5|

	var sig, shape, osc, reverb, env, pan;

	shape= Env([0.01,1,0.3,0.01],[1,0.5,1], \sine);

	env= EnvGen.ar(shape, doneAction:2);

	osc= Pluck.ar(ClipNoise.ar(amp), trig , maxdel, deltime, dectime, coef:coef);

	
	reverb= FreeVerb.ar(osc, 0.5, 1, 0.75, 1);
	
	sig = LeakDC.ar(reverb, 0.9, 0.75);
	
	pan= LFNoise1.ar(rrand(-1, 1));
	
	sig = Pan2.ar(sig, pan, 0.5);
	
	Out.ar(0, sig);

}).add;


Pbind(\instrument, \random_pluck,
	\amp, Prand([0.5, 0.25, 0.3, 2, 1, 1.5], inf),
	\coef, Pwhite(-0.9, 0.9, inf),
	\deltime, Prand([0.001, 0.002, 0.09, 0.009, 0.01], inf),
	\maxdel, Prand([0.001, 0.002, 0.09, 0.009, 0.01], inf),
	\dectime, Pwhite(0.1, 1.5, inf),
	\dur, Pgbrown(0.9, 2.5, rrand(0.125, 1), inf),
).play;

)
