program test;
type
    TAB = Array [1 .. 200] of string;
    TAB2 = Array [1 .. 200] of integer;
 var jch : string;
// ================================
//      Other Functions
// ================================
// Reverse a BYTE
function reverse(ch: string) : string;
var i : integer;
    chn : string;
Begin
	chn := '';
	for i := length(ch) downto 1 do
        chn := chn + ch[i];
    reverse := chn;
End;
// Adds a ZEROS to a BYTE so it can be 0
procedure ajouterzero(var ch : string);
var j : integer;
begin
		if(length(ch) <> 8) then
        for j := length(ch)+1 to 8 do 
            ch := '0'+ch;
End;
// Calculates the power b of a number n
function puissance(n, b : integer): integer;
var nb, i : integer;
Begin
	nb := 1;
	for i := 1 to b do 
	Begin
		nb := nb * n;
    End;
    puissance := nb;
End;
// ================================
//      ASCII Table Functions
// ================================
// Character to Byte
function chartobinare(c : char) : string;
var n, nb: integer;
    ch1, ch2 : string;
Begin
	nb := ord(c);
	n := 0;
	ch2 := '';
	Repeat
        n := nb mod 2;
        nb := nb div 2;
        str(n, ch1);
        ch2 := ch2 + ch1;
	Until(length(ch2) = 8) or (nb = 0);
	ch2 := reverse(ch2);
    ajouterzero(ch2);
     chartobinare := ch2;
End;
// Byte to Decimal
function binaretodecimale(ch : string) : integer;
var i, nj : integer;
Begin
	nj := 0;
	ch := reverse(ch);
     for i := 1 to length(ch) do
     Begin
           if(ch[i] = '1') then
           begin
                nj := puissance(2, i-1) + nj;
            end;
      End;
      binaretodecimale := nj;
End;
// Hex to Decimal
// You give it a string of characters and returns the bytes eqv
function concatenatebinare(ch : string) : string;
var chn : string;
       i : integer;
Begin
	chn := '';
	for i := 1 to length(ch) do 
	Begin
		chn := chn + chartobinare(ch[i]);
    End;
    concatenatebinare := chn;
End;
// ================================
//      BASE64 Encoding & Decoding functions
// ================================
// Encodes string to BASE64
function EncodeBase64(ch : string) : string;
var T : TAB;
        n, j, i, k : integer;
        chn : string;
Begin
	ch := concatenatebinare(ch);
	n := 1;
	Repeat
        if( length(ch) < 6) then
        Begin
        	chn := ch;
        	ch := '';
        	chn := '00' + chn;
        	for j := length(chn)+1 to 8 do 
                chn:= chn + '0';
        End
        else
        Begin
            chn := copy(ch, 1, 6);
            ajouterzero(chn);
            delete(ch, 1, 6);
        End;
        T[n] := chn;
        n := n + 1;
	Until(ch = '');
	for i := 1 to n-1 do
	Begin
		k := binaretodecimale(T[i]);
		case k of
            0 .. 25 : ch := ch + chr(k+65);
            26 .. 51 : ch := ch + chr(k+71);
            52 .. 61 : ch := ch + chr(k-4);
            62 : ch := ch + '+';
            63 : ch := ch + '/';
        end;
    End;
    if(length(ch) mod 4 = 2) then
        ch := ch + '=='
     else if (length(ch) mod 4 = 3) then
        ch := ch + '=';
	EncodeBase64 := ch;
End;
// Decodes Base64 to String
function DecodeBase64(ch : string) : string;
var TB : Tab;
       T : Tab2;
       i, n: integer;
       chn : string;
begin
	if(ch[length(ch) - 1] = '=') then
        delete(ch, length(ch) - 1, 2)
     else if (ch[length(ch)] = '=') then
        delete(ch, length(ch), 1);
	chn := '';
	for i := 1 to length(ch) do 
	Begin
		case ch[i] of
            'A' .. 'Z' : T[i] := ord(ch[i]) - 65;
            'a' .. 'z' : T[i] := ord(ch[i]) - 71;
            '0' .. '9' :  T[i] := ord(ch[i]) + 4;
            '+' : T[i] := 62;
            '/' :  T[i] := 63;
     end;
    End;
    for i := 1 to length(ch) do
    Begin
          TB[i] := chartobinare(chr(T[i]));
          Delete(TB[i], 1, 2);
          chn := chn + TB[i];
    End;
    n := 1;
    Repeat
        ch := Copy(chn, 1, 8);
        Delete(chn, 1, 8);
        TB[n] := ch;
        n := n + 1;
	Until(length(chn) < 8);
	chn := '';
	for i := 1 to n - 1 do
	Begin
           chn := chn + chr(BinaretoDecimale(TB[i]));
    End;
    DecodeBase64 := chn;
End;
// ================================
//      PRINCIPAL PROGRAM
// ================================
begin
	writeln('Type a character : ');
	readln(jch);
	writeln('Hex : ', decimaletohex(jch[1]));
	jch := chartobinare(jch[1]);
	writeln('Bytes : ', jch);
    
end.
