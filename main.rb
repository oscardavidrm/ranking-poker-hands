#!/usr/bin/env ruby

=begin
 RANKING POKER HANDS
 This program was developed as a challenge by MoneyPool Co.
 
 Exercise instructions
 Write a program to evaluate poker hands and determine a winner.
 Your program should accept hands in the following representation:
 
 # This is a hand with
 # an Ace of spades,
 # a King of diamonds,
 # a Ten of hearts,
 # a Jack of clubs,
 # and a Queen of hearts.
 ["AS", "KD", "TH", "JC", "QH"]
 
 # Another hand:
 ["2C", "5D", "9S", "3H", "TS"]
=end

#External file that allocates the classes used in this project.
require './lib/pokerHands'

#--------------------------------------------LIST MANIPULATION FUNCTIONS--------------------------------
######################################################################
#Separates numerical values from the input list following the fact that odd indexes in the list contain
#the value that each card contains.
def createListOfNumbers(originalHand)
    #All of these odd indexes are stored inside this NEW list of numbers
    listOfNumbers = []
    for i in 0..originalHand.length - 1
        if i % 2 == 0
            listOfNumbers.push(originalHand[i])
        end
    end
    return listOfNumbers
end

######################################################################
#The leftovers from the past filter that are not numerically represented ,but rather with a letter,
#are translated in here as numerical values to easily manipulate the new listOfNumbers.
def convertLettersToNumbers(mixedList)
    for i in 0..mixedList.length - 1
        #With this switch we ensure that no letters are leftover.
        case mixedList[i]
            when "T"
            mixedList[i] = "10"
            when "J"
            mixedList[i] = "11"
            when "Q"
            mixedList[i] = "12"
            when "K"
            mixedList[i] = "13"
            when "A"
            mixedList[i] = "14"
            else
            mixedList[i] = mixedList[i]
        end
    end
    #This sorts the list in numerical order from smaller to greater and stores it in a new variable.
    sortedList = mixedList.sort
    return sortedList
end

######################################################################
#Separates alphabetical values from the input list following the fact that even indexes in the list contain
#the suit value of each card.
def createListOfSuits(stringOfDeckOfCards)
    #All of these even indexes are stored inside this NEW list of numbers
    listOfSuits = []
    for i in 0..stringOfDeckOfCards.length - 1
        if i % 2 != 0
            listOfSuits.push(stringOfDeckOfCards[i])
        end
    end
    return listOfSuits
end

######################################################################
#The leftovers from the past filter that are not numerically represented ,but rather with a letter,
#are translated in here as numerical values to easily manipulate the new listOfSuits.
def convertSuitsToNumbers(mixedList)
    for i in 0..mixedList.length - 1
        #With this switch we ensure that no letters are leftover.
        case mixedList[i]
            when "C"
            mixedList[i] = "1"
            when "D"
            mixedList[i] = "2"
            when "H"
            mixedList[i] = "3"
            when "S"
            mixedList[i] = "4"
            else
            mixedList[i] = mixedList[i]
        end
    end
    return mixedList
end

#--------------------------------------------GAME IDENTIFIER FUNCTIONS--------------------------------
######################################################################
#This function finds flush patterns in hands to then determine if they have a flush.
#This means that all cards are of the same suits.
def checkIfFlush(suits)
    counter = 0
    for i in 0..suits.length - 1
        if suits[i + 1].to_i - suits[i].to_i == 0
            counter += 1
        end
    end
    
    if counter == 4
        return true
        else
        return false
    end
end
######################################################################
#This function finds straight patterns in hands to then determine if they have a straight game.
#Which can then lead to another good combination like a StraightFlush or even RoyalFlush.
def checkIfStraight(numbers)
    counter = 0
    for i in 0..numbers.length - 1
        if numbers[i + 1].to_i - numbers[i].to_i == 1
            counter += 1
        end
    end
    
    if counter == 4
        return true
        else
        return false
    end
end
######################################################################
#This function combines the two previous ones to build a StraightFlush Game!
def checkIfStraightFlush(numbers, suits)
    #If both conditions are met, the hand is catalogued as a StraightFlush
    if checkIfStraight(numbers) == true && checkIfFlush(suits) == true
        return true
        else
        return false
    end
end
######################################################################
#In order to satisfy this function, the hand in matter must be an StraightFlush first and have
#an Ace as its last card.
def checkIfRoyalFlush(numbers, suits)
    if checkIfStraightFlush(numbers, suits) == true && numbers[numbers.length - 1].to_i == 14
        return true
        else
        return false
    end
