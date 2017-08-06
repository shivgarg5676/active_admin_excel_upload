App.room = App.cable.subscriptions.create "ActiveAdminExcelUpload::ExcelChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('connected')
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    para = document.createElement("P");
    t = document.createTextNode(data["message"]);
    para.appendChild(t);
    document.getElementById("show_status").appendChild(para);

  speak: ->
    @perform 'speak'
