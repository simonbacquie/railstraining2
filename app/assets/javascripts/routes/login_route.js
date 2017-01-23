Guessing.LoginRoute = Ember.Route.extend({
  setupController: function(controller,model) {
    this._super.apply(this,arguments);
    controller.setProperties({identification:'',password:''}) // clear form
  },

  actions: {

  }

});

/*
Guessing.ForgotPasswordRoute = Ember.Route.extend({
  beforeModel: function() {
    this._super.apply(this,arguments);
    // kick user out of app if they are currently logged in
    if (this.get('session.isAuthenticated')) {
      this.get('session').invalidate();
    }
  },
  setupController: function(controller,model) {
    this._super.apply(this,arguments);
    controller.setProperties({email:''}) // clear form
  },
  actions: {

  }

});


Guessing.ResetPasswordRoute = Ember.Route.extend({
  queryParams: {
    email: {refreshModel: true},
    reset_password_token: {refreshModel: true},
  },
  beforeModel: function() {
    this._super.apply(this,arguments);
    // kick user out of app if they are currently logged in
    if (this.get('session.isAuthenticated')) {
      this.get('session').invalidate();
    }
  },
  setupController: function(controller,model) {
    this._super.apply(this,arguments);
    controller.setProperties({errors:null,password:'',password_confirmation:''}) // clear form
    console.debug('reset_password_token is ', controller.get('reset_password_token'))
  },

  actions: {

  }

});
*/
