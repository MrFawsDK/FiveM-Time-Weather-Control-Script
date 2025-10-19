# FiveM Time & Weather Control Script

Dette er et avanceret FiveM script til ESX der gør det muligt at kontrollere både tiden og vejret på serveren.

## Features

- 🕐 Frys/unfrys tiden med `/fawsfreeze` kommandoen
- ⏰ Sæt specifik tid med `/fawstime [time] [minut]` kommandoen
- 🌤️ Kontroller vejret med `/fawsweather` og `/fawssetweather` kommandoer
- 📋 Se tilgængelige vejrtyper med `/fawsweatherlist`
- 👨‍💼 Kun admins kan bruge kommandoerne
- 🌐 Automatisk synkronisering for alle spillere på serveren
- 🎮 Nye spillere får automatisk frosset tid og vejr når de joiner

## Kommandoer

### Tid Kommandoer

#### `/fawsfreeze`
Toggle mellem frosset og normal tid.
- Uden argumenter: Fryser tiden på kl. 12:00
- Med argumenter: `/fawsfreeze [time] [minut]` - Fryser tiden på den specificerede tid

**Eksempler:**
- `/fawsfreeze` - Fryser tiden på 12:00
- `/fawsfreeze 15 30` - Fryser tiden på 15:30

#### `/fawstime [time] [minut]`
Sætter tiden til en specifik tid (virker både når tiden er frosset og ikke frosset).

**Eksempler:**
- `/fawstime 9 0` - Sætter tiden til 09:00
- `/fawstime 21 45` - Sætter tiden til 21:45

### Vejr Kommandoer

#### `/fawsweather`
Toggle mellem frosset og normalt vejr.
- Uden argumenter: Fryser vejret på CLEAR (klart)
- Med argumenter: `/fawsweather [vejrtype]` - Fryser vejret på den specificerede type

**Eksempler:**
- `/fawsweather` - Fryser vejret på CLEAR
- `/fawsweather RAIN` - Fryser vejret på regn
- `/fawsweather THUNDER` - Fryser vejret på tordenvejr

#### `/fawssetweather [vejrtype]`
Sætter vejret til en specifik type (virker både når vejret er frosset og ikke frosset).

**Eksempler:**
- `/fawssetweather CLEAR` - Sætter klart vejr
- `/fawssetweather SNOWLIGHT` - Sætter let sne
- `/fawssetweather FOGGY` - Sætter tåget vejr

#### `/fawsweatherlist`
Viser en liste over alle tilgængelige vejrtyper.

### Tilgængelige Vejrtyper
- **CLEAR** - Klart vejr
- **EXTRASUNNY** - Meget solrigt
- **CLOUDS** - Skyet
- **OVERCAST** - Overskyet
- **RAIN** - Regn
- **CLEARING** - Opklarende
- **THUNDER** - Tordenvejr
- **SMOG** - Smog
- **FOGGY** - Tåget
- **XMAS** - Julesne
- **SNOWLIGHT** - Let sne
- **BLIZZARD** - Snestorm

## Installation

1. Placer mappen i din `resources` folder
2. Tilføj `ensure [mappenavn]` til din `server.cfg`
3. Genstart serveren

## Krav

- ESX Framework
- Admin rettigheder for at bruge kommandoerne (admin eller superadmin gruppe)

## Tilpasninger

Du kan ændre hvilke grupper der har adgang til kommandoerne ved at modificere denne linje i `server/main.lua`:

```lua
if xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin' then
```

Tilføj flere grupper eller ændr til dine serverens gruppenavne.

## Nye Features i v2.0

✅ **Vejrkontrol** - Nu kan du kontrollere vejret på samme måde som tiden
✅ **Flere kommandoer** - Separate kommandoer til at sætte tid og vejr
✅ **Vejrliste** - Se alle tilgængelige vejrtyper
✅ **Forbedret synkronisering** - Både tid og vejr synkroniseres automatisk
✅ **Bedre error handling** - Validering af vejrtyper og tidsværdier