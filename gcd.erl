-module(gcd).
-export([gcd/2]).

gcd(0, _) -> 0;
gcd(_, 0) -> 0;
gcd(M, N) when M rem N == 0 -> N;
gcd(M, N) -> gcd(N, M rem N).