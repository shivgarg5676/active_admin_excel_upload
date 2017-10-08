# ActiveAdminExcelUpload (active_admin_excel_upload)
A gem for excel upload for active admin. It is designed for large excel sheets that consume too much time on normal process. It uses active job to process sheets on a different queue and action cables to show progress of your upload. Active admin excel upload brings rails convention for excel uploads.


## prerequisites
```ruby
  active-admin,
  Devise,
  Rails 5,
  redis
  ```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'active_admin_excel_upload'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install active_admin_excel_upload
```


## Usage
configure your active admin resource to use it.

```ruby
# RAILS_ROOT/app/admin/post.rb
ActiveAdmin.register Post do
  excel_importable         
end
```
set your queue backend in application.rb
```ruby
  config.active_job.queue_adapter = :sidekiq
```
You can use any queuing backend e.g resque etc.

You may need redis adapter in cable.yml to work it in dev mode. By default rails uses redis adaper for production mode.
```ruby
  development:
    adapter: redis
```


## Convention
1. By default it searches for sheet in your excel file with the same name as of the table   in the db for current model.
2. First row in the sheet is considered as header. Header names has to match either column names in the table or humanized version of column names.
3. It tries it create record every time for every row. If record is not created due to some error or validation failue they are shown live and process moves to next row.


## configuration
if You are using your own authentication method for action cables. You can pass the identified by to the active_admin_excel_upload.

config/initializers/active_admin_excel_upload.rb

```ruby
  ActiveAdminExcelUpload.configure do |config|
    config.use_default_connecion_authentication = false
    config.connection_identifier = :current_admin_user
  end
```

## Overrides

## Override Parsing method.
Active admin excel upload defines a method in ActiveRecord::Base class. if you want custom behaviour for your row you can define a method in your model as follows

```ruby
  def excel_create_record(row, index, header,channel_name)
    ActionCable.server.broadcast channel_name, message: "processing for #{row}"
    object = Hash[header.zip row]
    record = self.new(object)
    if record.save
      ActionCable.server.broadcast channel_name, message: "Successfully cureated record for #{row}, id: #{record.id}"
    else
      ActionCable.server.broadcast channel_name, message: "Could not create record for #{row}, error: #{record.errors.messages}"
    end
  end
```
active_admin_excel_upload send 4 arguments to this method. First is the array for the current processing row in the excel. Second is the index for the row. Third is header of the sheet. Fourth is the channel_name to send messages on.

```ruby
  ActionCable.server.broadcast channel_name, message: "Successfully cureated record for #{row}, id: #{record.id}"
```
This particular line is used to broadcast messsages on particular channel.

By default it sends string as message but you can render anuthing you want. e.g

``` ruby
ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
