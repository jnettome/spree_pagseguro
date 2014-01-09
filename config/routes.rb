Spree::Core::Engine.routes.draw do
  match 'pagseguro/callback' => 'pagseguro#callback', via: :get, as: :pagseguro_callback
  match 'pagseguro/notify' => 'pagseguro#notify', via: :get, as: :pagseguro_notify
end
