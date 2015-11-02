(function(root) {
  'use strict';

  root.SaveGameButton = React.createClass({

    _handleClick: function(){
      debugger;
      ApiUtil.saveGame();
    },

    render: function(){
      return (
        <button className="save-game-button" onClick={this._handleClick}>Save this Game</button>
      )
    }
  })

}(this));
