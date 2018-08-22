# Ranking Poker Hands

Difficulty: **Easy**

Write a program that accepts two poker hands and returns the winner.

---

### Setup instructions

Fork and setup the exercise repository:

```
git clone <YOUR FORK ADDRESS>
cd ranking-poker-hands
bin/setup
```

---

### Exercise instructions

Write a program to evaluate poker hands and determine a winner.

This [guide to poker hand strengths](https://www.pokerstars.com/poker/games/rules/hand-rankings/) may be useful.

Your program should accept hands in the following representation:

```
# This is a hand with
# an Ace of spades,
# a King of diamonds,
# a Ten of hearts,
# a Jack of clubs,
# and a Queen of hearts.
["AS", "KD", "TH", "JC", "QH"]

# Another hand:
["2C", "5D", "9S", "3H", "TS"]
```

Assume all hands have five cards.

Your program should accept two hands and return the winning hand.

Example usage:

```
hand_1 = %w(2S 2D AH 3S 5S)
hand_2 = %w(2H 2C KH 5H 9C)

HandEvaluator.new.return_stronger_hand(hand1, hand2)
  # => ["2S", "2D", "AH", "3S", "5S"]
```

Note that you must handle ties. In the example above, both hands have a pair, but hand_1 has a higher "kicker" (the Ace).

Make sure your test suite encodes these rules as clearly as possible. Imagine someone wasn't familiar with the rules of hand rankings—would your tests be a good guide?

---

### Push your Solution

Once you're finished, commit your changes and then push your solution to your fork:

```
git push origin master
```
