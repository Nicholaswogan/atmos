#!/bin/bash

temp_path='PHOTOCHEM/INPUTFILES/TEMPLATES/'
temp_path2='CLIMA/IO/TEMPLATES/'
temp_path3='CLIMA/IO/'

clear
echo "This script imports PHOTOCHEM & CLIMA templates from a template file."
echo "You will need to be in your top folder for atmos, not a subfolder."
echo "Your current folder is $(pwd)."
true_path=$(pwd)
echo -n "Enter the folder title (NOT THE PATH) and press [ENTER]: "
read folder

folder_path=$temp_path$folder
folder_path2=$temp_path2$folder

cd $folder_path
cp 'in.dist' '../../..' && echo "Copied in.dist to $(pwd ../../..)"
cp 'input_photchem.dat' '../..' && echo "Copied input_photchem.dat to $(pwd ../..)"
cp 'ISOreactions.rx' '../..' && echo "Copied ISOreactions.rx to $(pwd ../..)"
cp 'reactions.rx' '../..' && echo "Copied reactions.rx to $(pwd ../..)"
cp 'parameters.inc' '../..' && echo "Copied parameters.inc to $(pwd ../..)"
cp 'species.dat' '../..' && echo "Copied species.dat to $(pwd ../..)"
cp 'PLANET.dat' '../..' && echo "Copied PLANET.dat to $(pwd ../..)"
cp 'ISOparameters.inc' '../..' && echo "Copied ISOparameters.inc to $(pwd ../..)"
cp 'parametersREGULAR.inc' '../..' && echo "Copied parametersREGULAR.in to $(pwd ../..)"
echo 'Finished copying photochem templates over'
cd $true_path
pwd


echo -n 'Would you like to run PHOTOCHEM (y/n)? '
read run_photo
if [ "$run_photo" == "y" -o "$run_photo" == 'Y' ]
   then
       echo -n 'Would you like to recompile the model? (y/n?)'
       read recompile
       if [ "$recompile" == "y" -o "$recompile" == 'Y' ]
       then
	   make '-f' 'makefilePhotochem' 'clean'
	   make '-f' 'makefilePhotochem'
       fi
  ./'TOTCdev'
fi

echo -n 'Would you like to run CLIMA (coupled to PHOTO) (y/n)? '
read run_clima
if [ "$run_clima" == "y" -o "$run_clima" == 'Y' ]
then
    cd $true_path
    echo "folder path is $folder_path2"
    if [ -d "$folder_path2" ]; then
	cd $folder_path2
	echo "folder path is now $(pwd)"
	cp 'input_clima.dat' '../..' && echo "Copied input_clima.dat from $(pwd)"
    fi
        cd $true_path
    if [ ! -d "$folder_path2" ]; then
	echo "folder path is now $(pwd)"
	cd $temp_path3
	echo "!!WARNING!!: no clima template exists for $folder. Copying GENERIC version."
	echo "This may cause problems for you. Check the file manually to see if you want the options set in it."
	cp 'DEFAULT_input_clima.dat' 'input_clima.dat' && echo "Copied GENERIC input_clima.dat to  $(pwd ../..)"
    fi
    #cp 'mixing_ratios.dat' '../../../../COUPLE/' && echo "Copied mixing_ratios.dat $(pwd ../../../../COUPLE/)"
    #cp 'mixing_ratios.dat' '../..' && echo "Copied mixing_ratios.dat $(pwd ../..)"
    #cp 'time_frak_photo.out' '../../../../COUPLE/' && echo "Copied time_frak_photo.out to $(pwd ../../../../COUPLE/)"
    #cp 'hcaer.photoout.out' '../../../../COUPLE/' && echo "Copied hcaer.photoout.out to $(pwd ../../../../COUPLE/)"
    echo 'Finished copying clima templates over'
    cd $true_path
    pwd
       echo -n 'Would you like to recompile the model? (y/n?)'
       read recompile
       if [ "$recompile" == "y" -o "$recompile" == 'Y' ]
       then
	   make '-f' 'makefileClima' 'clean'
	   make '-f' 'makefileClima'
       fi
  ./'runclima'
fi
