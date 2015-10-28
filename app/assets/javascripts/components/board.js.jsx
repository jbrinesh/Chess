(function(root) {
  'use strict';

  root.Board = React.createClass({

    render: function (){
      var tiles = [];
      for(var i = 0; i < 8; i++){
        tiles.push(<Tile key={i}/>)
      }
      return (
        <div className="board">
          <div className="row_0">
            {tiles}
          </div>
          <div className="row_1">
            {tiles}
          </div>
          <div className="row_2">
            {tiles}
          </div>
          <div className="row_3">
            {tiles}
          </div>
          <div className="row_4">
            {tiles}
          </div>
          <div className="row_5">
            {tiles}
          </div>
          <div className="row_6">
            {tiles}
          </div>
          <div className="row_7">
            {tiles}
          </div>
        </div>
      )
    }
  })
}(this));
