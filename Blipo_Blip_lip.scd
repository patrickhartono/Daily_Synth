///////////////////////////////////////////////
//////        Blipo_Blip_lip          /////////
///////////////////////////////////////////////

/////by: Patrick Hartono////////
//www.patrickhartono.com////////

Be careful with sound volumes, uperhaps use StageLimiter
included in the BatLib Quark, activate and it will limit the
sound output.


///WATCH OUT! VERY NOISY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

StageLimiter.activate;




(

SynthDef.new(\Blipo_Blip_lip, {

	|pan= 0, amp= 0.5, fedbk= 190.6, atk= 0.05, sus= 1.0, rel= 1.0|

	var sig, env, freq, trig, seq, sum, shape, reverb;

	sum= 0;

	seq= Drand([Dseq((1..5).mirror1, 16), Drand((4..10), 8)], 50) * Drand([1, 1, 3, 6,10], 10);

	shape= Env([0, 1, 1, 0], [atk, sus, rel]);

	env= EnvGen.kr(shape, doneAction:2);

	trig= Dust.kr(10);

	freq= Demand.kr(trig, 1, seq * Dwhite(0.5, 8.4, inf));

	10.do{
		sig = Blip.ar(freq,

			fedbk,
			amp);

		sum= sum + sig;

	};

	sum * 0.5;

	reverb= FreeVerb.ar(sum, 0.4, 0.5, 0.5, 1);


	sum = reverb * env;


	sum= Pan2.ar(sum, SinOsc.kr([-1, 1]));

	sum = LeakDC.ar(sum, 0.9, 0.75);

	Out.ar(0, sum);

}).add;


Pbind(\instrument, \Blipo_Blip_lip,
	\dur, Prand([3.5, 1, 0.5, 4, 0.1, 0.25], inf),

).play;

)












