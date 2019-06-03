
FROM klutchell/dnscrypt-proxy:2.0.24-arm

ARG server_names="['scaleway-fr', 'cloudflare']"

# uncomment this line to use a custom servers list
# RUN sed -r "s/^(# )?server_names = .+$/server_names = ${server_names}/" -i /config/dnscrypt-proxy.toml

# Use servers implementing the DNSCrypt protocol
RUN sed -r "s/^(# )?dnscrypt_servers = .+$/dnscrypt_servers = true/" -i /config/dnscrypt-proxy.toml

# Use servers implementing the DNS-over-HTTP/2 protocol
RUN sed -r "s/^(# )?doh_servers = .+$/doh_servers = true/" -i /config/dnscrypt-proxy.toml

# Server must support DNS security extensions (DNSSEC)
RUN sed -r "s/^(# )?require_dnssec = .+$/require_dnssec = true/" -i /config/dnscrypt-proxy.toml

# Server must not log user queries (declarative)
RUN sed -r "s/^(# )?require_nolog = .+$/require_nolog = true/" -i /config/dnscrypt-proxy.toml
