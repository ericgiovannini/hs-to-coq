Require GHC.Err.

Instance Default__UniqFM {a} : Err.Default (UniqFM a) :=
  Err.Build_Default _ (UFM Data.IntMap.Internal.empty).
