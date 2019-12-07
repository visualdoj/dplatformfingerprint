{$MODE FPC}
{$MODESWITCH RESULT}

uses
  dplatformfingerprint,
  dplatformfingerprint_utils;

var
  S: AnsiString;
  F: TPlatformFingerprint;

function PlatformFingerprintToString(const F: TPlatformFingerprint): AnsiString;
begin
  SetLength(Result, Length(TPlatformFingerprint));
  Move(F[0], Result[1], Length(TPlatformFingerprint));
end;

begin
  F := PLATFORM_FINGERPRINT;
  Writeln(PlatformFingerprintToString(F), ' = ', PlatformFingerprintToString(PLATFORM_FINGERPRINT), ': ', PlatformFingerprintEqual(F, PLATFORM_FINGERPRINT));
  if PlatformFingerprintGetSize(@F[0]) <> 16 then
    Writeln('ERROR: wrong size');
  F[0] := Ord('1');
  F[1] := Ord('3');
  Writeln(PlatformFingerprintToString(F), ' = ', PlatformFingerprintToString(PLATFORM_FINGERPRINT), ': ', PlatformFingerprintEqual(F, PLATFORM_FINGERPRINT));
  if PlatformFingerprintGetSize(@F[0]) <> 13 then
    Writeln('ERROR: wrong size');
end.
