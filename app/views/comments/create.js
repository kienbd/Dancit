$("#comment").val("");
$("#comment_holder ul").prepend("<%=j render partial: 'shared/comment',locals: {com: @comment} %>");
