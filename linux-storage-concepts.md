# Linux Storage Concepts: Visual Guide

This document provides a structured overview of key Linux storage technologies using simple diagrams and explanations. It covers Fibre Channel, iSCSI, DM-MPIO, and filesystem stacks (Traditional, ZFS, Btrfs).

---

# 1. Fibre Channel (Dedicated FC Fabric)

A Fibre Channel (FC) fabric is a dedicated, isolated network used exclusively for storage traffic. It provides predictable performance, low latency, and high reliability.

```
    ┌──────────────┐
    │   Server 1   │
    │   (HBA)      │
    └──────┬───────┘
           │  Fibre Channel
    ┌──────▼───────┐
    │  FC Switch   │   ← Dedicated storage network (FABRIC)
    └──────┬───────┘
           │
    ┌──────▼────────────┐
    │  Storage Array    │
    │ (SAN Disks/LUNs)  │
    └───────────────────┘
```

## Redundant FC Fabric (Enterprise Setup)

Enterprise environments use dual fabrics for high availability.

```
    ┌──────────────┐
    │   Server     │
    │ (Dual HBA)   │
    └───┬──────┬───┘
        │      │
 Fabric A   Fabric B
        │          │
┌──────▼─────┐ ┌────▼─────┐
│ FC Switch A│ │FC Switch B│
└──────┬─────┘ └────┬─────┘
       │            │
       └────┬───────┘
            ▼
┌───────────────┐
│ Storage Array │
└───────────────┘
```
---

# 2. iSCSI (Ethernet-Based SAN)

iSCSI provides block storage over standard Ethernet networks. It is flexible and cost-effective but shares bandwidth.

```
    ┌──────────────┐
    │   Server     │
    │ (Ethernet)   │
    └──────┬───────┘
           │
    ┌──────▼───────┐
    │ LAN Switch   │   ← Shared network
    └──────┬───────┘
           │
 ┌─────────▼─────────┐
 │ Storage Server    │
 │ (iSCSI Target)    │
 └───────────────────┘
```

---

# 3. DM-MPIO (Multipath I/O)

DM-MPIO combines multiple paths into one logical device for redundancy and load balancing.

```
    Path A              Path B
 (eth0 / HBA1)      (eth1 / HBA2)
      │                  │
      ▼                  ▼
  ┌────────┐        ┌────────┐
  │ Switch │        │ Switch │
  └────┬───┘        └────┬───┘
       │                 │
       └──────┬──────────┘
              ▼
       Storage Array
              │
      ┌──────────────┐
      │ DM-MPIO      │
      │ /dev/mpath0  │
      └──────────────┘
```

---

# 4. Storage Stack Comparison

## 4.1 Traditional Linux Stack

Separate layers for RAID, volume management, and filesystem.
```
Physical Disks
├─ /dev/sdb
├─ /dev/sdc
└─ /dev/sdd
│
▼
┌─────────────┐
│  mdadm RAID │
└─────────────┘
│
▼
┌─────────────┐
│    LVM      │
└─────────────┘
│
▼
┌─────────────┐
│  ext4/xfs   │
└─────────────┘
```
---

## 4.2 ZFS

All-in-one system with RAID, filesystem, and volume management.
```
Physical Disks
├─ /dev/sdb
├─ /dev/sdc
└─ /dev/sdd
│
▼
┌─────────────┐
│   vdevs     │
│ (RAID-Z/mirror)
└─────────────┘
│
▼
┌─────────────┐
│   ZFS Pool  │
└─────────────┘
│
▼
┌─────────────┐
│  Datasets   │
└─────────────┘
```
---

## 4.3 Btrfs

Modern Linux filesystem with pooling and snapshots.
```
Physical Disks
├─ /dev/sdb
├─ /dev/sdc
└─ /dev/sdd
│
▼
┌─────────────┐
│  Btrfs Pool │
└─────────────┘
│
▼
┌─────────────┐
│ Subvolumes  │
└─────────────┘
```
---

# 5. Summary

* Fibre Channel: Dedicated, high-performance storage network
* iSCSI: Flexible, Ethernet-based SAN
* DM-MPIO: Path redundancy and failover
* Traditional Stack: Modular but layered
* ZFS: Integrated, highly reliable
* Btrfs: Lightweight and flexible

---

# 6. Key Takeaway

Modern storage trends favor integrated systems (ZFS, Btrfs), while enterprise environments rely on SAN + multipathing.
