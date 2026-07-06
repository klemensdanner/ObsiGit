### Interfaces
In Linux min. folgende:
- lo (loopback, 127.0.0.1)
- any: virtuelles Interface, alle Pakete, egal welches interface
- ethx: jeder NIC (network interface controller)


auch usb Schnittstellen können durchnummeriert werden

Am Startbildschirm von wireshark kann man capture Filter festlegen, nur diese Pakete werden dann aufgezeichnet

In der Analyse der Pakete kann man dann Display filter setzen (es werden td alle Pakete empfangen, welche durch den capture filter gehen)


Man kann TCP-Streams folgen und die Payload analysieren

mit tcpdump kann man auch sniffen und dann mit wireshark analysieren