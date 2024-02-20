clc 
clear all
close all

%% Create model
structuralmodel = createpde("structural","static-solid");
L = 0.1; % m
W = 5e-3; % m
H = 1e-3; % m
gm = multicuboid(L,W,[H,H],"Zoffset",[0,H]);
structuralmodel.Geometry = gm;
figure
pdegplot(structuralmodel)

figure
pdegplot(structuralmodel,"CellLabels","on")
axis([-L/2 -L/3 -W/2 W/2 0 2*H])
view([0 0])
zticks([])

figure
pdegplot(structuralmodel,"CellLabels","on")
axis([L/3 L/2 -W/2 W/2 0 2*H])
view([0 0])
zticks([])

%% Data
Ec = 137e9; % N/m^2
nuc = 0.28;
CTEc = 20.00e-6; % m/m-C
structuralProperties(structuralmodel,"Cell",1, ...
                                     "YoungsModulus",Ec, ...
                                     "PoissonsRatio",nuc, ...
                                     "CTE",CTEc);


Ei = 130e9; % N/m^2
nui = 0.354;
CTEi = 1.2e-6; % m/m-C
structuralProperties(structuralmodel,"Cell",2, ...
                                     "YoungsModulus",Ei, ...
                                     "PoissonsRatio",nui, ...
                                     "CTE",CTEi);

figure
pdegplot(structuralmodel,"FaceLabels","on","FaceAlpha",0.25)
axis([-L/2 -L/3 -W/2 W/2 0 2*H])
view([60 10])
xticks([])
yticks([])
zticks([])

%% Boundary conditions - mesh - results
structuralBC(structuralmodel,"Face",[5,10],"Constraint","fixed");

structuralBodyLoad(structuralmodel,"Temperature",125);
structuralmodel.ReferenceTemperature = 25;

generateMesh(structuralmodel,"Hmax",H/2);
R = solve(structuralmodel);

figure
pdeplot3D(structuralmodel,"ColorMapData",R.Displacement.Magnitude, ...
                          "Deformation",R.Displacement, ...
                          "DeformationScaleFactor",2)
title("Deflection of Invar-Copper Beam")

%% Results comparison
K1 = 14 + (Ec/Ei)+ (Ei/Ec);
deflectionAnalytical = 3*(CTEc - CTEi)*100*2*H*L^2/(H^2*K1);

PDEToobox_Deflection = max(R.Displacement.uz);
percentError = 100*(PDEToobox_Deflection - ...
                    deflectionAnalytical)/PDEToobox_Deflection;

bimetallicResults = table(PDEToobox_Deflection, ...
                          deflectionAnalytical,percentError);
bimetallicResults.Properties.VariableNames = {'PDEToolbox', ...
                                              'Analytical', ...
                                              'PercentageError'};
disp(bimetallicResults)
