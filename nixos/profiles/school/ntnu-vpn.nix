{ pkgs, ... }:

{
  system.activationScripts.networkmanager-ntnu = ''
  FILE="/etc/NetworkManager/system-connections/NTNU-VPN.nmconnection"
  
  if [ ! -f "$FILE" ]; then
    mkdir -p /etc/NetworkManager/system-connections
    cat <<'EOF' > "$FILE"
[connection]
id=NTNU-VPN
uuid=cd280eb7-4b51-47c7-bcb8-6ce6951bb721
type=vpn
autoconnect=false

[vpn]
authtype=password
autoconnect-flags=0
certsigs-flags=0
cookie-flags=2
disable_udp=no
enable_csd_trojan=no
gateway=vpn2.ntnu.no
gateway-flags=2
gnutls_priorities=NORMAL:-VERS-ALL:+VERS-TLS1.2
gwcert-flags=2
lasthost-flags=0
pem_passphrase_fsid=no
prevent_invalid_cert=no
protocol=anyconnect
resolve-flags=2
stoken_source=disabled
useragent=AnyConnect Linux
usergroup=SSO
service-type=org.freedesktop.NetworkManager.openconnect

[ipv4]
method=auto

[ipv6]
addr-gen-mode=stable-privacy
method=auto
EOF
    chmod 0600 "$FILE"
    
    # Last inn nye tilkoplingar i NetworkManager med ein gong
    ${pkgs.networkmanager}/bin/nmcli connection reload
  fi
  '';
}