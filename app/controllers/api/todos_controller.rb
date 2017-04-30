class Api::TodosController < ::ApiController

  def index
    # list all todos and render in JSON format

    user_todos = Todo.where(user_id: current_user.id)
    render status: 200, json: user_todos
  end

  def index_done
    user_todos = Todo.where(user_id: current_user.id, done: true)
    render status: 200, json: user_todos
  end

  def index_open
    user_todos = Todo.where(user_id: current_user.id, done: false)
    render status: 200, json: user_todos
  end

  def create
    # make a new Todo object and persist it to the DB

    if params[:name].present?
      new_todo         = Todo.new
      new_todo.name    = params[:name]
      new_todo.user_id = current_user.id
      new_todo.save

      render status: 201, json: new_todo
    else
      render status: 422, json: {message: "'name' form field is required"}
    end
  end

  def update
    todo = Todo.find(params[:id])
    todo.name = params[:name] if params[:name].present?
    todo.done = (params[:name] == 'true') if params[:done].present?
    todo.save

    # when it's a 204 you don't output any response body
    render status: 204, json: nil
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy

    render status: 204, json: nil
  end

end
