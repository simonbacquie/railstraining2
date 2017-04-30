class Api::PostsController < ::ApiController

  def index
    # list all posts and render in JSON format

    scoped_visible_users = Post.where(user_id: current_user.id, visible:true)
    render status: 200, json: scoped_visible_users
  end

  def create
    # make a new Post object and persist it to the DB

    if params[:body].present?
      new_post         = Post.new
      new_post.body    = params[:body]
      new_post.user_id = current_user.id
      new_post.save

      render status: 200, json: new_post
    else
      render status: 422, json: {message: "'body' form field is required"}
    end
  end

end
