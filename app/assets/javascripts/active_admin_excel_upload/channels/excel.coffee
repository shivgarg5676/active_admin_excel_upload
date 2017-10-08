App.room = App.cable.subscriptions.create "ActiveAdminExcelUpload::ExcelChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log('connected')
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    searchParams = new URLSearchParams(window.location.search);
    model = searchParams.get("model")
    modelInMessage = data.message.match("\\[(\\w+\)]")[1]
    if model == modelInMessage
      para = document.createElement("P");
      t = document.createTextNode(data["message"].match("\\[(\\w+\)](.*)")[2]);
      para.appendChild(t);
      para.style.borderBottom = "1px solid lightgrey";
      para.style.margin = "0px";
      para.style.padding= "10px";
      document.getElementById("show_status").appendChild(para);

  speak: ->
    @perform 'speak'
