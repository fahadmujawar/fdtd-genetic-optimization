clear;
%Add Lumerical Matlab API path
path(path,'C:\Program Files\Lumerical\v202\api\matlab');
sim_file_path=('C:\Users\rajat\Desktop\bhowmick_sir\optimizer1'); % update this path to user's folder
sim_file_name=('test1_b.fsp');
 
%Open FDTD session
h=appopen('fdtd');

%Pass the path variables to FDTD
appputvar(h,'sim_file_path',sim_file_path);
appputvar(h,'sim_file_name',sim_file_name);

%Load the FDTD simulation file and get simulation parameters
code=strcat('cd(sim_file_path);',...
    'load(sim_file_name);',...
    'select("structure_group");',...
    'sub_length=get("sub_length");',....
    'sub_breadth=get("sub_breadth");',....
    'sub_height=get("sub_height");',....
    'si_height=get("si_height");',....
    'si_length=get("si_length");',....
    'si_breadth=get("si_breadth");',....
    'r_water=get("r_water");',....
    'r_out=get("r_out");',....
    'r_in=get("r_in");',....
    'gap=get("gap");',...
    'rect_width=get("rect_width");',...
    'ref_pit=get("ref_pit");',...
    'select("FDTD");',...
    'x_period=get("x span");',....
    'y_period=get("y span");',....
    'select("source");',...
    'wavelength_start=get("wavelength start");',...
    'wavelength_stop=get("wavelength stop");',...
    'thetaa=get("polarization angle");');
%send the script in 'code' to Lumerical FDTD Solutions
appevalscript(h,code);

%Get variables 'FDTD_span' and 'gap' from FDTD workspace to Matlab
%workspace
%global gap
%gap=appgetvar(h,'gap');
sub_length=appgetvar(h,'sub_length');
sub_breadth=appgetvar(h,'sub_breadth');
sub_height=appgetvar(h,'sub_height');
si_height=appgetvar(h,'si_height');
si_length=appgetvar(h,'si_length');
si_breadth=appgetvar(h,'si_breadth');
r_water=appgetvar(h,'r_water');
r_in=appgetvar(h,'r_in');
gap=appgetvar(h,'gap');
rect_width=appgetvar(h,'rect_width');
r_out=appgetvar(h,'r_out');
ref_pit=appgetvar(h,'ref_pit');
x_period=appgetvar(h,'x_period');
y_period=appgetvar(h,'y_period');
wavelength_start=appgetvar(h,'wavelength_start');
wavelength_stop=appgetvar(h,'wavelength_stop');
thetaa=appgetvar(h,'thetaa');

%Function to be optimized x(x_position,theta,pitch,dc)
f=@(x,y)optimizer_lum_mix(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),h);


lb=[100,1000,400,300,200,20,20,1000];
ub=[300,3000,700,700,700,100,200,3000];


%rng default
nvars = 8;
opts = optimoptions(@gamultiobj,'PopulationSize',50,'MaxGenerations',25,'PlotFcn','gaplotpareto');
[xga,fvalga,~,gaoutput] = gamultiobj(f,nvars,[],[],[],[],lb,ub,[],opts);
appclose(h);