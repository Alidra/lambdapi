constant symbol A : TYPE;
constant symbol B : TYPE;

opaque symbol test1 : (A → B) → A → B
≔ begin
  assume h1 h2;
  apply h1;
  apply h2
