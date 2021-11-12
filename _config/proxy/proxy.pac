function FindProxyForURL(url, host)
{
    const proxy = "SOCKS5 127.0.0.1:8080; SOCKS 127.0.0.1:8080";
    if (host.endsWith("susanin.dbxnw.net")) {
        return proxy;
    }
    if (host.startsWith("ttd")) {
        return proxy;
    }

    return "DIRECT";
}
