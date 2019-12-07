{$MODE FPC}

uses
  dplatformfingerprint;

var
  S: AnsiString;

begin
  SetLength(S, Length(PLATFORM_FINGERPRINT));
  Move(PLATFORM_FINGERPRINT[0], S[1], Length(PLATFORM_FINGERPRINT));
  Writeln(S);
end.