end
######################################################################
#As the lists that we are using were sorted before, we have the ability to find two,
#three or even four equal cards in a row. The following functions can help us find
#pairs, three of the same kind or even four of the same kind.

def checkIfFourOfAKind(numbers)
    counter = 0
    for i in 0..numbers.length - 1
        if numbers[i + 1].to_i - numbers[i].to_i == 0
            counter += 1
        end
    end
    if counter >= 3
        return true
    else
        return false
    end
end
######################################################################
def checkIfFullHouse(numbers)
    if checkIfOnePair(numbers) && checkIfThreeOfAKind(numbers)
        return true
    else
        return false
    end
end
######################################################################
def checkIfThreeOfAKind(numbers)
    counter = 0
    for i in 0..numbers.length - 1
        if numbers[i + 1].to_i - numbers[i].to_i == 0
            counter += 1
        end
    end
    
    if counter >= 2
        return true
        else
        return false
    end
end
######################################################################
def checkIfTwoPairs(numbers)
    counter = 0
    for i in 0..numbers.length
        if numbers[i + 1].to_i - numbers[i].to_i == 0
            counter += 1
        end
    end
    if counter >= 2
        return true
    else
        return false
    end
end
######################################################################
def checkIfOnePair(numbers)
    counter = 0
    for i in 0..numbers.length - 1
        if numbers[i + 1].to_i - numbers[i].to_i == 0
            counter += 1
        end
    end
    if counter >= 1
        return true
    else
        return false
    end
end
######################################################################
def checkHighCard(numbers)
    highestNumber = numbers.max.to_i
    return highestNumber
end
######################################################################
#Whoever hand wins gets input here as the argument to display their game and
#recognise them as the legitimate winner.
def winnerCongratulations(hand)
    print "Hand #{hand} won!"
end

######################################################################
#This is the execution function. Every other function that was created inside the document
#is referenced and used here to optimise the resolution time. You only have to call this huge
#function with two instances of the class PokerHands as the arguments and get the result
#back.

