#! /bin/csh

/bin/rm pulse.*
/bin/rm *.am *.ph

#### FOR P WAVE
sac<<EOF
funcgen impulse npts 5001 delta 0.05 begin 0
ppk bell off
bp bu co 0.5 2.0 n 4 p 2
rmean;rtr;taper
ppk bell off
fft
writesp pulse.0.5-2.0Hz
writesp pulse.P.h
quit
EOF

sac<<EOF
funcgen impulse npts 5001 delta 0.05 begin 0
ppk bell off
bp bu co 0.1 0.5 n 4 p 2
rmean;rtr;taper
ppk bell off
fft
writesp pulse.0.1-0.5Hz
writesp pulse.P.m
quit
EOF

sac<<EOF
funcgen impulse npts 6001 delta 0.05 begin 0
ppk bell off
bp bu co 0.03 0.1 n 4 p 2
rmean;rtr;taper
ppk bell off
fft
writesp pulse.0.03-0.1Hz
writesp pulse.P.l
quit
EOF

#### FOR S WAVE
sac<<EOF
funcgen impulse npts 5001 delta 0.05 begin 0
ppk bell off
bp bu co 0.1 0.5 n 4 p 2
rmean;rtr;taper
ppk bell off
fft
writesp pulse.0.1-0.5Hz
writesp pulse.S.h
quit
EOF

sac<<EOF
funcgen impulse npts 5001 delta 0.05 begin 0
ppk bell off
bp bu co 0.05 0.1 n 4 p 2
rmean;rtr;taper
ppk bell off
fft
writesp pulse.0.05-0.1Hz
writesp pulse.S.m
quit
EOF

sac<<EOF
funcgen impulse npts 6001 delta 0.05 begin 0
ppk bell off
bp bu co 0.02 0.05 n 4 p 2
rmean;rtr;taper
ppk bell off
fft
writesp pulse.0.02-0.05Hz
writesp pulse.S.l
quit
EOF
