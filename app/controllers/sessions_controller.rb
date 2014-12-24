class SessionsController < Devise::SessionsController
  rtn = super
  sign_in(resource.role.underscore, resource.role.constantize.send(:find, resource.id)) unless resource.role.nil?
  rtn
end