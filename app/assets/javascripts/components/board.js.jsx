(function(root) {
  'use strict';

  root.Board = React.createClass({

    getInitialState: function (){
      return ({
        board: BoardStore.board(),
        selected: BoardStore.selected(),
        validMoves: BoardStore.validMoves(),
        thinking: false
      })
    },

    componentDidMount: function (){
      BoardStore.addChangeHandler(this._updateBoard);
    },

    componentWillUnmount: function(){
      BoardStore.removeChangeHandler(this._updateBoard);
    },

    messages: function(){
      if (this.state.thinking){
        return ["The AI is thinking"];
      } else {
        return [];
      }
    },

    _updateBoard: function(){
      this.setState({
        board: BoardStore.board(),
        selected: BoardStore.selected(),
        validMoves: BoardStore.validMoves(),
        thinking: BoardStore.thinking()
      })
    },

    _handleClick: function(e){
      if (this.state.thinking !== true){
        var pos_str = e.currentTarget.id;
        var position =[parseInt(pos_str[1]), parseInt(pos_str[3])];
        var validMoves = BoardStore.validMoves();
        if(e.currentTarget.classList[0] === "occupied-white"){
          BoardActions.selectPosition(position);
        } else if (validMoves.some(function(el){
          if(el[0] === position[0] && el[1] === position[1]){
            return true
          } else {
            return false
          }
        })) {
          BoardActions.makeMove(position);
        }
      }
    },


    render: function (){
      var that = this;
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
                handleClick={that._handleClick}
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
                handleClick={that._handleClick}
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
                handleClick={that._handleClick}
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
                handleClick={that._handleClick}
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
                handleClick={that._handleClick}
                classProp="highlighted tile"
                key={"(" + i + "," + j + ")"}
                id={"(" + i + "," + j + ")"}
              />
            )
          }else {
            tiles.push(
              <Tile
                handleClick={that._handleClick}
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
