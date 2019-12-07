unit dplatformfingerprint;

//
//  Defines fingerprint of current platform as a global constant.
//
//  Usage: save it before platform-specific encoded binary data for
//  following checking that whis data is reading on the compatible
//  platform.
//
//  Example:
//
//    Stream.Write(PLATFORM_FINGERPRINT[0], Length(PLATFORM_FINGERPRINT));
//
//    ...
//
//    Steam.Read(Temp, Length(TPlatformFingerprint));
//    if Temp <> PLATFORM_FINGERPRINT then begin
//      // the
//    end;
//
//
//  FPC defines:
//
//    https://www.freepascal.org/docs-html/prog/progap7.html
//

{$MODE FPC}

interface

type
  TPlatformFingerprint = array[0 .. 16 - 1] of Byte;

const
PLATFORM_FINGERPRINT: TPlatformFingerprint = (
  Ord('1'), Ord('6'), // First two bytes are ASCII characters (not bytes) with
                      // digits determining the size of full fingerprint
                      // (including the digits).
                      //
                      // Programs may use it to skip fingerprints.
                      //
                      // Only 2 digits allowed.

// FPU features
{$IF Defined(FPUSOFT)}
  Ord('S'),
{$ELSE}
  Ord('_'),
{$ENDIF}

// Number of bits
{$IF Defined(CPU64)}
  Ord('6'), Ord('4'),
{$ELSEIF Defined(CPU32)}
  Ord('3'), Ord('2'),
{$ELSEIF Defined(CPU16)}
  Ord('1'), Ord('6'),
{$ELSE}
  {$ERROR Could not generate fingerprint for number of bits of choosen cpu. Add another ELSEIF (recommended) for the bits number or remove this error from source code if that number cannot be determined through compiler or user defines.}
  Ord('?'), Ord('?'), // unknown number of bits
{$ENDIF}

// Endian
{$IF Defined(ENDIAN_LITTLE)}
  Ord('L'),
{$ELSEIF Defined(ENDIAN_BIG)}
  Ord('B'),
{$ELSE}
  {$ERROR Could not generate fingerprint for endianess of choosen cpu. Add another ELSEIF (recommended) for the endianess or remove this error from source code if the endianess cannot be determined through compiler or user defines.}
  Ord('?'), // unknown endian
{$ENDIF}

// Next ... bytes are CPU name
{$IF Defined(CPUAMD64) or Defined(CPUX86_64) or Defined(CPUX64)}
  Ord('8'),Ord('6'),Ord('_'),Ord('6'),Ord('4'),
{$ELSEIF Defined(CPUIA64)}
  Ord('i'),Ord('t'),Ord('a'),Ord('n'),Ord('i'),
{$ELSEIF Defined(CPU386) or Defined(CPUi386)}
  Ord('i'),Ord('3'),Ord('8'),Ord('6'),Ord('_'),
{$ELSEIF Defined(CPU87)}
  Ord('o'),Ord('l'),Ord('d'),Ord('8'),Ord('7'),
{$ELSEIF Defined(CPU86)}
  Ord('o'),Ord('l'),Ord('d'),Ord('8'),Ord('6'),
{$ELSEIF Defined(CPUARM)}
  Ord('a'),Ord('r'),Ord('m'),Ord('_'),Ord('_'),
{$ELSEIF Defined(CPUAVR)}
  Ord('a'),Ord('v'),Ord('r'),Ord('_'),Ord('_'),
{$ELSEIF Defined(CPUM68020)}
  Ord('m'),Ord('6'),Ord('8'),Ord('0'),Ord('2'),
{$ELSEIF Defined(CPU68K) or Defined(CPUM68K) or Defined(CPU68)}
  Ord('6'),Ord('8'),Ord('0'),Ord('x'),Ord('0'),
{$ELSEIF Defined(CPUSPARC32) or Defined(CPUSPARC)}
  Ord('S'),Ord('P'),Ord('R'),Ord('C'),Ord('7'),
{$ELSEIF Defined(CPUALPHA)}
  Ord('A'),Ord('A'),Ord('X'),Ord('P'),Ord('_'),
{$ELSEIF Defined(CPUPOWERPC32)}
  Ord('P'),Ord('P'),Ord('C'),Ord('3'),Ord('2'),
{$ELSEIF Defined(CPUPOWERPC64)}
  Ord('P'),Ord('P'),Ord('C'),Ord('6'),Ord('4'),
{$ELSEIF Defined(CPUPOWERPC)}
  Ord('P'),Ord('P'),Ord('C'),Ord('_'),Ord('_'),
{$ELSE}
  {$ERROR Could not generate fingerprint for choosen cpu. Add another ELSEIF (recommended) for the cpu or remove this error from source code if the cpu cannot be determined through compiler or user defines.}
  Ord('?'),Ord('?'),Ord('?'),Ord('?'),Ord('?'),
{$ENDIF}

// OS
{$IF Defined(FREEBSD)}
  Ord('f'),Ord('_'),Ord('b'),Ord('s'),Ord('d')
{$ELSEIF Defined(BSD)}
  Ord('b'),Ord('s'),Ord('d'),Ord('_'),Ord('_')
{$ELSEIF Defined(NETBSD)}
  Ord('n'),Ord('_'),Ord('b'),Ord('s'),Ord('d')
{$ELSEIF Defined(SUNOS)}
  Ord('s'),Ord('u'),Ord('n'),Ord('o'),Ord('s')
{$ELSEIF Defined(BEOS)}
  Ord('B'),Ord('e'),Ord('O'),Ord('S'),Ord('_')
{$ELSEIF Defined(QNX)}
  Ord('Q'),Ord('N'),Ord('X'),Ord('_'),Ord('R')
{$ELSEIF Defined(GO32V2)}
  Ord('g'),Ord('o'),Ord('3'),Ord('2'),Ord('2')
{$ELSEIF Defined(MSDOS)}
  Ord('M'),Ord('S'),Ord('D'),Ord('O'),Ord('S')
{$ELSEIF Defined(OS2)}
  Ord('o'),Ord('s'),Ord('2'),Ord('_'),Ord('_')
{$ELSEIF Defined(EMX)}
  Ord('E'),Ord('M'),Ord('X'),Ord('_'),Ord('_')
{$ELSEIF Defined(WIN32)}
  Ord('w'),Ord('i'),Ord('n'),Ord('3'),Ord('2')
{$ELSEIF Defined(WIN64)}
  Ord('w'),Ord('i'),Ord('n'),Ord('6'),Ord('4')
{$ELSEIF Defined(WINCE)}
  Ord('w'),Ord('i'),Ord('n'),Ord('c'),Ord('e')
{$ELSEIF Defined(AMIGA)}
  Ord('a'),Ord('m'),Ord('i'),Ord('g'),Ord('a')
{$ELSEIF Defined(ATARI)}
  Ord('a'),Ord('t'),Ord('a'),Ord('r'),Ord('i')
{$ELSEIF Defined(DARWIN)}
  Ord('M'),Ord('O'),Ord('S'),Ord('_'),Ord('X')
{$ELSEIF Defined(MACOS)}
  Ord('C'),Ord('_'),Ord('M'),Ord('A'),Ord('C')
{$ELSEIF Defined(PALMOS)}
  Ord('P'),Ord('a'),Ord('l'),Ord('m'),Ord('S')
// more generic
{$ELSEIF Defined(LINUX)}
  Ord('l'),Ord('i'),Ord('n'),Ord('u'),Ord('x')
{$ELSEIF Defined(UNIX)}
  Ord('u'),Ord('n'),Ord('i'),Ord('x'),Ord('_')
{$ELESE}
  {$ERROR Could not generate fingerprint for choosen OS. Add another ELSEIF (recommended) for the OS or remove this error from source code if the OS cannot be determined through compiler or user defines.}
  Ord('?'),Ord('?'),Ord('?'),Ord('?'),Ord('?')
{$ENDIF}
);

implementation

end.
