{$MODE FPC}
{$MODESWITCH RESULT}

uses
  dplatformid,
  dplatformid_utils;

var
  S: AnsiString;
  F: TPlatformID;

function PlatformIDToString(const F: TPlatformID): AnsiString;
begin
  SetLength(Result, Length(TPlatformID));
  Move(F[0], Result[1], Length(TPlatformID));
end;

begin
  F := PLATFORM_ID;
  Writeln(PlatformIDToString(F), ' = ', PlatformIDToString(PLATFORM_ID), ': ', PlatformIDEqual(F, PLATFORM_ID));
  if PlatformIDGetSize(@F[0]) <> 16 then
    Writeln('ERROR: wrong size');
  F[0] := Ord('1');
  F[1] := Ord('3');
  Writeln(PlatformIDToString(F), ' = ', PlatformIDToString(PLATFORM_ID), ': ', PlatformIDEqual(F, PLATFORM_ID));
  if PlatformIDGetSize(@F[0]) <> 13 then
    Writeln('ERROR: wrong size');
end.
