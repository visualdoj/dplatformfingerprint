unit dplatformfingerprint_utils;

//
//  Extends dplatformfingerprint with some utility functions.
//

{$MODE FPC}
{$MODESWITCH RESULT}

interface

uses
  dplatformfingerprint;

function PlatformFingerprintGetSize(P: Pointer): SizeUInt; inline;
      //
      // Returns size of the fingerprint. Returns 0 if data is invalid.
      //
      // Requires at least two bytes
      //

function PlatformFingerprintEqual(const A, B: TPlatformFingerprint): Boolean; inline;

implementation

function PlatformFingerprintGetSize(P: Pointer): SizeUInt; inline;
begin
  if not (PAnsiChar(P)[0] in ['0' .. '9']) then
    Exit(0);
  if not (PAnsiChar(P)[1] in ['0' .. '9']) then
    Exit(0);
  Exit(10 * (PByte(P)[0] - Ord('0')) +
            (PByte(P)[1] - Ord('0')));
end;

function PlatformFingerprintEqual(const A, B: TPlatformFingerprint): Boolean; inline;
begin
  Exit(CompareByte(A[0], B[0], Length(TPlatformFingerprint)) = 0);
end;

end.
