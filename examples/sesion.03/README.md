
# Problema de redes

# 1. Recopilar información de MACs

Cada tarjeta de red tiene un identificador único que viene de fábrica llamado MAC (MAC Address). Lo primero que vamos a hacer es buscar estos valores.

## 1.1 Mi laptop

* Comando: `ip a`
* Salida:
```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
...
2: wlp6s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 14:f6:d8:44:1f:42 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.42/24 brd 192.168.1.255 scope global dynamic noprefixroute wlp6s0
```
* Tabla ARP:
| PC     | MAC               | IP           |
| ------ | ----------------- | ------------ |
| laptop | 14:f6:d8:44:1f:42 | 192.168.1.42 |

## 1.2 Gateway

* Comando: `ip n`
* Salida:

```
192.168.1.1 dev wlp6s0 lladdr 0c:8e:29:2b:46:ee REACHABLE
```

* Tabla ARP:

| PC      | MAC               | IP           |
| ------- | ----------------- | ------------ |
| laptop  | 14:f6:d8:44:1f:42 | 192.168.1.42 |
| gateway | 0c:8e:29:2b:46:ee | 192.168.1.1  |

## 1.3 Mi móvil

Vamos al móvil:
* Ir Termux y hacemos un ping al laptop.
* ping -c 4 192.168.1.42

Vamos al laptop y consultamos nuevamente la tabla ARP:

```
192.168.1.68 dev wlp6s0 lladdr f2:70:0c:5a:87:76 STALE
192.168.1.1 dev wlp6s0 lladdr 0c:8e:29:2b:46:ee STALE
```

* Tabla ARP:

| PC      | MAC               | IP           |
| ------- | ----------------- | ------------ |
| laptop  | 14:f6:d8:44:1f:42 | 192.168.1.42 |
| gateway | 0c:8e:29:2b:46:ee | 192.168.1.1  |
| móvil   | f2:70:0c:5a:87:76 | 192.168.1.68 |

# 2. Limpiar informacion de la tabla ARP

```
> ip n

192.168.1.68 dev wlp6s0 lladdr f2:70:0c:5a:87:76 STALE
192.168.1.1 dev wlp6s0 lladdr 0c:8e:29:2b:46:ee REACHABLE

> sudo ip n flush dev wlp6s0

> ip n
```
