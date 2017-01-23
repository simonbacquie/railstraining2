Guessing.LoginController = Ember.Controller.extend({
  needs: ['application'],
  errorMessage: null,
  isBusyAuthenticating: false,

  actions: {
    authenticate: function() {
      var data = this.getProperties('identification', 'password');
      var self = this;
      self.set('isBusyAuthenticating', true);
      this.get('session').authenticate('simple-auth-authenticator:oauth2-password-grant', data)
      // return this.get('session').authenticate('simple-auth-authenticator:oauth2-password-grant', data).then(function() {
      //   return self.send('loadUserInfo').then(function() {
      //     self.set('isBusyAuthenticating', false);
      //     return self.transitionToRoute('index');  
      //   });
      // });
    }
  }
});

Guessing.ForgotPasswordController = Ember.Controller.extend({
  email: '',

  actions: {
    submit: function() {
      var apiUrl = "/api/passwd/email.json"
      var postData = {email: this.get('email')};
      return Em.$.ajax(apiUrl, {"type": 'POST', 'dataType': 'JSON', 'data': postData})
      .then(function(response) {
        var successMsg = (response.responseJSON) ? (response.responseJSON.msg || response.responseJSON.message) : "Password email instructions were sent to " + postData.email;
        toastr.success(successMsg)
        this.transitionToRoute('login')
      }.bind(this), function(response) {
        var errorMsg = (response.responseJSON) ? (response.responseJSON.error || response.responseJSON.errors) : "Unable to reset password...";
        toastr.error(errorMsg)
      }.bind(this));
    }
  }
});

Guessing.ResetPasswordController = Ember.Controller.extend({
  queryParams: [
    'email', 'reset_password_token'
  ],
  email: '',
  reset_password_token: '',
  password: '',
  password_confirmation: '',

  errors: null,

  actions: {
    submit: function() {
      var apiUrl = "/api/passwd/reset.json"
      var postData = {
        email: this.get('email'),
        reset_password_token: this.get('reset_password_token'),
        password: this.get('password'),
        password_confirmation: this.get('passwordConfirmation')
      };
      return Em.$.ajax(apiUrl, {"type": 'POST', 'dataType': 'JSON', 'data': postData})
      .then(function(response) {
        var successMsg = (response.responseJSON) ? (response.responseJSON.msg || response.responseJSON.message) : "Password was updated for " + postData.email;
        toastr.success(successMsg)
        this.setProperties({errors:null,password:'',password_confirmation:''}) // clear form
        this.transitionToRoute('login')
      }.bind(this), function(response) {
        if (response.responseJSON && response.responseJSON.errors) {
          var errors = new DS.Errors()
          $.each(response.responseJSON.errors, function(k, v) {
            errors.add(k, v);
          });
          this.set('errors', errors);
          var errorMsg = 'Unable to reset password. See inputs for errors.';
        } else {
          var errorMsg = response.responseJSON.error ? response.responseJSON.error : "Unable to reset password...";          
        }
        toastr.error(errorMsg)
      }.bind(this));
    }
  }
});
