
FROM klutchell/dnscrypt-proxy:2.0.23-arm

## Servers from the "public-resolvers" source (see down below) can
## be viewed here: https://dnscrypt.info/public-servers
##
## If this line is commented, all registered servers matching the require_* filt
## will be used.
##
## The proxy will automatically pick the fastest, working servers from the list.
## Remove the leading # first to enable this; lines starting with # are ignored.

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
