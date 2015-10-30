(function(root) {
  'use strict';

  root.Board = React.createClass({

    getInitialState: function (){
      return ({
        board: BoardStore.board(),
        selected: BoardStore.selected(),
        validMoves: BoardStore.validMoves()
      })
    },

    componentDidMount: function (){
      BoardStore.addChangeHandler(this._updateBoard);
    },

    componentWillUnmount: function(){
      BoardStore.removeChangeHandler(this._updateBoard);
    },

    _updateBoard: function(){
      this.setState({
        board: BoardStore.board(),
        selected: BoardStore.selected(),
        validMoves: BoardStore.validMoves()
      })
    },

    render: function (){
      var board = this.state.board;
      var selected = this.state.selected;
      var validMoves = this.state.validMoves;
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

          if (selected !== null && i === selected[0] && j === selected[1]){
            tiles.push(
              <Tile
                classProp="selected tile"
                key={"(" + i + "," + j + ")"}
                id={"(" + i + "," + j + ")"}
                color={tile_piece.color}
                kind={tile_piece.kind}
              />
            )
          } else if(tile_piece && tile_piece.color === "white"){
            tiles.push(
              <Tile
                classProp="occupied-white tile"
                key={"(" + i + "," + j + ")"}
                id={"(" + i + "," + j + ")"}
                color={tile_piece.color}
                kind={tile_piece.kind}
              />
            )
          } else if (tile_piece && tile_piece.color === "black" && validMoves.some(function(el){
            if (el[0] === i && el[1] === j){
              return true
            } else{
              return false
            }
          })){
            tiles.push(
              <Tile
                classProp="occupied-black highlighted tile"
                key={"(" + i + "," + j + ")"}
                id={"(" + i + "," + j + ")"}
                color={tile_piece.color}
                kind={tile_piece.kind}
              />
            )
          } else if(tile_piece && tile_piece.color === "black"){
            tiles.push(
              <Tile
                classProp="occupied-black tile"
                key={"(" + i + "," + j + ")"}
                id={"(" + i + "," + j + ")"}
                color={tile_piece.color}
                kind={tile_piece.kind}
              />
            )
          } else if (validMoves.some(function(el){
            if (el[0] === i && el[1] === j){
              return true
            } else{
              return false
            }
          })){
            tiles.push(
              <Tile
                classProp="highlighted tile"
                key={"(" + i + "," + j + ")"}
                id={"(" + i + "," + j + ")"}
              />
            )
          }else {
            tiles.push(
              <Tile
                classProp="empty tile"
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
