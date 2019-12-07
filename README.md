# dplatformid

Defines ID of current platform as a global constant `PLATFORM_ID`.

# Overview

Sometimes it is necessary to save some data on disk for future use
by the same program on the same PC, e.g. caches.

There is a risk that such local data will be transmitted from one PC to
another by accident, so loader should be protected from reading
incompatible raw binary data. Common protection strategy is to encode
the data in platform-agnostic way, so the data can be read on any platform,
but for that saver and loader spend time for encoding/decoding and become a
little bit more complex (programmer should take into account sizes
of integers types, little or big endian bytes order etc).

The [dplatformid](dplatformid.pas) unit provides
another strategy: save the ID with binary data and reject all data
with different ID, so binary data can be saved "as is".

# Usage

While saving: put the content of `PLATFORM_ID` with binary data.
While loading: compare ID from some data with the `PLATFORM_ID`
and reject the data if they differ. Pseudocode to demonstrate the idea:

```pascal
  // In saver:
  Stream.Write(PLATFORM_ID[0], Length(PLATFORM_ID));

...

  // In loader:
  var
    PlatformID: TPlatformID;

  Steam.Read(PlatformID[0], Length(PLATFORM_ID));
  if CompareByte(PlatformID[0], PLATFORM_ID[0], Length(PLATFORM_ID)) <> 0 then begin
    ... ERROR! Data is not compatible, reject the data
  end;
```

Format of a ID is simple: first two bytes are ASCII characters of
decimal digits for `Size` of the ID and other `Size-2` bytes are any
data (human readable or binary) that determines current platform (cpu, os etc).

Here is one possible example:

```
16_64L86_64linux
^  ^ ^^    ^
|  | ||    |
|  | ||    - OS
|  | |- cpu
|  | - endianness
|  - cpu bits
- size of the ID in bytes
```
