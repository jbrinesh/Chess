(function(root) {
  'use strict';

  root.ContinueGameButton = React.createClass({

    _handleClick: function(){
      ApiUtil.continueGame();
    },

    render: function(){
      return (
        <button className="continue-game-button" onClick={this._handleClick}>Continue a Game</button>
      )
    }
  })

}(this));
