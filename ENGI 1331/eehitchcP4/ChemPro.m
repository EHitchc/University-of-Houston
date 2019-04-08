function [ nr, np, fov ] = ChemPro( XI0, fsp, yp )
    %Solves for nr, np and fov
    n2=XI0./yp;
    n1=(1+n2.*(1-yp)-n2)./(4-4.*(1-yp).*(1-fsp));
    
    nr=4.*n1+n2;
    
    np=2.*fsp.*n1;
    
    fov=((1-XI0)./4-yp.*(1-fsp).*n1)./((1-XI0)./4);
end

