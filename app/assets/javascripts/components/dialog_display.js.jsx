(function(root) {
  'use strict';

  root.DialogDisplay = React.createClass({

    getInitialState: function(){
      return (
        {messages: DialogStore.all()}
      )
    },

    componentDidMount: function(){
      DialogStore.addChangeHandler(this._updateMessages)
    },

    componentWillUnmount: function(){
      DialogStore.removeChangeHandler(this._updateMessages)
    },

    _updateMessages: function(){
      this.setState({
        messages: DialogStore.all()
      })
    },

    render: function(){
      return (
        <ul className="dialog-display">
          {
            this.state.messages.map(function(message, idx){
              return <li key={idx}>{message}</li>
            })
          }
        </ul>
      )
    }
  })
}(this));