#--------------------------------------------FUNCTION TESTER--------------------------------
#This function tests all possible cases and classifies each hand and determines a winner
def winnerHand(hand1, hand2)
    
    firstHand = hand1.orderAndSortHand
    secondHand = hand2.orderAndSortHand
    
    listOfNumbersPlayerOne = convertLettersToNumbers(createListOfNumbers(firstHand))
    listOfSuitsPlayerOne = convertSuitsToNumbers(createListOfSuits(firstHand))
    
    listOfNumbersPlayerTwo = convertLettersToNumbers(createListOfNumbers(secondHand))
    listOfSuitsPlayerTwo = convertSuitsToNumbers(createListOfSuits(secondHand))
    
    #CHECK IF ROYAL FLUSH
    if checkIfRoyalFlush(listOfNumbersPlayerOne, listOfSuitsPlayerOne) || checkIfRoyalFlush(listOfNumbersPlayerTwo, listOfSuitsPlayerTwo)
        if checkIfRoyalFlush(listOfNumbersPlayerOne, listOfSuitsPlayerOne)
            if checkIfRoyalFlush(listOfNumbersPlayerTwo, listOfSuitsPlayerTwo)
                if listOfSuitsPlayerOne.max.to_i > listOfSuitsPlayerTwo.max.to_i
                    winnerCongratulations(firstHand)
                    else
                    winnerCongratulations(secondHand)
                end
                else
                winnerCongratulations(firstHand)
            end
            else
            winnerCongratulations(secondHand)
        end
    end
    
    #CHECK IF STRAIGHT FLUSH
    if checkIfStraightFlush(listOfNumbersPlayerOne, listOfSuitsPlayerOne) || checkIfStraightFlush(listOfNumbersPlayerTwo, listOfSuitsPlayerTwo)
        if checkIfStraightFlush(listOfNumbersPlayerOne, listOfSuitsPlayerOne)
            if checkIfStraightFlush(listOfNumbersPlayerTwo, listOfSuitsPlayerTwo)
                if listOfNumbersPlayerOne.max.to_i > listOfNumbersPlayerTwo.max.to_i
                    winnerCongratulations(firstHand)
                    else
                    winnerCongratulations(secondHand)
                end
                else
                winnerCongratulations(firstHand)
            end
            else
            winnerCongratulations(secondHand)
        end
    end
    
    #CHECK IF FOUR OF A KIND
    if checkIfFourOfAKind(listOfNumbersPlayerOne) || checkIfFourOfAKind(listOfNumbersPlayerTwo)
        if checkIfFourOfAKind(listOfNumbersPlayerOne)
            if checkIfFourOfAKind(listOfNumbersPlayerTwo)
                if listOfNumbersPlayerOne.max.to_i > listOfNumbersPlayerTwo.max.to_i
                    winnerCongratulations(firstHand)
                    else
                    winnerCongratulations(secondHand)
                end
                else
                winnerCongratulations(firstHand)
            end
            else
            winnerCongratulations(secondHand)
        end
    end
    
    #CHECK IF FULLHOUSE
    if checkIfFullHouse(listOfNumbersPlayerOne) || checkIfFullHouse(listOfNumbersPlayerTwo)
        if checkIfFullHouse(listOfNumbersPlayerOne)
            if checkIfFullHouse(listOfNumbersPlayerTwo)
                if listOfNumbersPlayerOne.max.to_i > listOfNumbersPlayerTwo.max.to_i
                    winnerCongratulations(firstHand)
                    else
                    winnerCongratulations(secondHand)
                end
                else
                winnerCongratulations(firstHand)
            end
            else
            winnerCongratulations(secondHand)
        end
    end
    
    #CHECK IF FLUSH
    if checkIfFlush(listOfSuitsPlayerOne) || checkIfFullHouse(listOfSuitsPlayerTwo)
        if checkIfFlush(listOfSuitsPlayerOne)
            if checkIfFlush(listOfSuitsPlayerTwo)
                if listOfSuitsPlayerOne.max.to_i > listOfSuitsPlayerTwo.max.to_i
                    winnerCongratulations(firstHand)
                    else
                    winnerCongratulations(secondHand)
                end
                else
                winnerCongratulations(firstHand)
            end
            else
            winnerCongratulations(secondHand)
        end
    end
    
    #CHECK IF STRAIGHT
    if checkIfStraight(listOfNumbersPlayerOne) || checkIfStraight(listOfNumbersPlayerTwo)
        if checkIfStraight(listOfNumbersPlayerOne)
            if checkIfStraight(listOfNumbersPlayerTwo)
                if listOfNumbersPlayerOne.max.to_i > listOfNumbersPlayerTwo.max.to_i
                    winnerCongratulations(firstHand)
                    else
                    winnerCongratulations(secondHand)
                end
                else
                winnerCongratulations(firstHand)
            end
            else
            winnerCongratulations(secondHand)
        end
    end
    
    #CHECK IF THREE OF A KIND
    if checkIfThreeOfAKind(listOfNumbersPlayerOne) || checkIfThreeOfAKind(listOfNumbersPlayerTwo)
        if checkIfThreeOfAKind(listOfNumbersPlayerOne)
            if checkIfThreeOfAKind(listOfNumbersPlayerTwo)
                if listOfNumbersPlayerOne.max.to_i > listOfNumbersPlayerTwo.max.to_i
                    winnerCongratulations(firstHand)
                    else
                    winnerCongratulations(secondHand)
                end
                else
                winnerCongratulations(firstHand)
            end
            else
            winnerCongratulations(secondHand)
        end
    end
    
    #CHECK IF TWO PAIRS
    if checkIfTwoPairs(listOfNumbersPlayerOne) || checkIfTwoPairs(listOfNumbersPlayerTwo)
        if checkIfTwoPairs(listOfNumbersPlayerOne)
            if checkIfTwoPairs(listOfNumbersPlayerTwo)
                if listOfNumbersPlayerOne.max.to_i > listOfNumbersPlayerTwo.max.to_i
                    winnerCongratulations(firstHand)
                    else
                    winnerCongratulations(secondHand)
                end
                else
                winnerCongratulations(firstHand)
            end
            else
            winnerCongratulations(secondHand)
        end
    end
    
    #CHECK IF ONE PAIRS
    if checkIfOnePair(listOfNumbersPlayerOne) || checkIfOnePair(listOfNumbersPlayerTwo)
        if checkIfOnePair(listOfNumbersPlayerOne)
            if checkIfOnePair(listOfNumbersPlayerTwo)
                if listOfNumbersPlayerOne.max.to_i > listOfNumbersPlayerTwo.max.to_i
                    winnerCongratulations(firstHand)
                    else
                    winnerCongratulations(secondHand)
                end
                else
                winnerCongratulations(firstHand)
            end
            else
            winnerCongratulations(secondHand)
        end
    end
    
    #CHECK HIGHEST CARD
    if checkHighCard(listOfNumbersPlayerOne) > checkHighCard(listOfNumbersPlayerTwo)
        winnerCongratulations(firstHand)
        else
        winnerCongratulations(secondHand)
    end
end


a = PokerHand.new(["2C", "2C", "2C", "5C", "6C"])
b = PokerHand.new(["5S", "5S", "5S", "6S", "TS"])

winnerHand(a, b)



