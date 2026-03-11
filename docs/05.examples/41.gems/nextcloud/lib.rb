require "dotenv"
require "nextcloud"

def get_nextcloud_object
  settings = Dotenv.load
  nextcloud = Nextcloud.new(
    url: settings["URL"],
    username: settings["USERNAME"],
    password: settings["PASSWORD"]
  )
  return nextcloud
end

def get_filesharing_object
  settings = Dotenv.load
  fs = Nextcloud::Ocs::FileSharingApi.new(
    url: settings["URL"],
    username: settings["USERNAME"],
    password: settings["PASSWORD"]
  )
  return fs
end
