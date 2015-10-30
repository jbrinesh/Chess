(function(root) {
  'use strict';

  root.Tile = React.createClass({

    _handleClick: function(e){
      var pos_str = e.currentTarget.id;
      var position =[parseInt(pos_str[1]), parseInt(pos_str[3])];
      var validMoves = BoardStore.validMoves();
      if(this.props.color && this.props.color == "white"){
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
    },

    _imageUrl: function(){
      var images = {
        black: {
          king: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069603/king_black_axzkpj.png",
          queen: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069603/queen_black_gsia1e.png",
          rook: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069603/rook_black_xoezue.png",
          bishop: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069601/bishop_black_dnrhik.png",
          knight: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069601/knight_black_hcn148.png",
          pawn: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069602/pawn_black_ynjzdr.png"

        },
        white: {
          king: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069602/king_white_z88dfi.png",
          queen: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069603/queen_white_nz8rjk.png",
          rook: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069604/white_rook_krpnd0.png",
          bishop: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069602/bishop_white_unsrp5.png",
          knight: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069602/knight_white_kgqegq.png",
          pawn: "http://res.cloudinary.com/dfb4gjjt4/image/upload/v1446069603/pawn_white_cb8lht.png"
        }
      }

      return images[this.props.color][this.props.kind]
    },

    render: function (){
      return(
        <div className="tile" className={this.props.classProp} id={this.props.id} onClick={this._handleClick}>
           {this.props.kind ? <img src={this._imageUrl()}/> : null}
        </div>
      )
    }
  })
}(this));
