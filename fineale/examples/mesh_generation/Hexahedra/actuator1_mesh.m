% Make mesh of a thermally activated actuator.
function [fens,fes] =actuator1_mesh
    x0= 0;
    x1=x0+5e-6;
    x2=x1+10e-6;
    x3=x2+10e-6;
    x4=x3+10e-6;
    y0=0;
    y4=250e-6;
    y3=y4-10e-6;
    y2=y3-10e-6;
    y1=y2-10e-6;
    t=2e-6;
    h=0.1e-6;
    z0=0;
    z3=2*t+h;
    z2=z3-t;
    z1=z2-h;
    m1=2;
    m2=2;
    m3=2;
    m4=3;
    n1=20;
    n2=4;
    n3=2;
    n4=2;
    n5=7;
    p1=1;
    p2=1;
    p3=1;
    kappa=157*eye(3, 3); % W, conductivity matrix
    DV=5;% voltage drop in volt
    l =2*(y1+y2)/2+2*(x1+x2)/2;% length of the conductor
    resistivity = 1.1e-5;% Ohm m
    Q=DV^2/resistivity/l^2;% rate of Joule heating, W/m^3
    T_substrate=293;% substrate temperature in degrees Kelvin
    
    [fens,fes] = H8_hexahedron([x1,y0,z0;x2,y1,z1],m2,n1,p1);
    [fens1,fes1] = H8_hexahedron([x1,y1,z0;x2,y2,z1],m2,n2,p1);
    [fens,fes1,fes2] = merge_meshes(fens1, fes1, fens, fes, eps);
    fes= cat(fes1,fes2);
    [fens1,fes1] = H8_hexahedron([x0,y1,z0;x1,y2,z1],m1,n2,p1);
    [fens,fes1,fes2] = merge_meshes(fens1, fes1, fens, fes, eps);
    fes= cat(fes1,fes2);
    [fens1,fes1] = H8_hexahedron([x0,y1,z1;x1,y2,z2],m1,n2,p2);
    [fens,fes1,fes2] = merge_meshes(fens1, fes1, fens, fes, eps);
    fes= cat(fes1,fes2);
    [fens1,fes1] = H8_hexahedron([x0,y1,z2;x1,y2,z3],m1,n2,p3);
    [fens,fes1,fes2] = merge_meshes(fens1, fes1, fens, fes, eps);
    fes= cat(fes1,fes2);
    [fens1,fes1] = H8_hexahedron([x0,y2,z2;x1,y3,z3],m1,n3,p3);
    [fens,fes1,fes2] = merge_meshes(fens1, fes1, fens, fes, eps);
    fes= cat(fes1,fes2);
    [fens1,fes1] = H8_hexahedron([x0,y3,z2;x1,y4,z3],m1,n4,p3);
    [fens,fes1,fes2] = merge_meshes(fens1, fes1, fens, fes, eps);
    fes= cat(fes1,fes2);
    [fens1,fes1] = H8_hexahedron([x1,y3,z2;x3,y4,z3],m4,n4,p3);
    [fens,fes1,fes2] = merge_meshes(fens1, fes1, fens, fes, eps);
    fes= cat(fes1,fes2);
    [fens1,fes1] = H8_hexahedron([x3,y3,z2;x4,y4,z3],m3,n4,p3);
    [fens,fes1,fes2] = merge_meshes(fens1, fes1, fens, fes, eps);
    fes= cat(fes1,fes2);
    [fens1,fes1] = H8_hexahedron([x3,y0,z2;x4,y3,z3],m3,n5,p3);
    [fens,fes1,fes2] = merge_meshes(fens1, fes1, fens, fes, eps);
    fes= cat(fes1,fes2);
    % gv=drawmesh({fens,fes},'fes','facecolor','red');
    [fens,fes] = H8_to_H20(fens,fes);
    
end