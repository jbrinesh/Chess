(function(root) {
  'use strict';

  root.Board = React.createClass({

    getInitialState: function (){
      return ({ board: BoardStore.all() })
    },

    componentDidMount: function (){
      BoardStore.addChangeHandler(this._updateBoard);
    },

    componentWillUnmount: function(){
      BoardStore.removeChangeHandler(this._updateBoard);
    },

    _updateBoard: function(){
      this.setState({ board: BoardStore.all()})
    },

    render: function (){
      var board = this.state.board;
      var tiles = [];
      for(var i = 0; i < 8; i++){
        for(var j = 0; j < 8; j++){

          var tile_piece = board.find(function(piece){
            if(piece.position[0] === i && piece.position[1] === j){
              return true;
            } else {
              return false;
            }
          })

          if(tile_piece){
            tiles.push(
              <Tile
                key={"(" + i + "," + j + ")"}
                id={"(" + i + "," + j + ")"}
                color={tile_piece.color}
                kind={tile_piece.kind}
              />
            )
          } else {
            tiles.push(
              <Tile
                key={"(" + i + "," + j + ")"}
                id={"(" + i + "," + j + ")"}
              />
            )
          }
        }
      }
      return (
        <div className="board clearfix">
            {tiles}
        </div>
      )
    }
  })
}(this));
