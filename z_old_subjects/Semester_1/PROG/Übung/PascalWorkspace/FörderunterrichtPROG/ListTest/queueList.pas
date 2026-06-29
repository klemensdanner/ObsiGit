program Queue;

  TYPE QueuePtr = ^Queue;
  Queue = RECORD
    prev, next: QueuePtr;
    song : STRING;
  END;
  (* Node *)
  QueueList = RECORD
    first: QueuePtr; last: QueuePtr;
  END;

  procedure InsertIntoQueue(var qList; qPos: integer; pSong: string);
  var
    prev, curr, n: QueuePtr;
    counter: integer;

  begin
    New(n);
    n^.next := nil;
    n^.prev := nil;
    n^.song := pSong;

    if l.first = nil then begin
      l.first := n;
      l.last := n;
      Exit;
    end;
    