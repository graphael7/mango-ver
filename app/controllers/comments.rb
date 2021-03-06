
get '/comments/:id' do
  @comment = Comment.find_by(id: params[:id])
  erb :'comments/show'
end

get '/comments/:id/edit' do
  @comment = Comment.find_by(id: params[:id])
  erb :'comments/edit'
end

put '/comments/:id' do
  @comment = Comment.find_by(id: params[:id])
  if @comment.update_attributes(params[:comment])
     redirect "/"
  else
    @errors = @comment.errors.full_messages
  end
end

delete '/comments/:id' do

  @comment = Comment.find_by(id: params[:id])
  @comment.destroy
       redirect request.referer
end

post '/comments' do
  user = User.find_by(id: current_user.id)
  @comment = Comment.new(params[:comment])
  @comment.user = current_user
  if @comment.save
     redirect request.referer
  else
    @errors = "The was a problem with your comment submission"
    erb :'questions/'
  end
end

