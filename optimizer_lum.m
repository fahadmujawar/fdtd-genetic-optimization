function y=optimizer_lum(si_height,si_breadth,r_water,r_out,r_in,gap,rect_width,lam,thetaa,x_per,h)

%Modify fiber position, theta, duty cycle, pitch and run the
%simulation
code=strcat('switchtolayout;',...
'select("structure_group");',...
'set("si_height",',num2str(si_height*1e-9,16),');',...
'set("si_breadth",',num2str(si_breadth*1e-9,16),');',...
'set("r_water",',num2str(r_water*1e-9,16),');',...
'set("r_out",',num2str(r_out*1e-9,16),');',...
'set("r_in",',num2str(r_in*1e-9,16),');',...
'set("gap",',num2str(gap*1e-9,16),');',...
'set("rect_width",',num2str(rect_width*1e-9,16),');',...
'select("source");',...
'set("wavelength start",',num2str(lam*1e-9,16),');',...
'set("wavelength stop",',num2str(lam*1e-9,16),');',...
'set("polarization angle",',num2str(thetaa,16),');',...
'select("monitor_2");',...
'set("z",',num2str(si_height*1e-9/2,16),');',...
'select("monitor_3");',...
'set("z",',num2str(si_height*1e-9/2,16),');',...
'select("FDTD");',...
'set("x span",',num2str(x_per*1e-9,16),');',...
'set("y span",',num2str(x_per*1e-9,16),');',...
'run;');
appevalscript(h,code);

%Get the coupled power from T monitor to
%FDTD workspace as variable 'T_avg_FDTD'
code=strcat('Exx= getresult("monitor_2","E");EE1=Exx.E2;');
appevalscript(h,code);
EE1=appgetvar(h,'EE1');

code=strcat('xx= getresult("monitor_2","x");');
appevalscript(h,code);
xx=appgetvar(h,'xx');
indexx=1:length(xx);
KK=islocalmax(EE1);
KK1=islocalmin(EE1);
t1=sum(KK);
if t1<=5
    peak_value_list=EE1(KK);
    peak_position_list=xx(KK);
    peak_index_list=indexx(KK);
    mid_value=(t1+1)/2;
    peak_value=peak_value_list(mid_value);
    peak_position=peak_position_list(mid_value);
    peak_index=peak_index_list(mid_value);
    dip_index_list=indexx(KK1);
    next_peak_index=peak_index_list(mid_value+1);
    tyu=dip_index_list<next_peak_index & dip_index_list>peak_index;
    min_index=dip_index_list(tyu);
    e_val=EE1(peak_index:min_index);
    x_valu=xx(peak_index:min_index);
    fwhm_value=peak_value/2.718;
    vq1 = interp1(e_val,x_valu,fwhm_value)*1e9; 
    if isnan( vq1 )
        Lp=1000;
    else
        Lp=2*vq1;
    end
    
else
    Lp=1000;
end
%Get the average transmission(figure of merit) from FDTD workspace to
%Matlab workspace
y=Lp;


%Uncommnet this section to display the optimized parameters and
%figure of merit for each run in FDTD
%disp(strcat('x_pos= ',num2str(x_position,10),'...theta= ',num2str(theta,10),'...pitch= ',num2str(pitch,10),'...DC= ',num2str(dc,10)));
%disp(strcat('1-abs(T)= ',num2str(y,10)));
end