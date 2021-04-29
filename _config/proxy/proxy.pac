function FindProxyForURL(url, host)
{
    const hosts = [
        "hadoop-*",
        "sjc*-*-*",
        "iad*-*-*",
        "ttd*-i-*",
        "*.susanin.dbxnw.net",
    ];

    for (var i = 0; i < hosts.length; i++) {
        if (shExpMatch(host, hosts[i])) {
            return "SOCKS 127.0.0.1:8080";
        }
    }

    return "DIRECT";
}
