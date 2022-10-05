a deadsimple health-checkmonitor using curl + awk (in 690 bytes of shellscript)

![](demo.gif)

```shell
$ ./cloudmonitor.sh <url_or_file>
```

```shell
cat myurls.txt
-L -X POST --user "foo"bar" https://foo.com

$ ./cloudmonitor.sh myurls.txt
```

> every line simply gets passed as curl args (so it's flexible)

# from the web

server:
```
$ socat -t2 TCP4-LISTEN:8888,fork,max-children=1,forever,reuseaddr SYSTEM:"./cloudmonitor.sh myurls.txt",pty,echo=0;
listening on port 8000
```

laptop:
```
$ curl http://myserver.com:8888 --http0.9
URL                             ONLINE SSL TIME
-                               -      -   -
google.com                      ♥      ♥   ?
stackoverflow.com               ♥      ♥   0.533812s
playterm.org                    ♥      ♥   0.949111s
electribrary.electribers.com    ♥      ♥   0.304617s
info.cern.ch/                   ♥      ❌  0.120880s
yunohost.org                    ♥      ♥   0.223219s
yunohost.org/en                 ♥      ♥   0.933116s
silverclearinnereclipse.neverssl♥      ❌  0.471678s
```

## Hackable ideas

* let awk execute a file (`.cloudmonitor.sh.onerror` when exist) when ❌occurs (slack notifycation/webhooks e.g.)
