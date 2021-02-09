Program Chessboard_Game;
Uses wincrt;
Type
    Player = (Black, White);
    Chess_Piece = ( Empty , WPawn, WKnight, WBishop, WRook, WQueen, WKing,
    BPawn, BKnight, BBishop, BRook, BQueen, BKing);
    Chessboard = Array [1..8,1..8] of Chess_Piece;
Var
    CB : Chessboard;
    Turn : Player;
    g_GameEnd, g_TurnW, g_TurnB : boolean;
		x, y, n, m : integer;

Procedure Refill_Game(var T : Chessboard);
var i, j : integer;
Begin
    for i := 1 to 8 Do
    Begin
        for j := 1 to 8 Do
        Begin
            // Black chess pieces
            if ( i = 1 ) and ( ( j = 1 ) or ( j = 8 ) ) Then
                T[i][j] := BRook
            else if ( i = 1 ) and ( ( j = 2 ) or ( j = 7 ) ) Then
                T[i][j] := BKnight
            else if ( i = 1 ) and ( ( j = 3 ) or ( j = 6 ) ) Then
                T[i][j] := BBishop
            else if ( i = 1 ) and ( j = 4 ) Then
                T[i][j] := BQueen
            else if ( i = 1 ) and ( j = 5 ) Then
                T[i][j] := BKing
            else if ( i = 2 ) Then
                T[i][j] := BPawn
            // White Chess Pieces
            else if ( i = 7 ) Then
                T[i][j] := WPawn
            else if ( i = 8 ) and ( ( j = 1 ) or ( j = 8 ) ) Then
                T[i][j] := WRook
            else if ( i = 8 ) and ( ( j = 2 ) or ( j = 7 ) ) Then
                T[i][j] := WKnight
            else if ( i = 8 ) and ( ( j = 3 ) or ( j = 6 ) ) Then
                T[i][j] := WBishop
            else if ( i = 8 ) and ( j = 4 ) Then
                T[i][j] := WQueen
            else if ( i = 8 ) and ( j = 5 ) Then
                T[i][j] := WKing
            Else
                T[i][j] := Empty;
        End;
    End;
End;

Procedure Show_Game(T : Chessboard);
var i, j : integer;
Begin
	writeln('y/m=         1       2       3       4       5       6       7       8');
	writeln('_________________________________________________________________________');
    for i := 1 to 8 Do
    Begin
       	writeln('');
		write('x/n = ', i, '. ');
        for j := 1 to 8 Do
        Begin
            case T[i][j] of
                WPawn .. WKing : write('| WHITE ');
                BPawn .. BKing : write('| BLACK ');
                Else
                    write('| EMPTY ');
                End;
        End;
        write('|')
    End;
End;

