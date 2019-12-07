{$MODE FPC}

uses
  dplatformid;

var
  S: AnsiString;

begin
  SetLength(S, Length(PLATFORM_ID));
  Move(PLATFORM_ID[0], S[1], Length(PLATFORM_ID));
  Writeln(S);
end.
