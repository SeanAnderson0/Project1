
// ============================================================
//
// tracktwo.c
//
// This is the starter program for the track two C assignment.
//
// This version is specifically for ARMSIM.
// Compile using the Gnu ARM compiler on Windows via:
//
// arm-none-eabi-gcc -marm -S calling.c
//
// Then run the resulting assembly on ARMSIM. On the Windows VM the
// compiler is in the path already but just in case it is in:
// c:\Program Files (x86)\GNU Tools ARM Embedded\arm-none-eabi\bin
//
// There's some changes in here, of course. For one thing the arrays
// are declared globally so that it is easier to see them in the
// ARMsim memory dump. All the I/O is for the simulator.
//
// Modified for a changed assignment where they just do the expand
// and byte_at functions. This calls their code and then displays the
// results on stdout, so they appear in the simulator under the i/o
// tab.
//
// Author: Bill
// For: CYBR 2250
//
// ============================================================
void expand( const char hex[], char binstring[] );
char byte_at( int position, const char binstring[] );
#define IN_SIZE 40 // 40 characters per data line
#define EXPAND_SIZE (IN_SIZE*4) // Expanded to ASCII string
#define TRUE 1
#define FALSE 0
// ============================================================
//
// Tie in functions for the simulator.
//
// ============================================================
int swi_open( char *name, int mode );
int swi_close( int fd );
int swi_read( int fd, char *dest, unsigned int n );
void swi_write( int fd, char *str );
// If using the -std=c1x standard use __asm__ instead of just asm
__asm__( "\n\n\n"
"@ ============================\n"
"@ Bill's glue logic for ARMsim\n"
"@ ============================\n"
"swi_open: swi 0x66\n"
" mov pc, lr\n\n"
"swi_close: swi 0x68\n"
" mov pc, lr\n\n"
"swi_read: swi 0x6a\n"
" mov pc, lr\n\n"
"swi_write: swi 0x69\t@ Write string to stdout\n"
" mov pc, lr\n\n"
);
// ============================================================
//
// Start here...
//
// ============================================================
char data[ IN_SIZE + 3 ]; // 1 for '\r', 1 for '\n', 1 for the
null
char expanded[ EXPAND_SIZE + 1 ]; // 1 for null
char outstring[ EXPAND_SIZE / 4 + 2 ]; // 1 for newline 1 for null
int main( int ac, char *av[] )
{
int fd = swi_open( "\\Users\\Student\\Desktop\\T2DATA.TXT", 0 ); // Read-only
// We want the newline and null so things stay in sync.
while ( swi_read( fd, data, IN_SIZE + 3 ) >= 40 )
{
// Here, "data" is a string with 40 hex characters
expand( data, expanded );
// The assignment jumps by fours. Trust me, this is right.
int i;
for( i = 0; i < ( EXPAND_SIZE - 5 ) / 4 + 1; i++ )
outstring[ i ] = byte_at( i * 4, expanded );
outstring[ i++ ] = '\n';
outstring[ i++ ] = '\0';
swi_write( 1, outstring );
}
swi_close( fd );
return( 0 );
}
