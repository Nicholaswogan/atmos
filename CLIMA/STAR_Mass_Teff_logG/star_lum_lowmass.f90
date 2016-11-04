!-----------------------------------------------------------
!         TableCurve FORTRAN F90 Code Output
!    To modify generated output, edit FORT90.TCL
!-----------------------------------------------------------

PROGRAM main
  REAL*8 x,y,teff

  open(9,file='teff_lum_lowmass.dat')
  teff=2600.0d0
  do while(teff <=6201.0)
    x = teff
    y=eqn7919(x)
     write(9,*)x,10.**y
    PRINT *,x,10.**y
    teff = teff + 200.0d0
  enddo
  close(9)

20 END
  
!-----------------------------------------------------------
REAL*8 FUNCTION eqn7919(x)
!-----------------------------------------------------------
! TableCurve C:\Users\winey-akka\Desktop\star_lum_lowmass.f90 Oct 22, 2012 11:01:25 AM 
! C:\Users\winey-akka\Desktop\combined_lum_lowmass.dat 
! X= 1.77100E+03 
! Y= -4.17250E+00 
! Eqn# 7919  y=(a+clnx+e(lnx)^2+g(lnx)^3+i(lnx)^4+k(lnx)^5)/(1+blnx+d(lnx)^2+f(lnx)^3+h(lnx)^4+j(lnx)^5) [NL] 
! r2=0.9999019152933411D0 
! r2adj=0.9998889161153502D0 
! StdErr=0.01136273263575264D0 
! Fval=85631.86223999389D0 
! a= -4.468813328699894D0 
! b= -0.595549651627361D0 
! c= 2.622353375987782D0 
! d= 0.1420897959549706D0 
! e= -0.6157169875070289D0 
! f= -0.01697595870188344D0 
! g= 0.07230875924115728D0 
! h= 0.001015579649762715D0 
! i= -0.004247564652203148D0 
! j= -2.433691371193272D-05 
! k= 9.98477288455783D-05 
!-----------------------------------------------------------
  REAL*8 x,y,x1
  x1 = x
  x=DLOG(x) 
  y=(-4.468813328699894D0+x*(2.622353375987782D0+&
   &x*(-0.6157169875070289D0+x*(0.07230875924115728D0+&
   &x*(-0.004247564652203148D0+x*(9.984772884557830D-05))))))/&
   &(1.0+x*(-0.5955496516273610D0+x*(0.1420897959549706D0+&
   &x*(-0.01697595870188344D0+x*(0.001015579649762715D0+&
   &x*(-2.433691371193272D-05)))))) 
  x = x1
  eqn7919=y
  RETURN
END
  
