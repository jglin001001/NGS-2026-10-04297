clear all

fnm_inv_blk='SOD.55x33x31.nc'
mx=55;my=33;mz=31;
nblk=mx*my*mz;

fnm_smooth1th=[fnm_inv_blk(1:numel(fnm_inv_blk)-2) 'smooth1th.dat']
max_bd=4;
max_row=(mx-1)*(my-1)*(mz-1);
max_nel=max_bd*max_row;

fid=fopen(fnm_smooth1th,'w');
fprintf(fid,'%i %i %i %i\n',nblk,max_row,max_bd,max_nel)

n=0;
for k=2:mz
for j=2:my
for i=2:mx
    
    n=n+1;
    P=[i   j   k-1 ;
       i   j-1 k   ;
       i-1 j   k   ;
       i   j   k  ];
    indx=(P(:,3)-1)*mx*my+(P(:,2)-1)*mx+P(:,1);
    weig=[-1;
          -1;
          -1;
           3];
    fprintf(fid,'%i  %i %i %i %i   %3.1f %3.1f %3.1f %3.1f\n', ...
           max_bd,indx,weig);
end
end
end
fclose(fid)

fnm_smooth2th=[fnm_inv_blk(1:numel(fnm_inv_blk)-2) 'smooth2th.dat']
max_bd=7;
max_row=(mx-2)*(my-2)*(mz-1);
max_nel=max_bd*max_row;
fid=fopen(fnm_smooth2th,'w');
fprintf(fid,'%i %i %i %i\n',nblk,max_row,max_bd,max_nel)

n=0;
for k=2:mz-1
    
for j=2:my-1
for i=2:mx-1
    
    n=n+1;
    P=[i   j   k-1 ;
       i   j-1 k   ;
       i-1 j   k   ;
       i   j   k   ;
       i+1 j   k   ;
       i   j+1 k   ;
       i   j   k+1];
    indx=(P(:,3)-1)*mx*my+(P(:,2)-1)*mx+P(:,1);
    weig=[ 1;
           1;
           1;
          -6;
           1;
           1;
           1];
    fprintf(fid,'%i  %i %i %i %i %i %i %i   %3.1f %3.1f %3.1f %3.1f %3.1f %3.1f %3.1f\n', ...
           max_bd,indx,weig);
end
end
end

cur_bd=6;
for k=mz
    k
for j=2:my-1
for i=2:mx-1
    
    n=n+1;
    P=[i   j   k-1 ;
       i   j-1 k   ;
       i-1 j   k   ;
       i   j   k   ;
       i+1 j   k   ;
       i   j+1 k];
    indx=(P(:,3)-1)*mx*my+(P(:,2)-1)*mx+P(:,1);
    weig=[-1;
           1;
           1;
          -3;
           1;
           1];
    fprintf(fid,'%i  %i %i %i %i %i %i   %3.1f %3.1f %3.1f %3.1f %3.1f %3.1f\n', ...
           cur_bd,indx,weig);
end
end
end
fclose(fid)
