(function(root) {
  'use strict';

  var _messages = [
    "To begin a new game click New Game",
    "If you already started a game you can click Continue a Game to load it",
    "A user may only have one game in progress, if you click New Game any previous game will be lost"];

  var _setMessages = function(messages){
    _messages = messages;
  };

  var _clearMessages = function(){
    _messages = [];
  };

  root.DialogStore = $.extend ({}, EventEmitter.prototype, {

    all: function(){
      var messages = _messages.slice(0);
      _clearMessages();
      return messages
    },

    addChangeHandler: function(handler){
      DialogStore.on(Constants.MESSAGES_CHANGED, handler)
    },

    removeChangeHandler: function(){
      DialogStore.removeListener(Constants.MESSAGES_CHANGED, handler)
    },

    DispatcherID: AppDispatcher.register(function(payload){
      switch (payload.actionType){

        case Constants.RECIVED_VALID_MOVES:
        _setMessages(["Please select a valid position to move to"]);
        DialogStore.emit(Constants.MESSAGES_CHANGED);
        break;

        case Constants.MAKE_MOVE:
        _setMessages(["The AI Player is thinking, plaease wait"]);
        DialogStore.emit(Constants.MESSAGES_CHANGED);
        break;

        case Constants.RECIVED_BOARD:
        _setMessages(["Please select a piece to move"]);
        DialogStore.emit(Constants.MESSAGES_CHANGED);
        break;


      }
    })
  })
}(this));
