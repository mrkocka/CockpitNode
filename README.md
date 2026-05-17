

# CockpitNode

A CockpitNode egy könnyű bootstrap script, amely Ubuntu Linux szervereket készít elő központi Cockpit alapú menedzsmentre SSH-kulcsos hitelesítéssel és beépített webes fájlkezeléssel.

> ⚠️ A projektben található script ingyenesen használható és szabadon módosítható. A futtatás során esetlegesen fellépő hibákért, rendszerproblémákért vagy adatvesztésért azonban a készítő nem vállal felelősséget. A script használata minden esetben saját felelősségre történik.

---

## 🚀 Funkciók

- Automatikus Cockpit telepítés
- `cockpit-files` támogatás
- Dedikált `cockpit` felhasználó létrehozása
- Sudo jogosultság automatikus beállítása
- Cockpit socket automatikus indítása
- Beépített státusz- és hálózati ellenőrzések
- SSH alapú központi kapcsolódás előkészítése
- Több szerver központi menedzsmentjének támogatása
- Hasznos adminisztrációs eszközök telepítése:
  - `htop`
  - `mc`

---

## 🎯 A projekt célja

A CockpitNode célja, hogy leegyszerűsítse Linux szerverek csatlakoztatását egy központi Cockpit infrastruktúrához.

A script előkészíti a távoli hostokat úgy, hogy azok biztonságosan kezelhetők legyenek egy Master Cockpit szerverről kizárólag SSH kapcsolaton keresztül.

---

## 🔒 Biztonsági koncepció

A CockpitNode biztonságos működésre lett tervezve:

- A távoli szervereken nem szükséges publikusan megnyitni a `9090` portot
- A kommunikáció SSH-n keresztül történik
- A hitelesítés SSH kulcsokkal működik
- A script automatikusan létrehoz egy külön nem-root menedzsment felhasználót

Ajánlott infrastruktúra:

```text
Internet
   │
   ▼
SSH (22 / vagy más port)
   │
   ▼
Master Cockpit Server
   │
   ▼
Remote Cockpit Hostok
```

---

## 📦 Telepített komponensek

A script telepíti:

- `cockpit`
- `cockpit-bridge`
- `cockpit-system`
- `cockpit-ws`
- `cockpit-files`

További adminisztrációs eszközök:

- `htop`
- `mc`

---

## ⚙️ Követelmények

- Ubuntu 24.04 LTS
- Internetkapcsolat
- sudo/root jogosultság

---

## 🛠️ Telepítés

Script létrehozása:

```bash
nano cockpitnode.sh
```

Futtathatóvá tétel:

```bash
chmod +x cockpitnode.sh
```

Indítás:

```bash
sudo ./cockpitnode.sh
```

---

## 🔗 Kapcsolódás a Master Cockpithez

Telepítés után:

1. Nyisd meg a Master Cockpit szervert
2. Válaszd:
   ```text
   Connect to another host
   ```
3. Add meg:
   - Hostnév vagy IP cím
   - Felhasználó: `cockpit`
4. Pipáld be:
   ```text
   Create a new SSH key and authorize it
   ```

---

## 🌐 Webes fájlkezelés

A CockpitNode tartalmazza a `cockpit-files` komponenst, amely lehetővé teszi:

- fájlok feltöltését
- fájlok szerkesztését
- mappák böngészését
- távoli fájlkezelést közvetlenül a Cockpit felületén

---

## 🧠 Filozófia

A CockpitNode nem csupán egy telepítő script.

A projekt célja egy egyszerű, könnyen bővíthető infrastruktúra provisioning workflow kialakítása home lab, VPS és self-hosted környezetekhez.

---

## 📸 Ajánlott felhasználási területek

- Home Lab környezetek
- VPS menedzsment
- Proxmox infrastruktúra
- Távoli Linux adminisztráció
- DevOps alapok tanulása
- Központi szervermenedzsment

---


## 📄 Licenc

MIT License

---

## 👨‍💻 Készítette

Radics Péter
