# Chess

[Live Link][heroku]

[heroku]: http://brineshchess.herokuapp.com/

## Overview

Chess is a full-stack single player game designed to showcase object oriented
programing using Ruby. The backend is a RESTful API built on Rails that handles
all of the game logic. Requests can be made from the JavaScript user interface
to GET for a new game, PATCH to continue a game, GET form valid moves from the
board, and PATCH make a move on the board. The server always response with a
complete board to act as a single source of truth. The AI on the server uses
a combination or early and end game piecewise tables to value the board and a 2
deep MinMax algorithm to compute the best move.   

## Major Design Points

### Game Tracking with Session Tokens and Database Schema

When a user click on new game, the server starts by generating a session token,
and storing it in the Games table. Then the server generates all 32 pieces that
represent a new board of chess and stores each one in the Pieces table with a
foreign key to the newly created entry in the Games table. Finally the server
response with the list of pieces and stores the session token in the clients
cookies.

When a user clicks on Continue Game, the server first checks if there is a previously
stored session token in the clients cookies. If the server finds a token, it
searches the Games table for a matching entry. If it finds one, in the same SQL
query, it prefetches all the pieces associated with that session token and sends
them all down to the client like it was a new game.

The server always acts as the single source of truth on the current state of the
board. When a user makes a move on the board on the client's side. The client makes
and API request only sending up the to and from position of the move. The server
then uses the session token to find the correct game in its database and then
performs all the logic using that board. Once the server makes all its moves, it
send down the entire board again with the move the client made performed as well
as an AI move.

### Server utilizes a RESTful API

The API of the server is just four method, new_game, continue_game, valid_moves
and play_turn

https://github.com/jbrinesh/Chess/blob/master/config/routes.rb

### Use of Multi-class hierarchy and inheritance to keep code DRY

### AI player Using Game Theory (coming soon)

The AI player computes its optimal move using a combination or early and end game
piecewise tables to value the board and a 2 deep MinMax algorithm to compute
the best move.