Function func_BKnight(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
Begin
	b := false;
	if not(T[n][m] in [BPawn .. BKing]) then
	Begin
		if  ( ( n = x - 2 ) and ( m = y + 1) ) or
			( ( n = x - 2 ) and ( m = y - 1) ) or
			( ( n = x - 1 ) and ( m = y + 2) ) or
			( ( n = x - 1 ) and ( m = y - 2) ) or
			( ( n = x + 2 ) and ( m = y + 1) ) or
			( ( n = x + 2 ) and ( m = y - 1) ) or
			( ( n = x + 1 ) and ( m = y + 2) ) or
			( ( n = x + 1 ) and ( m = y - 2) ) then
				b := true;
	End;
	func_BKnight := b;
End;

Function func_WKnight(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
Begin
	b := false;
	if not(T[n][m] in [WPawn .. WKing]) then
	Begin
		if  ( ( n = x - 2 ) and ( m = y + 1) ) or
			( ( n = x - 2 ) and ( m = y - 1) ) or
			( ( n = x - 1 ) and ( m = y + 2) ) or
			( ( n = x - 1 ) and ( m = y - 2) ) or
			( ( n = x + 2 ) and ( m = y + 1) ) or
			( ( n = x + 2 ) and ( m = y - 1) ) or
			( ( n = x + 1 ) and ( m = y + 2) ) or
			( ( n = x + 1 ) and ( m = y - 2) ) then
				b := true;
	End;
	func_WKnight := b;
End;

Function func_BRook(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
	i, j : integer;
Begin
	b := true;
	i := x;
	j := y;
	if not(T[n][m] in [BPawn .. BKing]) then
	Begin
		Repeat
			Begin
				if (x = n) then
				Begin
					if ( y > m ) then
						i := i - 1
					else if ( y < m ) then
						i := i + 1;
				End
				else if (y = m) then
				Begin
					if ( x > n ) then
						j := j - 1
					else if ( x < n ) then
						j := j + 1;
				End
				else
					b := false;
				if (T[i][j] in [WPawn .. BKing]) then
					b := false;
			End;
		Until(b = false) or ( ( j = y ) and ( i = n ) );
	End
	else
		b := false;
	func_BRook := b;
End;

Function func_WRook(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
	i, j : integer;
Begin
	b := true;
	i := x;
	j := y;
	if not(T[n][m] in [WPawn .. WKing]) then
	Begin
		Repeat
			Begin
				if (x = n) then
				Begin
					if ( y > m ) then
						i := i - 1
					else if ( y < m ) then
						i := i + 1;
				End
				else if (y = m) then
				Begin
					if ( x > n ) then
						j := j - 1
					else if ( x < n ) then
						j := j + 1;
				End
				else
					b := false;
				if (T[i][j] in [WPawn .. BKing]) then
					b := false;
			End;
		Until(b = false) or ( ( j = y ) and ( i = n ) );
	End
	else
		b := false;
	func_WRook := b;
End;

Function func_BPawn(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
Begin
	b := false;
	if ( n = x + 1) and (m = y) and not(T[n][m] in [BPawn .. BKing]) then
		b := true
	else if ( n = x + 1) and ((m = y - 1) or (m = y + 1)) and (T[n][m] in [WPawn .. WKing]) then
		b := true
	Else
		b := false;
	func_BPawn := b;
End;

Function func_WPawn(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
Begin
	b := false;
	if ( n = x - 1) and (m = y) and not(T[n][m] in [WPawn .. WKing]) then
		b := true
	else if ( n = x - 1) and ((m = y - 1) or (m = y + 1)) and (T[n][m] in [BPawn .. BKing]) then
		b := true;
	func_WPawn := b;
End;

Function func_BBishop(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
	i, j : integer;
Begin
	i := x;
	j := y;
	b := true;
	if not(T[n][m] in [BPawn .. BKing]) then
	Begin
		Repeat
			if (x > n) and (y > m) then
			Begin
				i := i - 1;
				j := j - 1;
			End
			else if (x > n) and (y < m) then
			Begin
				i := i - 1;
				j := j + 1;
			End
			else if (x < n) and (y > m) then
			Begin
				i := i + 1;
				j := j - 1;
			End
			else if (x < n) and (y < m) then
			Begin
				i := i + 1;
				j := j + 1;
			End;
			if (T[i][j] <> EMPTY) then
				b := false;
		Until(b = false or ( (i = n - 1) and (y = m - 1) ) )
	End
	else
		b := false;
	func_BBishop := b;
End;

Function func_WBishop(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
	i, j : integer;
Begin
	i := x;
	j := y;
	b := true;
	if not(T[n][m] in [WPawn .. WKing]) then
	Begin
		Repeat
			if (x > n) and (y > m) then
			Begin
				i := i - 1;
				j := j - 1;
			End
			else if (x > n) and (y < m) then
			Begin
				i := i - 1;
				j := j + 1;
			End
			else if (x < n) and (y > m) then
			Begin
				i := i + 1;
				j := j - 1;
			End
			else if (x < n) and (y < m) then
			Begin
				i := i + 1;
				j := j + 1;
			End;
			if (T[i][j] <> EMPTY) then
				b := false;
		Until(b = false or ( (i = n - 1) and (y = m - 1) ) )
	End
	else
		b := false;
	func_WBishop := b;
End;

Function func_BQueen(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
Begin
	b := false;
	if not(T[n][m] in [BPawn .. BKing]) then
	Begin
		if ( ( x = n ) or ( y = m ) ) and ( func_BRook (T, x, y, n, m) ) then
			b := true
		else if ( ( x <> n ) and ( y <> m ) ) and ( func_BBishop (T, x, y, n, m) ) then
			b := true;
	End;
	func_BQueen := b;
End;

Function func_WQueen(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
Begin
	b := false;
	if not(T[n][m] in [WPawn .. WKing]) then
	Begin
		if ( ( x = n ) or ( y = m ) ) and ( func_WRook (T, x, y, n, m) ) then
			b := true
		else if ( ( x <> n ) and ( y <> m ) ) and ( func_WBishop (T, x, y, n, m) ) then
			b := true;
	End;
	func_WQueen := b;
End;

Function KGeneral(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
Begin
	case T[x][y] of
		BPawn : b := func_BPawn(T, x, y, n, m);
		WPawn : b := func_WPawn(T, x, y, n, m);
		BRook : b := func_BRook(T, x, y, n, m);
		WRook : b := func_WRook(T, x, y, n, m);
		BBishop : b := func_BBishop(T, x, y, n, m);
		WBishop : b := func_WBishop(T, x, y, n, m);
		BKnight : b := func_BKnight(T, x, y, n, m);
		WKnight : b := func_WKnight(T, x, y, n, m);
		BQueen : b := func_BQueen(T, x, y, n, m);
		WQueen : b := func_WQueen(T, x, y, n, m);
	else
		b := false;
	end;
	KGeneral := b;
End;

Function func_BKing(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
	i, j : integer;
Begin
	b := true;
	if not(T[n][m] in [BPawn .. BKing]) then
	Begin
		if  ( ( n = x ) and ( ( m = y + 1 ) or ( m = y -1 ) ) )
			or ( ( n = x + 1 ) and ( ( m = y + 1 ) or ( m = y - 1 ) or ( m = y ) ) )
			or ( ( n = x + 1 ) and ( ( m = y + 1 ) or ( m = y - 1 ) or ( m = y ) ) ) then
				Begin
					i := 1;
					j := 1;
					Repeat
						if KGeneral (T, i, j, n, m) and (T[i][j] in [WPawn .. WKing]) then
							b := false;
						if ( j = 8 ) and ( i < 8 ) then
						Begin
							i := i + 1;
							j := 1;
						End
						else
							j := j + 1;
					Until (b = false) or ( ( i >= 8 ) and ( j >= 8 ) );
				End
			else
				b := false;
	End
	else
		b := false;
	func_BKing := b;
End;

Function func_WKing(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
	i, j : integer;
Begin
	b := true;
	if not(T[n][m] in [WPawn .. WKing]) then
	Begin
		if  ( ( n = x ) and ( ( m = y + 1 ) or ( m = y -1 ) ) )
			or ( ( n = x + 1 ) and ( ( m = y + 1 ) or ( m = y - 1 ) or ( m = y ) ) )
			or ( ( n = x + 1 ) and ( ( m = y + 1 ) or ( m = y - 1 ) or ( m = y ) ) ) then
				Begin
					i := 1;
					j := 1;
					Repeat
						if KGeneral (T, i, j, n, m) and ( T[i][j] in [BPawn .. BKing] ) then
							b := false;
						if ( j = 8 ) and ( i < 8 ) then
						Begin
							i := i + 1;
							j := 1;
						End
						else
							j := j + 1;
					Until (b = false) or ( ( i >= 8 ) and ( j >= 8 ) );
				End
			else
				b := false;
	End
	else
		b := false;
	func_WKing := b;
End;

Function func_General(T : Chessboard ; x, y, n, m : integer) : boolean;
var b : boolean;
Begin
	case T[x][y] of
		BPawn : b := func_BPawn(T, x, y, n, m);
		WPawn : b := func_WPawn(T, x, y, n, m);
		BRook : b := func_BRook(T, x, y, n, m);
		WRook : b := func_WRook(T, x, y, n, m);
		BBishop : b := func_BBishop(T, x, y, n, m);
		WBishop : b := func_WBishop(T, x, y, n, m);
		BKnight : b := func_BKnight(T, x, y, n, m);
		WKnight : b := func_WKnight(T, x, y, n, m);
		BQueen : b := func_BQueen(T, x, y, n, m);
		WQueen : b := func_WQueen(T, x, y, n, m);
		BKing : b := func_BKing(T, x, y, n, m);
		WKing : b := func_WKing(T, x, y, n, m);
	else
		b := false;
	end;
	func_General := b;
End;

Procedure func_Position_B_King(T : Chessboard ; var Px, Py : integer);
var i, j : integer;
Begin
	for i := 1 to 8 do
		for j := 1 to 8 do
			if ( T[i][j] = BKing ) then
				Begin
					i := Px;
					j := Py;
					break;
				End;
End;

Procedure func_Position_W_King(T : Chessboard ; var Px, Py : integer);
var i, j : integer;
Begin
	for i := 1 to 8 do
		for j := 1 to 8 do
			if ( T[i][j] = WKing ) then
				Begin
					i := Px;
					j := Py;
					break;
				End;
End;

Function func_B_Check(T : Chessboard ; var Px, Py : integer) : boolean;
var b : boolean;
	i, j, Pone, Ptwo : integer;
Begin
	b := false;
	i := 1;
	j := 1;
	Px := 1;
	Py := 1;
	func_Position_B_King(T, Pone, Ptwo);
	Repeat
		if ( T[i][j] in [WPawn .. WKing]) then
		Begin
			if ( func_General(T, i, j, Pone, Ptwo) ) then
			Begin
				b := true;
				Px := i;
				Py := j;
			End;
		End;
		if ( j = 8 ) and ( i < 8 ) then
		Begin
			i := i + 1;
			j := 1;
		End
		else
			j := j + 1;
	Until (b = true) or ( ( i >= 8 ) and ( j >= 8 ) );
	Func_B_Check := b;
End;

Function func_W_Check(T : Chessboard ; var Px, Py : integer) : boolean;
var b : boolean;
	i, j, Pone, Ptwo : integer;
Begin
	b := false;
	i := 1;
	j := 1;
	Px := 1;
	Py := 1;
	func_Position_W_King(T, Pone, Ptwo);
	Repeat
		if ( T[i][j] in [BPawn .. BKing]) then
		Begin
			if ( func_General(T, i, j, Pone, Ptwo) ) then
			Begin
				b := true;
				Px := i;
				Py := j;
			End;
		End;
		if ( j = 8 ) and ( i < 8 ) then
		Begin
			i := i + 1;
			j := 1;
		End
		else
			j := j + 1;
	Until (b = true) or ( ( i >= 8 ) and ( j >= 8 ) );
	Func_W_Check := b;
End;

function Checkmate( T : Chessboard ) : boolean;
var b : Boolean;
	P1, P2, Px, Py : integer;
Begin
	b := false;
	If ( func_W_Check(T, P1, P2) ) or ( func_B_Check(T, Px, Py) ) then
		b := true;
	Checkmate := true;
End;

Begin
	Turn := White;
	Refill_Game(CB);
	g_GameEnd := false;
	g_TurnW := False;
	g_TurnB := False;
	Repeat
		ClrScr;
		Show_Game(CB);
		writeln('');
		writeln('_________________________________________________________________________');
		if( Turn = White ) then
		Begin
			Turn := Black;
			writeln('Black is playing right now.')
		End
		else
		Begin
			Turn := White;
			writeln('White is playing right now.')
		End;
		Repeat
			writeln('Enter the coordinates of the piece you want to move');
			writeln('x = ');
			read(x);
			writeln('y = ');
			read(y);
			writeln('Enter the coordinates of the place you want to move your piece to');
			writeln('n = ');
			read(n);
			writeln('m = ');
			read(m);
			if ( Turn = Black) and (CB[x][y] in [BPawn .. BKing]) then
			Begin
				g_TurnW := False;
				g_TurnB := True;
			End
			else if ( Turn = White) and (CB[x][y] in [WPawn .. WKing]) then
			Begin
				g_TurnB := False;
				g_TurnW := True;
			End
			else
			Begin
				g_TurnB := False;
				g_TurnW := False;
			End;
		Until ( (g_TurnW) or (g_TurnB) ) and ( func_General(CB, x, y, n, m) ) or ( x > 8 ) or ( y > 8 );
		CB[n][m] := CB[x][y];
		CB[x][y] := EMPTY;
		//g_GameEnd := Checkmate(CB);
	Until(g_GameEnd);
	if(g_TurnB) then
		writeln('Black Won!')
	else if(g_TurnW) then
		writeln('White Won!')
	else
		writeln('Stalemate!');
End.