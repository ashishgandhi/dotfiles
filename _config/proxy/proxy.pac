function FindProxyForURL(url, host)
{
    if (host.endsWith("susanin.dbxnw.net")) {
        return "SOCKS5 127.0.0.1:8080; SOCKS 127.0.0.1:8080";
    }

    return "DIRECT";
}
