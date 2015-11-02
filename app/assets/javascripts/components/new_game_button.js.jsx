(function(root) {
  'use strict';

  root.NewGameButton = React.createClass({

    _handleClick: function(){
      ApiUtil.newGame();
    },

    render: function(){
      return (
        <button className="new-game-button" onClick={this._handleClick}>New Game</button>
      )
    }
  })

}(this));
