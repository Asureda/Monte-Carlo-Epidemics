#!/bin/bash

targetFile=$1
temp=$1
if [ -f  ./$targetFile ]; then
        echo 'Beguinning the production runs'
        echo 'lambda  = 0.05'
        echo 'lambda   = 3.0'
        echo 'deltalambda = 0.1'
else
        echo 'The target input file does not exist:'
        echo 'Please, select a valid one.'
        echo 'EXITING PROGRAM'
        exit
fi
cd ..
cd PROGRAM/

cp r_main ../

cd ..
mv r_main production_runs
cd production_runs

lambda="0.05"
while [ $lambda != "3.55" ]; do
        echo 'BEGUINNING PRDUCTION RUN AT lambda = '$lambda
	
        mkdir 'production_'$lambda
        cp r_main 'production_'$lambda/
	cp input.dat 'production_'$lambda/
        cd 'production_'$lambda
        cp ../$targetFile $temp
        sed -i 's/lamb/'$lambda'/g' $temp
        ./r_main $temp

        cd ..
        echo 'RUN FINISHED'

        lambda=$(echo $lambda" + 0.1" | bc)
done

echo 'EXITING PROGRAM: EVERYTHING CORRECT!'


