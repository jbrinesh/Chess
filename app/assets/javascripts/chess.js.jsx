var Route = ReactRouter.Route;
var Router = ReactRouter.Router;
var IndexRoute = ReactRouter.IndexRoute;

var App = React.createClass({
  render: function (){
    return(
      <div>
        <Board/>
      </div>
    )
  }
});

var routes = (
  <Route path="/" component={App}></Route>
);

var mount_parent_component = function(){
  $(document).ready(function() {
    var root = document.getElementById('content');
    React.render(<Router>{routes}</Router>, root);
  });
};
