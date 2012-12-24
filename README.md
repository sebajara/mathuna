Mathuna: Kahuna game in MATLAB
==============================

Kahuna game
-----------

Kahuna is a game between two players. It consists of a board of
*islands* connected by *bridges*, a *deck* of cards containing two
cards for each island, and three *open-cards* slots. Each player can
possess a maximum of 5 cards ( *player hand* ).

During a turn, a player can do four classes of *actions*: 

  1. *Build* a bridge using one of the cards representing the island
  that the bridge connects, given that is currently empty.
  2. *Destroy* a bridge from the other player using two cards that
  represent the connecting island, or two cards representing one of
  the islands that the bridges connects, given that currently there is
  a bridge from the other player.
  3. *Discard* one of the cards from his hand.
  4. *Finish* his turn. After which, the player can *draw* one the
  open-cards or the top card from the deck, or not draw at all.

After a bridge is built or destroyed, if a player has more than half
plus one of the total number of bridges of this island (island
*degree*), is said to *occupy* the island, or simply has a
*kahuna*. Once an Island is occupied, all the bridges from the other
player are destroyed, given that previously it was either occupied by
the other player or not occupied at all.

Once the deck and the three open-cards are empty, the game advances to
the next round. All the cards used and discarded during the previous
round are ordered randomly into a new deck. The three top cards from
the deck are distributed among open-cards. Scores for each player are
updated as follow
 1. At the end of round one, 1 point is given to the player with more
 kahunas. In case of a tie, 1 point is given to both players.
 2. At the end of round two, 2 point is given to the player with more
 kahunas. In case of a tie, 2 point is given to both players.
 3. At the end of round three, each player gets the number of points
 equivalent to their number of kahunas.

The game is initialised with an empty board and a full deck randomly
shuffled. The first six cards are divided between the two players, and
the following three are placed in the open-card slots.

Mathuna game
------------

Mathuna is an implementation of kahuna in MATLAB. Mathuna can be
played in three modes: two human players, a human player against a
random player, and two random players against each other. 

### Random player

The random player program is implemented by an algorithm that selects
iteratively among possible actions with equal probability (uniform
distribution).  At each iteration, a class of action is selected, and
then one of the instances of that action is selected. If finishing was
not selected, the program goes into a new iteration. This process is ilustrated
in **Random_player_diagram.png**.

To illustrate the difference between an action and action instances,
let's use building as an example. At a given turn of the game
there might be many possible bridges that a player could build, and
multiple cards that the player could use to build them. The program
randomly selects between all pairwise combinations of bridges and
cards, given that the player has that card, and that the card could be
used to build the bridge. On the contrary, if the player can not build
any bridge, and say that the player could only destroy or finish, then
the probability of finishing would be one half instead of one third.

Once the finishing option is selected, the program randomly choose
between drawing the top card of the deck, one of the open-cards, or
not drawing at all. Notice that during a turn, we may have selected
multiple actions before ending the turn.

### Game records

A record of each game is saved into a tab-delimited format file into
the current MATLAB directory. We have provided a simple function 
`parse_tsv` that would retrieve this data. For more information 
type

      >> help parse_tsv
