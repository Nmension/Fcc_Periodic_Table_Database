#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
#called $1 as INPUT and INPUT_LENGTH for better readability
INPUT=$1
INPUT_LENGTH=${#INPUT}

#Check if the Inputed argument is not empty, proceed
if [[ ! -z $1 ]]
then

  #check if $INPUT is a number
  if [[ $INPUT =~ ^[0-9]+$ ]]
  #then save the query for the database for the inputed atomic_number and its associated info in a var
  then
  #check if the var is empty, so the atomic_number doesn't exist > echo an according message
    ELEMENT_INFO=$($PSQL "SELECT name, atomic_number, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$INPUT;")

    #if not found > echo according message
    if [[ -z $ELEMENT_INFO ]]
    then
      echo "I could not find that element in the database."

    #else return its associated info through a formatted message
    else
      echo $ELEMENT_INFO | while read NAME BAR ATOMIC_NUMBER BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_P BAR BOILING_P
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_P celsius and a boiling point of $BOILING_P celsius."
      done
    fi


  #elif, check if input is a string
  elif [[  $INPUT  =~ ^[a-zA-Z]*$ ]] 
  then
    #if so, check string input length for 1 or 2 
    if [[ $INPUT_LENGTH == 1 || $INPUT_LENGTH == 2 ]]
    #then save the query for the database for the inputed symbol and its associated info in a var
    then
      ELEMENT_INFO=$($PSQL "SELECT name, atomic_number, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$INPUT';")

      #check if the var is empty, so the symbol doesn't exist > echo an according message
      if [[ -z $ELEMENT_INFO ]]
      then
        #if not found > echo according message
        echo "I could not find that element in the database."

      else
        #else return its associated info through a formatted message
        echo $ELEMENT_INFO | while read NAME BAR ATOMIC_NUMBER BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_P BAR BOILING_P
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_P celsius and a boiling point of $BOILING_P celsius."
        done
      fi

    #check for string input length being greater than 2 
    elif [[ $INPUT_LENGTH -gt 2 ]]
    #then save the query for the database for the inputed element's name and its associated info in a var
    then
      ELEMENT_INFO=$($PSQL "SELECT name, atomic_number, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$INPUT';")

      #check if the var is empty, so the name doesn't exist > echo an according message
      if [[ -z $ELEMENT_INFO ]]
      then
        #if not found > echo according message
        echo "I could not find that element in the database."
        
      else
         #else return its associated info through a formatted message
        echo $ELEMENT_INFO | while read NAME BAR ATOMIC_NUMBER BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_P BAR BOILING_P
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_P celsius and a boiling point of $BOILING_P celsius."
        done
      fi
    fi
  fi
#if the Inputed argument is empty > echo according message
else
  echo "Please provide an element as an argument."
fi



  