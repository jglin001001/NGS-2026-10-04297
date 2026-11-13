#! /bin/csh

foreach file ( pulse.P.h.am pulse.P.m.am pulse.P.l.am pulse.S.h.am pulse.S.m.am pulse.S.l.am )
set alpha_file=$file".alpha"
sac2000 <<EOF
r $file
w alpha $alpha_file
quit
EOF

awk '{if(NR == 1) print $1}' $alpha_file > tempin1
awk '{if(NR >= 31) print $0}' $alpha_file > tempin2

octave<<EOF
[fin1, msg]=fopen("tempin1", "r");
[fin2, msg]=fopen("tempin2", "r");
[fout, msg]=fopen("tempout", "w");
[dt, ndt]=fscanf(fin1, "%f");
[data, ndata]=fscanf(fin2, "%f");
bt=0;
fprintf(fout, "%8d%10.5f%10.5f\n", ndata, bt, dt);
fprintf(fout, "%e\n", data);
fclose(fin1);
fclose(fin2);
fclose(fout);
EOF

set asc_file=$file".asc"
/bin/mv tempout $asc_file
/bin/rm tempin1 tempin2

awk '{if(NR == 1) print $0}' $asc_file > temp1
awk '{if(NR > 1) print $0}' $asc_file > temp2

matlab -nojvm <<EOF
aa=load('temp1');
bb=load('temp2');
dt=aa(3);
x=[1:length(bb)]';
xx=x*dt;
plot(xx,bb);
print -depsc temp.eps
EOF
/bin/mv temp.eps $asc_file".eps"
/bin/rm temp1 temp2

end
