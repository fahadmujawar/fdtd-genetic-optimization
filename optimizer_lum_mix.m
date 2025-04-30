function yy=optimizer_lum_mix(si_height,si_breadth,r_water,r_out,r_in,gap,rect_width,x_per,h)
con1=si_breadth-x_per;
con2=r_out-r_water;
con3=r_in-r_out;
lam=600;
si_height=300;
if con1<-20 && con2<-50 && con3<-50
y1=optimizer_lum(si_height,si_breadth,r_water,r_out,r_in,gap,rect_width,lam,0,x_per,h);
y2=optimizer_lum(si_height,si_breadth,r_water,r_out,r_in,gap,rect_width,lam,90,x_per,h);
yy=min(y1,y2);
else
    yy=1000;
end
yy
if yy<1000
    fid=fopen('results.txt','a');
    if fid~=-1
        fprintf(fid, '%d  %d  %d  %d  %d  %d  %d  %d  %d\n',si_height,si_breadth,r_water,r_out,r_in,gap,rect_width,x_per,yy);
        fclose(fid);
    end
end
end