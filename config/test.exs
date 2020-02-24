import Config

config :rambla,
       :pools,
       [
         redis: [
           host: System.get_env("REDIS_HOST", "127.0.0.1"),
           port: String.to_integer(System.get_env("REDIS_PORT", "6379")),
           password: System.get_env("REDIS_PASSWORD", ""),
           db: 0,
           reconnect: 1_000,
           max_queue: :infinity
         ],
         amqp: [
           host: System.get_env("RABBITMQ_HOST", "127.0.0.1"),
           password: System.get_env("RABBITMQ_PASSWORD", "guest"),
           port: String.to_integer(System.get_env("RABBITMQ_PORT", "5672")),
           username: System.get_env("RABBITMQ_USERNAME", "guest"),
           virtual_host: System.get_env("RABBITMQ_VHOST", "/"),
           x_message_ttl: "4000"
         ]
       ] ++
         [
           {:smtp,
            [
              # the smtp relay, e.g. "smtp.gmail.com"
              relay: System.get_env("RAMBLA_SMTP_RELAY", "smtp.gmail.com"),
              # the username of the smtp relay e.g. "me@gmail.com"
              username: System.get_env("RAMBLA_SMTP_USERNAME"),
              # the password of the smtp relay e.g. "mypassword"
              password: System.get_env("RAMBLA_SMTP_PASSWORD"),
              # whether the smtp server needs authentication, valid values are if_available and always,
              #   Defaults to if_available. If your smtp relay requires authentication set it to always
              auth: :always,
              # whether to connect on 465 in ssl mode, Defaults to false
              ssl: true,
              # valid values are always, never, if_available.
              #   Most modern smtp relays use tls, so set this to always, Defaults to if_available
              # tls: :always,
              # used in ssl:connect, More info at http://erlang.org/doc/man/ssl.html ,
              #   Defaults to [{versions , ['tlsv1', 'tlsv1.1', 'tlsv1.2']}],
              #   This is merged with options listed at: https://github.com/gen-smtp/gen_smtp/blob/master/src/smtp_socket.erl#L46 .
              #   Any options not present in this list will be ignored.
              # tls_options: [versions: [:tlsv1, :"tlsv1.1", :"tlsv1.2"]],
              # the hostname to be used by the smtp relay,
              #   Defaults to: smtp_util:guess_FQDN().
              #   The hostname on your computer might not be correct, so set this to a valid value.
              hostname: System.get_env("RAMBLA_SMTP_HOSTNAME"),
              # how many retries per smtp host on temporary failure,
              #   Defaults to 1, which means it will retry once if there is a failure.
              retries: 3,
              from: ["matiouchkine@gmail.com"]
            ]}
         ]
