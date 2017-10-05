(* Default settings (from HsToCoq.Coq.Preamble) *)

Generalizable All Variables.

Set Implicit Arguments.
Set Maximal Implicit Insertion.
Unset Strict Implicit.
Unset Printing Implicit Defensive.

(* Preamble *)

(* Converted imports: *)

Require Data.Bool.
Require Data.Either.
Require Data.Eq.
Require GHC.List.
Require Data.Maybe.
Require Data.Monoid.
Require Data.Ord.
Require Data.Proxy.
Require GHC.Arr.
Require GHC.Base.
Require GHC.Generics.
Require GHC.Num.
(* Require #. *)
Require Coq.Program.Basics.
Require GHC.Tuple.
Require GHC.Types.

Definition zero : BinNums.Z := BinNums.Z0.
Definition one  : BinNums.Z := BinNums.Zpos BinNums.xH.

(*
Definition hashDotop___ {b} {c} {a} `{GHC.Types.Coercible b c}
    : (b -> c) -> (a -> b) -> (a -> c) :=
  fun arg_76__ => match arg_76__ with | _f => GHC.Base.coerce end.

Infix "hashDot" := (hashDotop___) (at level 99).

Notation "'_hashDot_'" := (hashDotop___).
*)

(* Converted declarations: *)

Local Definition instance_Foldable_option_foldl : forall {b} {a},
                                                    (b -> a -> b) -> b -> option a -> b :=
  fun {b} {a} =>
    fun arg_313__ arg_314__ arg_315__ =>
      match arg_313__ , arg_314__ , arg_315__ with
        | _ , z , None => z
        | f , z , (Some x) => f z x
      end.

(*
Local Definition instance_Foldable_option_foldl1 : forall {a},
                                                     (a -> a -> a) -> option a -> a :=
  fun {a} =>
    fun arg_44__ arg_45__ =>
      match arg_44__ , arg_45__ with
        | f , xs => let mf :=
                      fun arg_46__ arg_47__ =>
                        match arg_46__ , arg_47__ with
                          | m , y => Some (match m with | None => y | (Some x) => f x y end)
                        end in
                    Data.Maybe.fromMaybe (GHC.Base.errorWithoutStackTrace
                                         &"foldl1: empty structure") (instance_Foldable_option_foldl mf None xs)
      end. *)

Local Definition instance_Foldable_option_foldr' : forall {a} {b},
                                                     (a -> b -> b) -> b -> option a -> b :=
  fun {a} {b} =>
    fun arg_9__ arg_10__ arg_11__ =>
      match arg_9__ , arg_10__ , arg_11__ with
        | f , z0 , xs => let f' :=
                           fun arg_12__ arg_13__ arg_14__ =>
                             match arg_12__ , arg_13__ , arg_14__ with
                               | k , x , z => GHC.Base.op_zdzn__ k (f x z)
                             end in
                         instance_Foldable_option_foldl f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable_option_foldr : forall {a} {b},
                                                    (a -> b -> b) -> b -> option a -> b :=
  fun {a} {b} =>
    fun arg_308__ arg_309__ arg_310__ =>
      match arg_308__ , arg_309__ , arg_310__ with
        | _ , z , None => z
        | f , z , (Some x) => f x z
      end.

(*
Local Definition instance_Foldable_option_foldr1 : forall {a},
                                                     (a -> a -> a) -> option a -> a :=
  fun {a} =>
    fun arg_34__ arg_35__ =>
      match arg_34__ , arg_35__ with
        | f , xs => let mf :=
                      fun arg_36__ arg_37__ =>
                        match arg_36__ , arg_37__ with
                          | x , m => Some (match m with | None => x | (Some y) => f x y end)
                        end in
                    Data.Maybe.fromMaybe (GHC.Base.errorWithoutStackTrace
                                         &"foldr1: empty structure") (instance_Foldable_option_foldr mf None xs)
      end.
*)

Local Definition instance_Foldable_option_null : forall {a}, option a -> bool :=
  fun {a} => instance_Foldable_option_foldr (fun arg_61__ arg_62__ => false) true.

Local Definition instance_Foldable_option_toList : forall {a},
                                                     option a -> list a :=
  fun {a} =>
    fun arg_54__ =>
      match arg_54__ with
        | t => Base.build (fun _ arg_55__ arg_56__ =>
                                match arg_55__ , arg_56__ with
                                  | c , n => instance_Foldable_option_foldr c n t
                                end)
      end.

Local Definition instance_Foldable_option_foldl' : forall {b} {a},
                                                     (b -> a -> b) -> b -> option a -> b :=
  fun {b} {a} =>
    fun arg_24__ arg_25__ arg_26__ =>
      match arg_24__ , arg_25__ , arg_26__ with
        | f , z0 , xs => let f' :=
                           fun arg_27__ arg_28__ arg_29__ =>
                             match arg_27__ , arg_28__ , arg_29__ with
                               | x , k , z => GHC.Base.op_zdzn__ k (f z x)
                             end in
                         instance_Foldable_option_foldr f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable_option_length : forall {a},
                                                     option a -> GHC.Num.Int :=
  fun {a} =>
    instance_Foldable_option_foldl' (fun arg_64__ arg_65__ =>
                                      match arg_64__ , arg_65__ with
                                        | c , _ => GHC.Num.op_zp__ c one
                                      end) zero.

Local Definition instance_Foldable_option_foldMap : forall {m} {a},
                                                      forall `{GHC.Base.Monoid m}, (a -> m) -> option a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun arg_1__ =>
      match arg_1__ with
        | f => instance_Foldable_option_foldr (Coq.Program.Basics.compose
                                              GHC.Base.mappend f) GHC.Base.mempty
      end.
(*
Local Definition instance_Foldable_option_product : forall {a},
                                                      forall `{GHC.Num.Num a}, option a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hashDot getProduct (instance_Foldable_option_foldMap Data.Monoid.Product).

Local Definition instance_Foldable_option_sum : forall {a},
                                                  forall `{GHC.Num.Num a}, option a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hashDot getSum (instance_Foldable_option_foldMap Data.Monoid.Sum).
*)
Local Definition instance_Foldable_option_fold : forall {m},
                                                   forall `{GHC.Base.Monoid m}, option m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_option_foldMap GHC.Base.id.

Local Definition instance_Foldable_list_elem : forall {a},
                                                 forall `{GHC.Base.Eq_ a}, a -> list a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => GHC.List.elem.

Local Definition instance_Foldable_list_foldl : forall {b} {a},
                                                  (b -> a -> b) -> b -> list a -> b :=
  fun {b} {a} => Base.foldl.

Local Definition instance_Foldable_list_foldr' : forall {a} {b},
                                                   (a -> b -> b) -> b -> list a -> b :=
  fun {a} {b} =>
    fun arg_9__ arg_10__ arg_11__ =>
      match arg_9__ , arg_10__ , arg_11__ with
        | f , z0 , xs => let f' :=
                           fun arg_12__ arg_13__ arg_14__ =>
                             match arg_12__ , arg_13__ , arg_14__ with
                               | k , x , z => GHC.Base.op_zdzn__ k (f x z)
                             end in
                         instance_Foldable_list_foldl f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable_list_foldl' : forall {b} {a},
                                                   (b -> a -> b) -> b -> list a -> b :=
  fun {b} {a} => Base.foldl'.

Local Definition instance_Foldable_list_foldl1 : forall {a},
                                                   (a -> a -> a) -> list a -> a :=
  fun {a} => GHC.List.foldl1.

Local Definition instance_Foldable_list_foldr : forall {a} {b},
                                                  (a -> b -> b) -> b -> list a -> b :=
  fun {a} {b} => GHC.Base.foldr.

Local Definition instance_Foldable_list_foldMap : forall {m} {a},
                                                    forall `{GHC.Base.Monoid m}, (a -> m) -> list a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun arg_1__ =>
      match arg_1__ with
        | f => instance_Foldable_list_foldr (Coq.Program.Basics.compose GHC.Base.mappend
                                                                        f) GHC.Base.mempty
      end.

Local Definition instance_Foldable_list_fold : forall {m},
                                                 forall `{GHC.Base.Monoid m}, list m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_list_foldMap GHC.Base.id.

Local Definition instance_Foldable_list_foldr1 : forall {a},
                                                   (a -> a -> a) -> list a -> a :=
  fun {a} => GHC.List.foldr1.

Local Definition instance_Foldable_list_length : forall {a},
                                                   list a -> GHC.Num.Int :=
  fun {a} => GHC.List.length.

Local Definition instance_Foldable_list_maximum : forall {a},
                                                    forall `{GHC.Base.Ord a}, list a -> a :=
  fun {a} `{GHC.Base.Ord a} => GHC.List.maximum.

Local Definition instance_Foldable_list_minimum : forall {a},
                                                    forall `{GHC.Base.Ord a}, list a -> a :=
  fun {a} `{GHC.Base.Ord a} => GHC.List.minimum.

Local Definition instance_Foldable_list_null : forall {a}, list a -> bool :=
  fun {a} => GHC.List.null.

Local Definition instance_Foldable_list_product : forall {a},
                                                    forall `{GHC.Num.Num a}, list a -> a :=
  fun {a} `{GHC.Num.Num a} => GHC.List.product.

Local Definition instance_Foldable_list_sum : forall {a},
                                                forall `{GHC.Num.Num a}, list a -> a :=
  fun {a} `{GHC.Num.Num a} => GHC.List.sum.

Local Definition instance_Foldable_list_toList : forall {a}, list a -> list a :=
  fun {a} => GHC.Base.id.

(*
Local Definition instance_Foldable__GHC_Tuple_____a__foldMap : forall {m} {a},
                                                                 forall `{GHC.Base.Monoid m},
                                                                   (a -> m) -> (a * a) -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun arg_286__ arg_287__ =>
      match arg_286__ , arg_287__ with
        | f , (pair _ y) => f y
      end.


Local Definition instance_Foldable__GHC_Tuple_____a__foldl : forall {b} {a},
                                                               (b -> a -> b) -> b -> (a * a) -> b :=
  fun {b} {a} =>
    fun arg_19__ arg_20__ arg_21__ =>
      match arg_19__ , arg_20__ , arg_21__ with
        | f , z , t => Data.Monoid.appEndo (Data.Monoid.getDual (instance_Foldable__GHC_Tuple_____a__foldMap
                                        (Coq.Program.Basics.compose Data.Monoid.Dual (Coq.Program.Basics.compose
                                                                    Data.Monoid.Endo (GHC.Base.flip f))) t)) z
      end.

Local Definition instance_Foldable__GHC_Tuple_____a__foldl1 : forall {a},
                                                                (a -> a -> a) -> (GHC.Tuple.[,] a) a -> a :=
  fun {a} =>
    fun arg_44__ arg_45__ =>
      match arg_44__ , arg_45__ with
        | f , xs => let mf :=
                      fun arg_46__ arg_47__ =>
                        match arg_46__ , arg_47__ with
                          | m , y => Some (match m with | None => y | (Some x) => f x y end)
                        end in
                    Data.Maybe.fromMaybe (GHC.Base.errorWithoutStackTrace
                                         &"foldl1: empty structure") (instance_Foldable__GHC_Tuple_____a__foldl mf None
                                                                     xs)
      end.

Local Definition instance_Foldable__GHC_Tuple_____a__foldr' : forall {a} {b},
                                                                (a -> b -> b) -> b -> (GHC.Tuple.[,] a) a -> b :=
  fun {a} {b} =>
    fun arg_9__ arg_10__ arg_11__ =>
      match arg_9__ , arg_10__ , arg_11__ with
        | f , z0 , xs => let f' :=
                           fun arg_12__ arg_13__ arg_14__ =>
                             match arg_12__ , arg_13__ , arg_14__ with
                               | k , x , z => GHC.Base.op_zdzn__ k (f x z)
                             end in
                         instance_Foldable__GHC_Tuple_____a__foldl f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable__GHC_Tuple_____a__product : forall {a},
                                                                 forall `{GHC.Num.Num a}, (GHC.Tuple.[,] a) a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hashDot getProduct (instance_Foldable__GHC_Tuple_____a__foldMap
            Data.Monoid.Product).

Local Definition instance_Foldable__GHC_Tuple_____a__sum : forall {a},
                                                             forall `{GHC.Num.Num a}, (GHC.Tuple.[,] a) a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hashDot getSum (instance_Foldable__GHC_Tuple_____a__foldMap Data.Monoid.Sum).

Local Definition instance_Foldable__GHC_Tuple_____a__foldr : forall {a} {b},
                                                               (a -> b -> b) -> b -> (GHC.Tuple.[,] a) a -> b :=
  fun {a} {b} =>
    fun arg_290__ arg_291__ arg_292__ =>
      match arg_290__ , arg_291__ , arg_292__ with
        | f , z , (pair _ y) => f y z
      end.

Local Definition instance_Foldable__GHC_Tuple_____a__foldr1 : forall {a},
                                                                (a -> a -> a) -> (GHC.Tuple.[,] a) a -> a :=
  fun {a} =>
    fun arg_34__ arg_35__ =>
      match arg_34__ , arg_35__ with
        | f , xs => let mf :=
                      fun arg_36__ arg_37__ =>
                        match arg_36__ , arg_37__ with
                          | x , m => Some (match m with | None => x | (Some y) => f x y end)
                        end in
                    Data.Maybe.fromMaybe (GHC.Base.errorWithoutStackTrace
                                         &"foldr1: empty structure") (instance_Foldable__GHC_Tuple_____a__foldr mf None
                                                                     xs)
      end.

Local Definition instance_Foldable__GHC_Tuple_____a__null : forall {a},
                                                              (GHC.Tuple.[,] a) a -> bool :=
  fun {a} =>
    instance_Foldable__GHC_Tuple_____a__foldr (fun arg_61__ arg_62__ => false) true.

Local Definition instance_Foldable__GHC_Tuple_____a__toList : forall {a},
                                                                (GHC.Tuple.[,] a) a -> list a :=
  fun {a} =>
    fun arg_54__ =>
      match arg_54__ with
        | t => Base.build (fun arg_55__ arg_56__ =>
                                match arg_55__ , arg_56__ with
                                  | c , n => instance_Foldable__GHC_Tuple_____a__foldr c n t
                                end)
      end.

Local Definition instance_Foldable__GHC_Tuple_____a__foldl' : forall {b} {a},
                                                                (b -> a -> b) -> b -> (GHC.Tuple.[,] a) a -> b :=
  fun {b} {a} =>
    fun arg_24__ arg_25__ arg_26__ =>
      match arg_24__ , arg_25__ , arg_26__ with
        | f , z0 , xs => let f' :=
                           fun arg_27__ arg_28__ arg_29__ =>
                             match arg_27__ , arg_28__ , arg_29__ with
                               | x , k , z => GHC.Base.op_zdzn__ k (f z x)
                             end in
                         instance_Foldable__GHC_Tuple_____a__foldr f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable__GHC_Tuple_____a__length : forall {a},
                                                                (GHC.Tuple.[,] a) a -> GHC.Num.Int :=
  fun {a} =>
    instance_Foldable__GHC_Tuple_____a__foldl' (fun arg_64__ arg_65__ =>
                                                 match arg_64__ , arg_65__ with
                                                   | c , _ => GHC.Num.op_zp__ c one
                                                 end) #0.

Local Definition instance_Foldable__GHC_Arr_Array_i__foldl : forall {b} {a},
                                                               (b -> a -> b) -> b -> (GHC.Arr.Array i) a -> b :=
  fun {b} {a} => GHC.Arr.foldlElems.

Local Definition instance_Foldable__GHC_Arr_Array_i__foldl' : forall {b} {a},
                                                                (b -> a -> b) -> b -> (GHC.Arr.Array i) a -> b :=
  fun {b} {a} => GHC.Arr.foldlElems'.

Local Definition instance_Foldable__GHC_Arr_Array_i__foldl1 : forall {a},
                                                                (a -> a -> a) -> (GHC.Arr.Array i) a -> a :=
  fun {a} => GHC.Arr.foldl1Elems.

Local Definition instance_Foldable__GHC_Arr_Array_i__foldr : forall {a} {b},
                                                               (a -> b -> b) -> b -> (GHC.Arr.Array i) a -> b :=
  fun {a} {b} => GHC.Arr.foldrElems.

Local Definition instance_Foldable__GHC_Arr_Array_i__foldMap : forall {m} {a},
                                                                 forall `{GHC.Base.Monoid m},
                                                                   (a -> m) -> (GHC.Arr.Array i) a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun arg_1__ =>
      match arg_1__ with
        | f => instance_Foldable__GHC_Arr_Array_i__foldr (Coq.Program.Basics.compose
                                                         GHC.Base.mappend f) GHC.Base.mempty
      end.

Local Definition instance_Foldable__GHC_Arr_Array_i__product : forall {a},
                                                                 forall `{GHC.Num.Num a}, (GHC.Arr.Array i) a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hashDot getProduct (instance_Foldable__GHC_Arr_Array_i__foldMap
            Data.Monoid.Product).

Local Definition instance_Foldable__GHC_Arr_Array_i__sum : forall {a},
                                                             forall `{GHC.Num.Num a}, (GHC.Arr.Array i) a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hashDot getSum (instance_Foldable__GHC_Arr_Array_i__foldMap Data.Monoid.Sum).

Local Definition instance_Foldable__GHC_Arr_Array_i__fold : forall {m},
                                                              forall `{GHC.Base.Monoid m},
                                                                (GHC.Arr.Array i) m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable__GHC_Arr_Array_i__foldMap GHC.Base.id.

Local Definition instance_Foldable__GHC_Arr_Array_i__foldr' : forall {a} {b},
                                                                (a -> b -> b) -> b -> (GHC.Arr.Array i) a -> b :=
  fun {a} {b} => GHC.Arr.foldrElems'.

Local Definition instance_Foldable__GHC_Arr_Array_i__foldr1 : forall {a},
                                                                (a -> a -> a) -> (GHC.Arr.Array i) a -> a :=
  fun {a} => GHC.Arr.foldr1Elems.

Local Definition instance_Foldable__GHC_Arr_Array_i__length : forall {a},
                                                                (GHC.Arr.Array i) a -> GHC.Num.Int :=
  fun {a} => GHC.Arr.numElements.

Local Definition instance_Foldable__GHC_Arr_Array_i__null : forall {a},
                                                              (GHC.Arr.Array i) a -> bool :=
  fun {a} =>
    fun arg_283__ =>
      match arg_283__ with
        | a => GHC.Base.op_zeze__ (GHC.Arr.numElements a) #0
      end.

Local Definition instance_Foldable__GHC_Arr_Array_i__toList : forall {a},
                                                                (GHC.Arr.Array i) a -> list a :=
  fun {a} => GHC.Arr.elems.
*)

Local Definition instance_Foldable_Data_Proxy_Proxy_elem : forall {a},
                                                             forall `{GHC.Base.Eq_ a},
                                                               a -> Data.Proxy.Proxy a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => fun arg_275__ arg_276__ => false.

Local Definition instance_Foldable_Data_Proxy_Proxy_fold : forall {m},
                                                             forall `{GHC.Base.Monoid m}, Data.Proxy.Proxy m -> m :=
  fun {m} `{GHC.Base.Monoid m} => fun arg_254__ => GHC.Base.mempty.

Local Definition instance_Foldable_Data_Proxy_Proxy_foldMap : forall {m} {a},
                                                                forall `{GHC.Base.Monoid m},
                                                                  (a -> m) -> Data.Proxy.Proxy a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun arg_252__ arg_253__ => GHC.Base.mempty.

Local Definition instance_Foldable_Data_Proxy_Proxy_foldl : forall {b} {a},
                                                              (b -> a -> b) -> b -> Data.Proxy.Proxy a -> b :=
  fun {b} {a} =>
    fun arg_259__ arg_260__ arg_261__ =>
      match arg_259__ , arg_260__ , arg_261__ with
        | _ , z , _ => z
      end.

Local Definition instance_Foldable_Data_Proxy_Proxy_foldr' : forall {a} {b},
                                                               (a -> b -> b) -> b -> Data.Proxy.Proxy a -> b :=
  fun {a} {b} =>
    fun arg_9__ arg_10__ arg_11__ =>
      match arg_9__ , arg_10__ , arg_11__ with
        | f , z0 , xs => let f' :=
                           fun arg_12__ arg_13__ arg_14__ =>
                             match arg_12__ , arg_13__ , arg_14__ with
                               | k , x , z => GHC.Base.op_zdzn__ k (f x z)
                             end in
                         instance_Foldable_Data_Proxy_Proxy_foldl f' GHC.Base.id xs z0
      end.

(*
Local Definition instance_Foldable_Data_Proxy_Proxy_foldl1 : forall {a},
                                                               (a -> a -> a) -> Data.Proxy.Proxy a -> a :=
  fun {a} =>
    fun arg_263__ arg_264__ => GHC.Base.errorWithoutStackTrace &"foldl1: Proxy".
*)
Local Definition instance_Foldable_Data_Proxy_Proxy_foldr : forall {a} {b},
                                                              (a -> b -> b) -> b -> Data.Proxy.Proxy a -> b :=
  fun {a} {b} =>
    fun arg_255__ arg_256__ arg_257__ =>
      match arg_255__ , arg_256__ , arg_257__ with
        | _ , z , _ => z
      end.

Local Definition instance_Foldable_Data_Proxy_Proxy_toList : forall {a},
                                                               Data.Proxy.Proxy a -> list a :=
  fun {a} =>
    fun arg_54__ =>
      match arg_54__ with
        | t => Base.build (fun _ arg_55__ arg_56__ =>
                                match arg_55__ , arg_56__ with
                                  | c , n => instance_Foldable_Data_Proxy_Proxy_foldr c n t
                                end)
      end.

Local Definition instance_Foldable_Data_Proxy_Proxy_foldl' : forall {b} {a},
                                                               (b -> a -> b) -> b -> Data.Proxy.Proxy a -> b :=
  fun {b} {a} =>
    fun arg_24__ arg_25__ arg_26__ =>
      match arg_24__ , arg_25__ , arg_26__ with
        | f , z0 , xs => let f' :=
                           fun arg_27__ arg_28__ arg_29__ =>
                             match arg_27__ , arg_28__ , arg_29__ with
                               | x , k , z => GHC.Base.op_zdzn__ k (f z x)
                             end in
                         instance_Foldable_Data_Proxy_Proxy_foldr f' GHC.Base.id xs z0
      end.

(*
Local Definition instance_Foldable_Data_Proxy_Proxy_foldr1 : forall {a},
                                                               (a -> a -> a) -> Data.Proxy.Proxy a -> a :=
  fun {a} =>
    fun arg_267__ arg_268__ => GHC.Base.errorWithoutStackTrace &"foldr1: Proxy".
*)
Local Definition instance_Foldable_Data_Proxy_Proxy_length : forall {a},
                                                               Data.Proxy.Proxy a -> GHC.Num.Int :=
  fun {a} => fun arg_271__ => BinNums.Z0.

Local Definition instance_Foldable_Data_Proxy_Proxy_null : forall {a},
                                                             Data.Proxy.Proxy a -> bool :=
  fun {a} => fun arg_274__ => true.

Local Definition instance_Foldable_Data_Proxy_Proxy_product : forall {a},
                                                                forall `{GHC.Num.Num a}, Data.Proxy.Proxy a -> a :=
  fun {a} `{GHC.Num.Num a} => fun arg_280__ => GHC.Num.fromInteger one.

Local Definition instance_Foldable_Data_Proxy_Proxy_sum : forall {a},
                                                            forall `{GHC.Num.Num a}, Data.Proxy.Proxy a -> a :=
  fun {a} `{GHC.Num.Num a} => fun arg_277__ => GHC.Num.fromInteger BinNums.Z0.

(*
Local Definition instance_Foldable_Data_Monoid_Dual_elem : forall {a},
                                                             forall `{GHC.Base.Eq_ a},
                                                               a -> Data.Monoid.Dual a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} =>
    hashDot (fun arg_236__ => Coq.Program.Basics.compose arg_236__ getDual)
            GHC.Base.op_zeze__.

Local Definition instance_Foldable_Data_Monoid_Dual_foldMap : forall {m} {a},
                                                                forall `{GHC.Base.Monoid m},
                                                                  (a -> m) -> Data.Monoid.Dual a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} => GHC.Base.coerce.

Local Definition instance_Foldable_Data_Monoid_Dual_fold : forall {m},
                                                             forall `{GHC.Base.Monoid m}, Data.Monoid.Dual m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Dual_foldMap GHC.Base.id.

Local Definition instance_Foldable_Data_Monoid_Dual_foldl : forall {b} {a},
                                                              (b -> a -> b) -> b -> Data.Monoid.Dual a -> b :=
  fun {b} {a} => GHC.Base.coerce.

Local Definition instance_Foldable_Data_Monoid_Dual_foldl' : forall {b} {a},
                                                               (b -> a -> b) -> b -> Data.Monoid.Dual a -> b :=
  fun {b} {a} => GHC.Base.coerce.

Local Definition instance_Foldable_Data_Monoid_Dual_foldl1 : forall {a},
                                                               (a -> a -> a) -> Data.Monoid.Dual a -> a :=
  fun {a} => fun arg_238__ => getDual.

Local Definition instance_Foldable_Data_Monoid_Dual_foldr : forall {a} {b},
                                                              (a -> b -> b) -> b -> Data.Monoid.Dual a -> b :=
  fun {a} {b} =>
    fun arg_239__ arg_240__ arg_241__ =>
      match arg_239__ , arg_240__ , arg_241__ with
        | f , z , (Data.Monoid.Dual x) => f x z
      end.

Local Definition instance_Foldable_Data_Monoid_Dual_foldr' : forall {a} {b},
                                                               (a -> b -> b) -> b -> Data.Monoid.Dual a -> b :=
  fun {a} {b} => instance_Foldable_Data_Monoid_Dual_foldr.

Local Definition instance_Foldable_Data_Monoid_Dual_foldr1 : forall {a},
                                                               (a -> a -> a) -> Data.Monoid.Dual a -> a :=
  fun {a} => fun arg_244__ => getDual.

Local Definition instance_Foldable_Data_Monoid_Dual_length : forall {a},
                                                               Data.Monoid.Dual a -> GHC.Num.Int :=
  fun {a} => fun arg_245__ => one.

Local Definition instance_Foldable_Data_Monoid_Dual_maximum : forall {a},
                                                                forall `{GHC.Base.Ord a}, Data.Monoid.Dual a -> a :=
  fun {a} `{GHC.Base.Ord a} => getDual.

Local Definition instance_Foldable_Data_Monoid_Dual_minimum : forall {a},
                                                                forall `{GHC.Base.Ord a}, Data.Monoid.Dual a -> a :=
  fun {a} `{GHC.Base.Ord a} => getDual.

Local Definition instance_Foldable_Data_Monoid_Dual_null : forall {a},
                                                             Data.Monoid.Dual a -> bool :=
  fun {a} => fun arg_248__ => false.

Local Definition instance_Foldable_Data_Monoid_Dual_product : forall {a},
                                                                forall `{GHC.Num.Num a}, Data.Monoid.Dual a -> a :=
  fun {a} `{GHC.Num.Num a} => getDual.

Local Definition instance_Foldable_Data_Monoid_Dual_sum : forall {a},
                                                            forall `{GHC.Num.Num a}, Data.Monoid.Dual a -> a :=
  fun {a} `{GHC.Num.Num a} => getDual.

Local Definition instance_Foldable_Data_Monoid_Dual_toList : forall {a},
                                                               Data.Monoid.Dual a -> list a :=
  fun {a} =>
    fun arg_249__ => match arg_249__ with | (Data.Monoid.Dual x) => cons x nil end.

Local Definition instance_Foldable_Data_Monoid_Sum_elem : forall {a},
                                                            forall `{GHC.Base.Eq_ a}, a -> Data.Monoid.Sum a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} =>
    hashDot (fun arg_220__ => Coq.Program.Basics.compose arg_220__ getSum)
            GHC.Base.op_zeze__.

Local Definition instance_Foldable_Data_Monoid_Sum_foldMap : forall {m} {a},
                                                               forall `{GHC.Base.Monoid m},
                                                                 (a -> m) -> Data.Monoid.Sum a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} => GHC.Base.coerce.

Local Definition instance_Foldable_Data_Monoid_Sum_fold : forall {m},
                                                            forall `{GHC.Base.Monoid m}, Data.Monoid.Sum m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Sum_foldMap GHC.Base.id.

Local Definition instance_Foldable_Data_Monoid_Sum_foldl : forall {b} {a},
                                                             (b -> a -> b) -> b -> Data.Monoid.Sum a -> b :=
  fun {b} {a} => GHC.Base.coerce.

Local Definition instance_Foldable_Data_Monoid_Sum_foldl' : forall {b} {a},
                                                              (b -> a -> b) -> b -> Data.Monoid.Sum a -> b :=
  fun {b} {a} => GHC.Base.coerce.

Local Definition instance_Foldable_Data_Monoid_Sum_foldl1 : forall {a},
                                                              (a -> a -> a) -> Data.Monoid.Sum a -> a :=
  fun {a} => fun arg_222__ => getSum.

Local Definition instance_Foldable_Data_Monoid_Sum_foldr : forall {a} {b},
                                                             (a -> b -> b) -> b -> Data.Monoid.Sum a -> b :=
  fun {a} {b} =>
    fun arg_223__ arg_224__ arg_225__ =>
      match arg_223__ , arg_224__ , arg_225__ with
        | f , z , (Data.Monoid.Sum x) => f x z
      end.

Local Definition instance_Foldable_Data_Monoid_Sum_foldr' : forall {a} {b},
                                                              (a -> b -> b) -> b -> Data.Monoid.Sum a -> b :=
  fun {a} {b} => instance_Foldable_Data_Monoid_Sum_foldr.

Local Definition instance_Foldable_Data_Monoid_Sum_foldr1 : forall {a},
                                                              (a -> a -> a) -> Data.Monoid.Sum a -> a :=
  fun {a} => fun arg_228__ => getSum.

Local Definition instance_Foldable_Data_Monoid_Sum_length : forall {a},
                                                              Data.Monoid.Sum a -> GHC.Num.Int :=
  fun {a} => fun arg_229__ => one.

Local Definition instance_Foldable_Data_Monoid_Sum_maximum : forall {a},
                                                               forall `{GHC.Base.Ord a}, Data.Monoid.Sum a -> a :=
  fun {a} `{GHC.Base.Ord a} => getSum.

Local Definition instance_Foldable_Data_Monoid_Sum_minimum : forall {a},
                                                               forall `{GHC.Base.Ord a}, Data.Monoid.Sum a -> a :=
  fun {a} `{GHC.Base.Ord a} => getSum.

Local Definition instance_Foldable_Data_Monoid_Sum_null : forall {a},
                                                            Data.Monoid.Sum a -> bool :=
  fun {a} => fun arg_232__ => false.

Local Definition instance_Foldable_Data_Monoid_Sum_product : forall {a},
                                                               forall `{GHC.Num.Num a}, Data.Monoid.Sum a -> a :=
  fun {a} `{GHC.Num.Num a} => getSum.

Local Definition instance_Foldable_Data_Monoid_Sum_sum : forall {a},
                                                           forall `{GHC.Num.Num a}, Data.Monoid.Sum a -> a :=
  fun {a} `{GHC.Num.Num a} => getSum.

Local Definition instance_Foldable_Data_Monoid_Sum_toList : forall {a},
                                                              Data.Monoid.Sum a -> list a :=
  fun {a} =>
    fun arg_233__ => match arg_233__ with | (Data.Monoid.Sum x) => cons x nil end.

Local Definition instance_Foldable_Data_Monoid_Product_elem : forall {a},
                                                                forall `{GHC.Base.Eq_ a},
                                                                  a -> Data.Monoid.Product a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} =>
    hashDot (fun arg_204__ => Coq.Program.Basics.compose arg_204__ getProduct)
            GHC.Base.op_zeze__.

Local Definition instance_Foldable_Data_Monoid_Product_foldMap : forall {m} {a},
                                                                   forall `{GHC.Base.Monoid m},
                                                                     (a -> m) -> Data.Monoid.Product a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} => GHC.Base.coerce.

Local Definition instance_Foldable_Data_Monoid_Product_fold : forall {m},
                                                                forall `{GHC.Base.Monoid m},
                                                                  Data.Monoid.Product m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Product_foldMap GHC.Base.id.

Local Definition instance_Foldable_Data_Monoid_Product_foldl : forall {b} {a},
                                                                 (b -> a -> b) -> b -> Data.Monoid.Product a -> b :=
  fun {b} {a} => GHC.Base.coerce.

Local Definition instance_Foldable_Data_Monoid_Product_foldl' : forall {b} {a},
                                                                  (b -> a -> b) -> b -> Data.Monoid.Product a -> b :=
  fun {b} {a} => GHC.Base.coerce.

Local Definition instance_Foldable_Data_Monoid_Product_foldl1 : forall {a},
                                                                  (a -> a -> a) -> Data.Monoid.Product a -> a :=
  fun {a} => fun arg_206__ => getProduct.

Local Definition instance_Foldable_Data_Monoid_Product_foldr : forall {a} {b},
                                                                 (a -> b -> b) -> b -> Data.Monoid.Product a -> b :=
  fun {a} {b} =>
    fun arg_207__ arg_208__ arg_209__ =>
      match arg_207__ , arg_208__ , arg_209__ with
        | f , z , (Data.Monoid.Product x) => f x z
      end.

Local Definition instance_Foldable_Data_Monoid_Product_foldr' : forall {a} {b},
                                                                  (a -> b -> b) -> b -> Data.Monoid.Product a -> b :=
  fun {a} {b} => instance_Foldable_Data_Monoid_Product_foldr.

Local Definition instance_Foldable_Data_Monoid_Product_foldr1 : forall {a},
                                                                  (a -> a -> a) -> Data.Monoid.Product a -> a :=
  fun {a} => fun arg_212__ => getProduct.

Local Definition instance_Foldable_Data_Monoid_Product_length : forall {a},
                                                                  Data.Monoid.Product a -> GHC.Num.Int :=
  fun {a} => fun arg_213__ => one.

Local Definition instance_Foldable_Data_Monoid_Product_maximum : forall {a},
                                                                   forall `{GHC.Base.Ord a},
                                                                     Data.Monoid.Product a -> a :=
  fun {a} `{GHC.Base.Ord a} => getProduct.

Local Definition instance_Foldable_Data_Monoid_Product_minimum : forall {a},
                                                                   forall `{GHC.Base.Ord a},
                                                                     Data.Monoid.Product a -> a :=
  fun {a} `{GHC.Base.Ord a} => getProduct.

Local Definition instance_Foldable_Data_Monoid_Product_null : forall {a},
                                                                Data.Monoid.Product a -> bool :=
  fun {a} => fun arg_216__ => false.

Local Definition instance_Foldable_Data_Monoid_Product_product : forall {a},
                                                                   forall `{GHC.Num.Num a},
                                                                     Data.Monoid.Product a -> a :=
  fun {a} `{GHC.Num.Num a} => getProduct.

Local Definition instance_Foldable_Data_Monoid_Product_sum : forall {a},
                                                               forall `{GHC.Num.Num a}, Data.Monoid.Product a -> a :=
  fun {a} `{GHC.Num.Num a} => getProduct.

Local Definition instance_Foldable_Data_Monoid_Product_toList : forall {a},
                                                                  Data.Monoid.Product a -> list a :=
  fun {a} =>
    fun arg_217__ =>
      match arg_217__ with
        | (Data.Monoid.Product x) => cons x nil
      end.
*)

(*
Local Definition instance_Foldable_Data_Monoid_First_foldMap : forall {m} {a},
                                                                 forall `{GHC.Base.Monoid m},
                                                                   (a -> m) -> Data.Monoid.First a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fix foldMap arg_201__
          := match arg_201__ with
               | f => Coq.Program.Basics.compose (foldMap f) Data.Monoid.getFirst
             end.

Local Definition instance_Foldable_Data_Monoid_First_foldl : forall {b} {a},
                                                               (b -> a -> b) -> b -> Data.Monoid.First a -> b :=
  fun {b} {a} =>
    fun arg_19__ arg_20__ arg_21__ =>
      match arg_19__ , arg_20__ , arg_21__ with
        | f , z , t => appEndo (getDual (instance_Foldable_Data_Monoid_First_foldMap
                                        (Coq.Program.Basics.compose Data.Monoid.Dual (Coq.Program.Basics.compose
                                                                    Data.Monoid.Endo (GHC.Base.flip f))) t)) z
      end.

Local Definition instance_Foldable_Data_Monoid_First_foldl1 : forall {a},
                                                                (a -> a -> a) -> Data.Monoid.First a -> a :=
  fun {a} =>
    fun arg_44__ arg_45__ =>
      match arg_44__ , arg_45__ with
        | f , xs => let mf :=
                      fun arg_46__ arg_47__ =>
                        match arg_46__ , arg_47__ with
                          | m , y => Some (match m with | None => y | (Some x) => f x y end)
                        end in
                    Data.Maybe.fromMaybe (GHC.Base.errorWithoutStackTrace
                                         &"foldl1: empty structure") (instance_Foldable_Data_Monoid_First_foldl mf None
                                                                     xs)
      end.

Local Definition instance_Foldable_Data_Monoid_First_foldr' : forall {a} {b},
                                                                (a -> b -> b) -> b -> Data.Monoid.First a -> b :=
  fun {a} {b} =>
    fun arg_9__ arg_10__ arg_11__ =>
      match arg_9__ , arg_10__ , arg_11__ with
        | f , z0 , xs => let f' :=
                           fun arg_12__ arg_13__ arg_14__ =>
                             match arg_12__ , arg_13__ , arg_14__ with
                               | k , x , z => GHC.Base.op_zdzn__ k (f x z)
                             end in
                         instance_Foldable_Data_Monoid_First_foldl f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable_Data_Monoid_First_foldr : forall {a} {b},
                                                               (a -> b -> b) -> b -> Data.Monoid.First a -> b :=
  fun {a} {b} =>
    fun arg_4__ arg_5__ arg_6__ =>
      match arg_4__ , arg_5__ , arg_6__ with
        | f , z , t => appEndo (instance_Foldable_Data_Monoid_First_foldMap (hashDot
                                                                            Data.Monoid.Endo f) t) z
      end.

Local Definition instance_Foldable_Data_Monoid_First_foldl' : forall {b} {a},
                                                                (b -> a -> b) -> b -> Data.Monoid.First a -> b :=
  fun {b} {a} =>
    fun arg_24__ arg_25__ arg_26__ =>
      match arg_24__ , arg_25__ , arg_26__ with
        | f , z0 , xs => let f' :=
                           fun arg_27__ arg_28__ arg_29__ =>
                             match arg_27__ , arg_28__ , arg_29__ with
                               | x , k , z => GHC.Base.op_zdzn__ k (f z x)
                             end in
                         instance_Foldable_Data_Monoid_First_foldr f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable_Data_Monoid_First_length : forall {a},
                                                                Data.Monoid.First a -> GHC.Num.Int :=
  fun {a} =>
    instance_Foldable_Data_Monoid_First_foldl' (fun arg_64__ arg_65__ =>
                                                 match arg_64__ , arg_65__ with
                                                   | c , _ => GHC.Num.op_zp__ c one
                                                 end) BinNums.Z0.

Local Definition instance_Foldable_Data_Monoid_First_foldr1 : forall {a},
                                                                (a -> a -> a) -> Data.Monoid.First a -> a :=
  fun {a} =>
    fun arg_34__ arg_35__ =>
      match arg_34__ , arg_35__ with
        | f , xs => let mf :=
                      fun arg_36__ arg_37__ =>
                        match arg_36__ , arg_37__ with
                          | x , m => Some (match m with | None => x | (Some y) => f x y end)
                        end in
                    Data.Maybe.fromMaybe (GHC.Base.errorWithoutStackTrace
                                         &"foldr1: empty structure") (instance_Foldable_Data_Monoid_First_foldr mf None
                                                                     xs)
      end.

Local Definition instance_Foldable_Data_Monoid_First_null : forall {a},
                                                              Data.Monoid.First a -> bool :=
  fun {a} =>
    instance_Foldable_Data_Monoid_First_foldr (fun arg_61__ arg_62__ => false) true.

Local Definition instance_Foldable_Data_Monoid_First_toList : forall {a},
                                                                Data.Monoid.First a -> list a :=
  fun {a} =>
    fun arg_54__ =>
      match arg_54__ with
        | t => Base.build (fun arg_55__ arg_56__ =>
                                match arg_55__ , arg_56__ with
                                  | c , n => instance_Foldable_Data_Monoid_First_foldr c n t
                                end)
      end.

Local Definition instance_Foldable_Data_Monoid_First_product : forall {a},
                                                                 forall `{GHC.Num.Num a}, Data.Monoid.First a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hashDot getProduct (instance_Foldable_Data_Monoid_First_foldMap
            Data.Monoid.Product).

Local Definition instance_Foldable_Data_Monoid_First_sum : forall {a},
                                                             forall `{GHC.Num.Num a}, Data.Monoid.First a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hashDot getSum (instance_Foldable_Data_Monoid_First_foldMap Data.Monoid.Sum).

Local Definition instance_Foldable_Data_Monoid_First_fold : forall {m},
                                                              forall `{GHC.Base.Monoid m},
                                                                Data.Monoid.First m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_First_foldMap GHC.Base.id.

Local Definition instance_Foldable_Data_Monoid_Last_foldMap : forall {m} {a},
                                                                forall `{GHC.Base.Monoid m},
                                                                  (a -> m) -> Data.Monoid.Last a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fix foldMap arg_198__
          := match arg_198__ with
               | f => Coq.Program.Basics.compose (foldMap f) getLast
             end.

Local Definition instance_Foldable_Data_Monoid_Last_foldl : forall {b} {a},
                                                              (b -> a -> b) -> b -> Data.Monoid.Last a -> b :=
  fun {b} {a} =>
    fun arg_19__ arg_20__ arg_21__ =>
      match arg_19__ , arg_20__ , arg_21__ with
        | f , z , t => appEndo (getDual (instance_Foldable_Data_Monoid_Last_foldMap
                                        (Coq.Program.Basics.compose Data.Monoid.Dual (Coq.Program.Basics.compose
                                                                    Data.Monoid.Endo (GHC.Base.flip f))) t)) z
      end.

Local Definition instance_Foldable_Data_Monoid_Last_foldl1 : forall {a},
                                                               (a -> a -> a) -> Data.Monoid.Last a -> a :=
  fun {a} =>
    fun arg_44__ arg_45__ =>
      match arg_44__ , arg_45__ with
        | f , xs => let mf :=
                      fun arg_46__ arg_47__ =>
                        match arg_46__ , arg_47__ with
                          | m , y => Some (match m with | None => y | (Some x) => f x y end)
                        end in
                    Data.Maybe.fromMaybe (GHC.Base.errorWithoutStackTrace
                                         &"foldl1: empty structure") (instance_Foldable_Data_Monoid_Last_foldl mf None
                                                                     xs)
      end.

Local Definition instance_Foldable_Data_Monoid_Last_foldr' : forall {a} {b},
                                                               (a -> b -> b) -> b -> Data.Monoid.Last a -> b :=
  fun {a} {b} =>
    fun arg_9__ arg_10__ arg_11__ =>
      match arg_9__ , arg_10__ , arg_11__ with
        | f , z0 , xs => let f' :=
                           fun arg_12__ arg_13__ arg_14__ =>
                             match arg_12__ , arg_13__ , arg_14__ with
                               | k , x , z => GHC.Base.op_zdzn__ k (f x z)
                             end in
                         instance_Foldable_Data_Monoid_Last_foldl f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable_Data_Monoid_Last_foldr : forall {a} {b},
                                                              (a -> b -> b) -> b -> Data.Monoid.Last a -> b :=
  fun {a} {b} =>
    fun arg_4__ arg_5__ arg_6__ =>
      match arg_4__ , arg_5__ , arg_6__ with
        | f , z , t => appEndo (instance_Foldable_Data_Monoid_Last_foldMap (hashDot
                                                                           Data.Monoid.Endo f) t) z
      end.

Local Definition instance_Foldable_Data_Monoid_Last_foldl' : forall {b} {a},
                                                               (b -> a -> b) -> b -> Data.Monoid.Last a -> b :=
  fun {b} {a} =>
    fun arg_24__ arg_25__ arg_26__ =>
      match arg_24__ , arg_25__ , arg_26__ with
        | f , z0 , xs => let f' :=
                           fun arg_27__ arg_28__ arg_29__ =>
                             match arg_27__ , arg_28__ , arg_29__ with
                               | x , k , z => GHC.Base.op_zdzn__ k (f z x)
                             end in
                         instance_Foldable_Data_Monoid_Last_foldr f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable_Data_Monoid_Last_length : forall {a},
                                                               Data.Monoid.Last a -> GHC.Num.Int :=
  fun {a} =>
    instance_Foldable_Data_Monoid_Last_foldl' (fun arg_64__ arg_65__ =>
                                                match arg_64__ , arg_65__ with
                                                  | c , _ => GHC.Num.op_zp__ c one
                                                end) BinNums.Z0.

Local Definition instance_Foldable_Data_Monoid_Last_foldr1 : forall {a},
                                                               (a -> a -> a) -> Data.Monoid.Last a -> a :=
  fun {a} =>
    fun arg_34__ arg_35__ =>
      match arg_34__ , arg_35__ with
        | f , xs => let mf :=
                      fun arg_36__ arg_37__ =>
                        match arg_36__ , arg_37__ with
                          | x , m => Some (match m with | None => x | (Some y) => f x y end)
                        end in
                    Data.Maybe.fromMaybe (GHC.Base.errorWithoutStackTrace
                                         &"foldr1: empty structure") (instance_Foldable_Data_Monoid_Last_foldr mf None
                                                                     xs)
      end.

Local Definition instance_Foldable_Data_Monoid_Last_null : forall {a},
                                                             Data.Monoid.Last a -> bool :=
  fun {a} =>
    instance_Foldable_Data_Monoid_Last_foldr (fun arg_61__ arg_62__ => false) true.

Local Definition instance_Foldable_Data_Monoid_Last_toList : forall {a},
                                                               Data.Monoid.Last a -> list a :=
  fun {a} =>
    fun arg_54__ =>
      match arg_54__ with
        | t => Base.build (fun arg_55__ arg_56__ =>
                                match arg_55__ , arg_56__ with
                                  | c , n => instance_Foldable_Data_Monoid_Last_foldr c n t
                                end)
      end.

Local Definition instance_Foldable_Data_Monoid_Last_product : forall {a},
                                                                forall `{GHC.Num.Num a}, Data.Monoid.Last a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hashDot getProduct (instance_Foldable_Data_Monoid_Last_foldMap
            Data.Monoid.Product).

Local Definition instance_Foldable_Data_Monoid_Last_sum : forall {a},
                                                            forall `{GHC.Num.Num a}, Data.Monoid.Last a -> a :=
  fun {a} `{GHC.Num.Num a} =>
    hashDot getSum (instance_Foldable_Data_Monoid_Last_foldMap Data.Monoid.Sum).

Local Definition instance_Foldable_Data_Monoid_Last_fold : forall {m},
                                                             forall `{GHC.Base.Monoid m}, Data.Monoid.Last m -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Last_foldMap GHC.Base.id.
*)
(* Translating `instance forall `{GHC.Base.Ord a}, GHC.Base.Monoid (Max a)'
   failed: OOPS! Cannot construct types for this class def: Nothing unsupported *)

(* Translating `instance forall `{GHC.Base.Ord a}, GHC.Base.Monoid (Min a)'
   failed: OOPS! Cannot construct types for this class def: Nothing unsupported *)

(*
Local Definition instance_Foldable_GHC_Generics_U1_elem : forall {a},
                                                            forall `{GHC.Base.Eq_ a}, a -> GHC.Generics.U1 a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => fun arg_190__ arg_191__ => false.

Local Definition instance_Foldable_GHC_Generics_U1_fold : forall {m},
                                                            forall `{GHC.Base.Monoid m}, GHC.Generics.U1 m -> m :=
  fun {m} `{GHC.Base.Monoid m} => fun arg_169__ => GHC.Base.mempty.

Local Definition instance_Foldable_GHC_Generics_U1_foldMap : forall {m} {a},
                                                               forall `{GHC.Base.Monoid m},
                                                                 (a -> m) -> GHC.Generics.U1 a -> m :=
  fun {m} {a} `{GHC.Base.Monoid m} =>
    fun arg_167__ arg_168__ => GHC.Base.mempty.

Local Definition instance_Foldable_GHC_Generics_U1_foldl : forall {b} {a},
                                                             (b -> a -> b) -> b -> GHC.Generics.U1 a -> b :=
  fun {b} {a} =>
    fun arg_174__ arg_175__ arg_176__ =>
      match arg_174__ , arg_175__ , arg_176__ with
        | _ , z , _ => z
      end.

Local Definition instance_Foldable_GHC_Generics_U1_foldr' : forall {a} {b},
                                                              (a -> b -> b) -> b -> GHC.Generics.U1 a -> b :=
  fun {a} {b} =>
    fun arg_9__ arg_10__ arg_11__ =>
      match arg_9__ , arg_10__ , arg_11__ with
        | f , z0 , xs => let f' :=
                           fun arg_12__ arg_13__ arg_14__ =>
                             match arg_12__ , arg_13__ , arg_14__ with
                               | k , x , z => GHC.Base.op_zdzn__ k (f x z)
                             end in
                         instance_Foldable_GHC_Generics_U1_foldl f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable_GHC_Generics_U1_foldl1 : forall {a},
                                                              (a -> a -> a) -> GHC.Generics.U1 a -> a :=
  fun {a} =>
    fun arg_178__ arg_179__ => GHC.Base.errorWithoutStackTrace &"foldl1: U1".

Local Definition instance_Foldable_GHC_Generics_U1_foldr : forall {a} {b},
                                                             (a -> b -> b) -> b -> GHC.Generics.U1 a -> b :=
  fun {a} {b} =>
    fun arg_170__ arg_171__ arg_172__ =>
      match arg_170__ , arg_171__ , arg_172__ with
        | _ , z , _ => z
      end.

Local Definition instance_Foldable_GHC_Generics_U1_toList : forall {a},
                                                              GHC.Generics.U1 a -> list a :=
  fun {a} =>
    fun arg_54__ =>
      match arg_54__ with
        | t => Base.build (fun arg_55__ arg_56__ =>
                                match arg_55__ , arg_56__ with
                                  | c , n => instance_Foldable_GHC_Generics_U1_foldr c n t
                                end)
      end.

Local Definition instance_Foldable_GHC_Generics_U1_foldl' : forall {b} {a},
                                                              (b -> a -> b) -> b -> GHC.Generics.U1 a -> b :=
  fun {b} {a} =>
    fun arg_24__ arg_25__ arg_26__ =>
      match arg_24__ , arg_25__ , arg_26__ with
        | f , z0 , xs => let f' :=
                           fun arg_27__ arg_28__ arg_29__ =>
                             match arg_27__ , arg_28__ , arg_29__ with
                               | x , k , z => GHC.Base.op_zdzn__ k (f z x)
                             end in
                         instance_Foldable_GHC_Generics_U1_foldr f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable_GHC_Generics_U1_foldr1 : forall {a},
                                                              (a -> a -> a) -> GHC.Generics.U1 a -> a :=
  fun {a} =>
    fun arg_182__ arg_183__ => GHC.Base.errorWithoutStackTrace &"foldr1: U1".

Local Definition instance_Foldable_GHC_Generics_U1_length : forall {a},
                                                              GHC.Generics.U1 a -> GHC.Num.Int :=
  fun {a} => fun arg_186__ => BinNums.Z0.

Local Definition instance_Foldable_GHC_Generics_U1_null : forall {a},
                                                            GHC.Generics.U1 a -> bool :=
  fun {a} => fun arg_189__ => true.

Local Definition instance_Foldable_GHC_Generics_U1_product : forall {a},
                                                               forall `{GHC.Num.Num a}, GHC.Generics.U1 a -> a :=
  fun {a} `{GHC.Num.Num a} => fun arg_195__ => one.

Local Definition instance_Foldable_GHC_Generics_U1_sum : forall {a},
                                                           forall `{GHC.Num.Num a}, GHC.Generics.U1 a -> a :=
  fun {a} `{GHC.Num.Num a} => fun arg_192__ => BinNums.Z0.

*)
(*
Local Definition instance_Foldable__GHC_Tuple_____a__fold {a} : forall {m},
                                                              forall `{GHC.Base.Monoid m},
                                                                (a * m) -> m :=
  fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable__GHC_Tuple_____a__foldMap GHC.Base.id.
*)
Class Foldable t := {
  elem : forall {a}, forall `{GHC.Base.Eq_ a}, a -> t a -> bool ;
  fold : forall {m}, forall `{GHC.Base.Monoid m}, t m -> m ;
  foldMap : forall {m} {a}, forall `{GHC.Base.Monoid m}, (a -> m) -> t a -> m ;
  foldl : forall {b} {a}, (b -> a -> b) -> b -> t a -> b ;
  foldl' : forall {b} {a}, (b -> a -> b) -> b -> t a -> b ;
  foldl1 : forall {a}, (a -> a -> a) -> t a -> a ;
  foldr : forall {a} {b}, (a -> b -> b) -> b -> t a -> b ;
  foldr' : forall {a} {b}, (a -> b -> b) -> b -> t a -> b ;
  foldr1 : forall {a}, (a -> a -> a) -> t a -> a ;
  length : forall {a}, t a -> GHC.Num.Int ;
  maximum : forall {a}, forall `{GHC.Base.Ord a}, t a -> a ;
  minimum : forall {a}, forall `{GHC.Base.Ord a}, t a -> a ;
  null : forall {a}, t a -> bool ;
  product : forall {a}, forall `{GHC.Num.Num a}, t a -> a ;
  sum : forall {a}, forall `{GHC.Num.Num a}, t a -> a ;
  toList : forall {a}, t a -> list a }.

Definition traverse_ {t} {f} {a} {b} `{Foldable t} `{GHC.Base.Applicative f}
    : (a -> f b) -> t a -> f unit :=
  fun arg_143__ =>
    match arg_143__ with
      | f => foldr (Coq.Program.Basics.compose GHC.Base.op_ztzg__ f) (GHC.Base.pure
                                                                     tt)
    end.

Definition sequence_ {t} {m} {a} `{Foldable t} `{GHC.Base.Monad m} : t (m
                                                                          a) -> m unit :=
  foldr GHC.Base.op_zgzg__ (GHC.Base.return_ tt).

Definition sequenceA_ {t} {f} {a} `{Foldable t} `{GHC.Base.Applicative f} : t
                                                                               (f a) -> f unit :=
  foldr GHC.Base.op_ztzg__ (GHC.Base.pure tt).

(*
Definition or {t} `{Foldable t} : t bool -> bool :=
  hashDot getAny (foldMap Data.Monoid.Any).
*)
Definition notElem {t} {a} `{Foldable t} `{GHC.Base.Eq_ a} : a -> t a -> bool :=
  fun arg_84__ =>
    match arg_84__ with
      | x => Coq.Program.Basics.compose negb (elem x)
    end.

Definition minimumBy {t} {a} `{Foldable t} : (a -> a -> comparison) -> t
                                             a -> a :=
  fun arg_87__ =>
    match arg_87__ with
      | cmp => let min' :=
                 fun arg_88__ arg_89__ =>
                   match arg_88__ , arg_89__ with
                     | x , y => let scrut_90__ := cmp x y in
                                match scrut_90__ with
                                  | Gt => y
                                  | _ => x
                                end
                   end in
               foldr1 min'
    end.

Definition maximumBy {t} {a} `{Foldable t} : (a -> a -> comparison) -> t
                                             a -> a :=
  fun arg_96__ =>
    match arg_96__ with
      | cmp => let max' :=
                 fun arg_97__ arg_98__ =>
                   match arg_97__ , arg_98__ with
                     | x , y => let scrut_99__ := cmp x y in
                                match scrut_99__ with
                                  | Gt => x
                                  | _ => y
                                end
                   end in
               foldr1 max'
    end.

Definition mapM_ {t} {m} {a} {b} `{Foldable t} `{GHC.Base.Monad m} : (a -> m
                                                                        b) -> t a -> m unit :=
  fun arg_139__ =>
    match arg_139__ with
      | f => foldr (Coq.Program.Basics.compose GHC.Base.op_zgzg__ f) (GHC.Base.return_
                                                                     tt)
    end.

Definition for_ {t} {f} {a} {b} `{Foldable t} `{GHC.Base.Applicative f} : t
                                                                             a -> (a -> f b) -> f unit :=
  GHC.Base.flip traverse_.

Definition forM_ {t} {m} {a} {b} `{Foldable t} `{GHC.Base.Monad m} : t
                                                                        a -> (a -> m b) -> m unit :=
  GHC.Base.flip mapM_.

Definition foldrM {t} {m} {a} {b} `{Foldable t} `{GHC.Base.Monad m}
    : (a -> b -> m b) -> b -> t a -> m b :=
  fun arg_157__ arg_158__ arg_159__ =>
    match arg_157__ , arg_158__ , arg_159__ with
      | f , z0 , xs => let f' :=
                         fun arg_160__ arg_161__ arg_162__ =>
                           match arg_160__ , arg_161__ , arg_162__ with
                             | k , x , z => GHC.Base.op_zgzgze__ (f x z) k
                           end in
                       foldl f' GHC.Base.return_ xs z0
    end.

Definition foldlM {t} {m} {b} {a} `{Foldable t} `{GHC.Base.Monad m}
    : (b -> a -> m b) -> b -> t a -> m b :=
  fun arg_147__ arg_148__ arg_149__ =>
    match arg_147__ , arg_148__ , arg_149__ with
      | f , z0 , xs => let f' :=
                         fun arg_150__ arg_151__ arg_152__ =>
                           match arg_150__ , arg_151__ , arg_152__ with
                             | x , k , z => GHC.Base.op_zgzgze__ (f z x) k
                           end in
                       foldr f' GHC.Base.return_ xs z0
    end.

Definition find {t} {a} `{Foldable t} : (a -> bool) -> t a -> option a :=
  fun arg_78__ =>
    match arg_78__ with
      | p => Coq.Program.Basics.compose
              Data.Monoid.getFirst (foldMap (fun arg_79__ =>
                                               match arg_79__ with
                                               | x => Data.Monoid.Mk_First (if p x then Some x else None)
                                               end))
    end.


Definition asum {t} {f} {a} `{Foldable t} `{GHC.Base.Alternative f} : t (f
                                                                           a) -> f a :=
  foldr GHC.Base.op_zlzbzg__ GHC.Base.empty.

Definition msum {t} {m} {a} `{Foldable t} `{GHC.Base.MonadPlus m} : t (m a) -> m
                                                                    a :=
  asum.


Definition any {t} {a} `{Foldable t} : (a -> bool) -> t a -> bool :=
  fun arg_108__ x =>
    match arg_108__ with
      | p => Data.Monoid.getAny (foldMap (fun y => Data.Monoid.Mk_Any (p y)) x)
    end.
(*
Local Definition instance_Foldable_Data_Monoid_Last_elem : forall {a},
                                                             forall `{GHC.Base.Eq_ a},
                                                               a -> Data.Monoid.Last a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => Coq.Program.Basics.compose any GHC.Base.op_zeze__.

Local Definition instance_Foldable_Data_Monoid_First_elem : forall {a},
                                                              forall `{GHC.Base.Eq_ a},
                                                                a -> Data.Monoid.First a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => Coq.Program.Basics.compose any GHC.Base.op_zeze__.

Local Definition instance_Foldable__GHC_Arr_Array_i__elem : forall {a},
                                                              forall `{GHC.Base.Eq_ a},
                                                                a -> (GHC.Arr.Array i) a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => Coq.Program.Basics.compose any GHC.Base.op_zeze__.

Local Definition instance_Foldable__GHC_Tuple_____a__elem : forall {a},
                                                              forall `{GHC.Base.Eq_ a},
                                                                a -> (GHC.Tuple.[,] a) a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => Coq.Program.Basics.compose any GHC.Base.op_zeze__.
*)

(*Local Definition instance_Foldable_option_elem : forall {a},
                                                   forall `{GHC.Base.Eq_ a}, a -> option a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => Coq.Program.Basics.compose any GHC.Base.op_zeze__. *)
(*
Definition and {t} `{Foldable t} : t bool -> bool :=
  hashDot getAll (foldMap Data.Monoid.All).

Definition all {t} {a} `{Foldable t} : (a -> bool) -> t a -> bool :=
  fun arg_105__ =>
    match arg_105__ with
      | p => hashDot getAll (foldMap (hashDot Data.Monoid.All p))
    end.
*)
(*
Instance instance_Foldable_Data_Monoid_Product : !Foldable
                                                 Data.Monoid.Product := {
  elem := fun {a} `{GHC.Base.Eq_ a} =>
    instance_Foldable_Data_Monoid_Product_elem ;
  fold := fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Product_fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Product_foldMap ;
  foldl := fun {b} {a} => instance_Foldable_Data_Monoid_Product_foldl ;
  foldl' := fun {b} {a} => instance_Foldable_Data_Monoid_Product_foldl' ;
  foldl1 := fun {a} => instance_Foldable_Data_Monoid_Product_foldl1 ;
  foldr := fun {a} {b} => instance_Foldable_Data_Monoid_Product_foldr ;
  foldr' := fun {a} {b} => instance_Foldable_Data_Monoid_Product_foldr' ;
  foldr1 := fun {a} => instance_Foldable_Data_Monoid_Product_foldr1 ;
  length := fun {a} => instance_Foldable_Data_Monoid_Product_length ;
  maximum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Monoid_Product_maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Monoid_Product_minimum ;
  null := fun {a} => instance_Foldable_Data_Monoid_Product_null ;
  product := fun {a} `{GHC.Num.Num a} =>
    instance_Foldable_Data_Monoid_Product_product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable_Data_Monoid_Product_sum ;
  toList := fun {a} => instance_Foldable_Data_Monoid_Product_toList }.

Instance instance_Foldable_Data_Monoid_Sum : !Foldable Data.Monoid.Sum := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable_Data_Monoid_Sum_elem ;
  fold := fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Sum_fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Sum_foldMap ;
  foldl := fun {b} {a} => instance_Foldable_Data_Monoid_Sum_foldl ;
  foldl' := fun {b} {a} => instance_Foldable_Data_Monoid_Sum_foldl' ;
  foldl1 := fun {a} => instance_Foldable_Data_Monoid_Sum_foldl1 ;
  foldr := fun {a} {b} => instance_Foldable_Data_Monoid_Sum_foldr ;
  foldr' := fun {a} {b} => instance_Foldable_Data_Monoid_Sum_foldr' ;
  foldr1 := fun {a} => instance_Foldable_Data_Monoid_Sum_foldr1 ;
  length := fun {a} => instance_Foldable_Data_Monoid_Sum_length ;
  maximum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Monoid_Sum_maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Monoid_Sum_minimum ;
  null := fun {a} => instance_Foldable_Data_Monoid_Sum_null ;
  product := fun {a} `{GHC.Num.Num a} =>
    instance_Foldable_Data_Monoid_Sum_product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable_Data_Monoid_Sum_sum ;
  toList := fun {a} => instance_Foldable_Data_Monoid_Sum_toList }.

Instance instance_Foldable_Data_Monoid_Dual : !Foldable Data.Monoid.Dual := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable_Data_Monoid_Dual_elem ;
  fold := fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Dual_fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Dual_foldMap ;
  foldl := fun {b} {a} => instance_Foldable_Data_Monoid_Dual_foldl ;
  foldl' := fun {b} {a} => instance_Foldable_Data_Monoid_Dual_foldl' ;
  foldl1 := fun {a} => instance_Foldable_Data_Monoid_Dual_foldl1 ;
  foldr := fun {a} {b} => instance_Foldable_Data_Monoid_Dual_foldr ;
  foldr' := fun {a} {b} => instance_Foldable_Data_Monoid_Dual_foldr' ;
  foldr1 := fun {a} => instance_Foldable_Data_Monoid_Dual_foldr1 ;
  length := fun {a} => instance_Foldable_Data_Monoid_Dual_length ;
  maximum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Monoid_Dual_maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Monoid_Dual_minimum ;
  null := fun {a} => instance_Foldable_Data_Monoid_Dual_null ;
  product := fun {a} `{GHC.Num.Num a} =>
    instance_Foldable_Data_Monoid_Dual_product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable_Data_Monoid_Dual_sum ;
  toList := fun {a} => instance_Foldable_Data_Monoid_Dual_toList }.
*)
Local Definition instance_Foldable__sum_a__null : forall {a} {b},
                                                    (a + b) -> bool :=
  fun {a}{b} => Data.Either.isLeft.

Local Definition instance_Foldable__sum_a__length : forall {a}{b},
                                                      (a + b) -> GHC.Num.Int :=
  fun {a}{b} =>
    fun arg_304__ => match arg_304__ with | (inr _) => BinNums.Z0 | (inl _) => one end.

Local Definition instance_Foldable__sum_a__foldr : forall {a0} {a} {b},
                                                     (a -> b -> b) -> b -> (a + a0) -> b :=
  fun {a0} {a} {b} =>
    fun arg_299__ arg_300__ arg_301__ =>
      match arg_299__ , arg_300__ , arg_301__ with
        | _ , z , (inr _) => z
        | f , z , (inl y) => f y z
      end.

(*
Local Definition instance_Foldable__sum_a__foldr1 : forall {a}{a0},
                                                      (a -> a -> a) -> (a + a0) -> a :=
  fun {a}{a0} =>
    fun arg_34__ arg_35__ =>
      match arg_34__ , arg_35__ with
        | f , xs => let mf :=
                      fun arg_36__ arg_37__ =>
                        match arg_36__ , arg_37__ with
                          | x , m => Some (match m with | None => x | (Some y) => f x y end)
                        end in
                    Data.Maybe.fromMaybe (GHC.Base.errorWithoutStackTrace
                                         &"foldr1: empty structure") (instance_Foldable__sum_a__foldr mf None xs)
      end. *)

Local Definition instance_Foldable__sum_a__toList : forall {a}{b},
                                                      (a + b) -> list a :=
  fun {a}{b} =>
    fun arg_54__ =>
      match arg_54__ with
        | t => Base.build (fun _ arg_55__ arg_56__ =>
                                match arg_55__ , arg_56__ with
                                  | c , n => instance_Foldable__sum_a__foldr c n t
                                end)
      end.

Local Definition instance_Foldable__sum_a__foldl' : forall{a0} {b} {a},
                                                      (b -> a -> b) -> b -> (a + a0) -> b :=
  fun {a0} {b} {a} =>
    fun arg_24__ arg_25__ arg_26__ =>
      match arg_24__ , arg_25__ , arg_26__ with
        | f , z0 , xs => let f' :=
                           fun arg_27__ arg_28__ arg_29__ =>
                             match arg_27__ , arg_28__ , arg_29__ with
                               | x , k , z => GHC.Base.op_zdzn__ k (f z x)
                             end in
                         instance_Foldable__sum_a__foldr f' GHC.Base.id xs z0
      end.

Local Definition instance_Foldable__sum_a__foldMap : forall {a0}{m} {a},
                                                       forall `{GHC.Base.Monoid m}, (a -> m) -> (a + a0) -> m :=
  fun {a0} {m} {a} `{GHC.Base.Monoid m} =>
    fun arg_295__ arg_296__ =>
      match arg_295__ , arg_296__ with
        | _ , (inr _) => GHC.Base.mempty
        | f , (inl y) => f y
      end.

(*
Local Definition instance_Foldable__sum_a__foldl : forall {a0} {b} {a},
                                                     (b -> a -> b) -> b -> (a + a0) -> b :=
  fun{a0} {b} {a} =>
    fun arg_19__ arg_20__ arg_21__ =>
      match arg_19__ , arg_20__ , arg_21__ with
        | f , z , t => Data.Monoid.appEndo (Data.Monoid.getDual (instance_Foldable__sum_a__foldMap
                                        (Coq.Program.Basics.compose Data.Monoid.Dual (Coq.Program.Basics.compose
                                                                    Data.Monoid.Endo (GHC.Base.flip f))) t)) z
      end.

Local Definition instance_Foldable__sum_a__foldl1 : forall {a},
                                                      (a -> a -> a) -> (sum a) a -> a :=
  fun {a} =>
    fun arg_44__ arg_45__ =>
      match arg_44__ , arg_45__ with
        | f , xs => let mf :=
                      fun arg_46__ arg_47__ =>
                        match arg_46__ , arg_47__ with
                          | m , y => Some (match m with | None => y | (Some x) => f x y end)
                        end in
                    Data.Maybe.fromMaybe (GHC.Base.errorWithoutStackTrace
                                         &"foldl1: empty structure") (instance_Foldable__sum_a__foldl mf None xs)
      end.
*)
(*
Local Definition instance_Foldable__sum_a__foldr' : forall {a0}{a} {b},
                                                      (a -> b -> b) -> b -> (a + a0) -> b :=
  fun {a0}{a} {b} =>
    fun arg_9__ arg_10__ arg_11__ =>
      match arg_9__ , arg_10__ , arg_11__ with
        | f , z0 , xs => let f' :=
                           fun arg_12__ arg_13__ arg_14__ =>
                             match arg_12__ , arg_13__ , arg_14__ with
                               | k , x , z => GHC.Base.op_zdzn__ k (f x z)
                             end in
                         instance_Foldable__sum_a__foldl f' GHC.Base.id xs z0
      end. *)

Local Definition instance_Foldable__sum_a__product : forall {a}{a0},
                                                       forall `{GHC.Num.Num a}, (a + a0) -> a :=
  fun {a}{a0} `{GHC.Num.Num a} x =>
    Data.Monoid.getProduct (instance_Foldable__sum_a__foldMap Data.Monoid.Mk_Product x).

Local Definition instance_Foldable__sum_a__sum : forall {a}{a0},
                                                   forall `{GHC.Num.Num a}, (a + a0) -> a :=
  fun {a}{a0} `{GHC.Num.Num a} x =>
    Data.Monoid.getSum (instance_Foldable__sum_a__foldMap Data.Monoid.Mk_Sum x).

Local Definition instance_Foldable__sum_a__fold : forall {a}{m},
                                                    forall `{GHC.Base.Monoid m}, (m + a) -> m :=
  fun {a}{m} `{GHC.Base.Monoid m} =>
    instance_Foldable__sum_a__foldMap GHC.Base.id.

(*
Local Definition instance_Foldable__sum_a__elem : forall {a},
                                                    forall `{GHC.Base.Eq_ a}, a -> (sum a) a -> bool :=
  fun {a} `{GHC.Base.Eq_ a} => Coq.Program.Basics.compose any GHC.Base.op_zeze__.
*)
Instance instance_Foldable_list : !Foldable list := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable_list_elem ;
  fold := fun {m} `{GHC.Base.Monoid m} => instance_Foldable_list_fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable_list_foldMap ;
  foldl := fun {b} {a} => instance_Foldable_list_foldl ;
  foldl' := fun {b} {a} => instance_Foldable_list_foldl' ;
  foldl1 := fun {a} => instance_Foldable_list_foldl1 ;
  foldr := fun {a} {b} => instance_Foldable_list_foldr ;
  foldr' := fun {a} {b} => instance_Foldable_list_foldr' ;
  foldr1 := fun {a} => instance_Foldable_list_foldr1 ;
  length := fun {a} => instance_Foldable_list_length ;
  maximum := fun {a} `{GHC.Base.Ord a} => instance_Foldable_list_maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} => instance_Foldable_list_minimum ;
  null := fun {a} => instance_Foldable_list_null ;
  product := fun {a} `{GHC.Num.Num a} => instance_Foldable_list_product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable_list_sum ;
  toList := fun {a} => instance_Foldable_list_toList }.


Definition concatMap {t} {a} {b} `{Foldable t} : (a -> list b) -> t a -> list
                                                 b :=
  fun arg_113__ arg_114__ =>
    match arg_113__ , arg_114__ with
      | f , xs => Base.build (fun _ arg_115__ arg_116__ =>
                                   match arg_115__ , arg_116__ with
                                     | c , n => foldr (fun arg_117__ arg_118__ =>
                                                        match arg_117__ , arg_118__ with
                                                          | x , b => foldr c b (f x)
                                                        end) n xs
                                   end)
    end.

Definition concat {t} {a} `{Foldable t} : t (list a) -> list a :=
  fun arg_125__ =>
    match arg_125__ with
      | xs => Base.build (fun _ arg_126__ arg_127__ =>
                               match arg_126__ , arg_127__ with
                                 | c , n => foldr (fun arg_128__ arg_129__ =>
                                                    match arg_128__ , arg_129__ with
                                                      | x , y => foldr c y x
                                                    end) n xs
                               end)
    end.


Inductive Max a : Type := Mk_Max : option a -> Max a.

Definition getMax {a} (arg_75__ : Max a) :=
  match arg_75__ with
    | (Mk_Max getMax) => getMax
  end.

(*
Local Definition instance_Foldable_GHC_Generics_U1_maximum : forall {a},
                                                               forall `{GHC.Base.Ord a}, GHC.Generics.U1 a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"maximum: empty structure"))
                               (Coq.Program.Basics.compose getMax (instance_Foldable_GHC_Generics_U1_foldMap
                                                           (hashDot Mk_Max (Some : a -> option a)))).
*)

Instance instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Max_a_
  : !forall `{GHC.Base.Ord a}, GHC.Base.Monoid (Max a) := {}.
Proof.
Admitted.

(*
Local Definition instance_Foldable_Data_Monoid_Last_maximum : forall {a},
                                                                forall `{GHC.Base.Ord a}, Data.Monoid.Last a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"maximum: empty structure"))
                               (Coq.Program.Basics.compose getMax (instance_Foldable_Data_Monoid_Last_foldMap
                                                           (hashDot Mk_Max (Some : a -> option a)))).

Local Definition instance_Foldable_Data_Monoid_First_maximum : forall {a},
                                                                 forall `{GHC.Base.Ord a}, Data.Monoid.First a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"maximum: empty structure"))
                               (Coq.Program.Basics.compose getMax (instance_Foldable_Data_Monoid_First_foldMap
                                                           (hashDot Mk_Max (Some : a -> option a)))).

Local Definition instance_Foldable_Data_Proxy_Proxy_maximum : forall {a},
                                                                forall `{GHC.Base.Ord a}, Data.Proxy.Proxy a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"maximum: empty structure"))
                               (Coq.Program.Basics.compose getMax (instance_Foldable_Data_Proxy_Proxy_foldMap
                                                           (hashDot Mk_Max (Some : a -> option a)))).

Local Definition instance_Foldable__GHC_Arr_Array_i__maximum : forall {a},
                                                                 forall `{GHC.Base.Ord a}, (GHC.Arr.Array i) a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"maximum: empty structure"))
                               (Coq.Program.Basics.compose getMax (instance_Foldable__GHC_Arr_Array_i__foldMap
                                                           (hashDot Mk_Max (Some : a -> option a)))).

Local Definition instance_Foldable__GHC_Tuple_____a__maximum : forall {a},
                                                                 forall `{GHC.Base.Ord a}, (GHC.Tuple.[,] a) a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"maximum: empty structure"))
                               (Coq.Program.Basics.compose getMax (instance_Foldable__GHC_Tuple_____a__foldMap
                                                           (hashDot Mk_Max (Some : a -> option a)))).

Local Definition instance_Foldable__sum_a__maximum : forall {a},
                                                       forall `{GHC.Base.Ord a}, (sum a) a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"maximum: empty structure"))
                               (Coq.Program.Basics.compose getMax (instance_Foldable__sum_a__foldMap (hashDot
                                                                                                     Mk_Max
                                                                                                     (Some : a -> option
                                                                                                     a)))).

Local Definition instance_Foldable_option_maximum : forall {a},
                                                      forall `{GHC.Base.Ord a}, option a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"maximum: empty structure"))
                               (Coq.Program.Basics.compose getMax (instance_Foldable_option_foldMap (hashDot
                                                                                                    Mk_Max
                                                                                                    (Some : a -> option
                                                                                                    a)))).

Inductive Min a : Type := Mk_Min : option a -> Min a.

Definition getMin {a} (arg_74__ : Min a) :=
  match arg_74__ with
    | (Mk_Min getMin) => getMin
  end.

Local Definition instance_Foldable_GHC_Generics_U1_minimum : forall {a},
                                                               forall `{GHC.Base.Ord a}, GHC.Generics.U1 a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"minimum: empty structure"))
                               (Coq.Program.Basics.compose getMin (instance_Foldable_GHC_Generics_U1_foldMap
                                                           (hashDot Mk_Min (Some : a -> option a)))).

Instance instance_Foldable_GHC_Generics_U1 : !Foldable GHC.Generics.U1 := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable_GHC_Generics_U1_elem ;
  fold := fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_GHC_Generics_U1_fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable_GHC_Generics_U1_foldMap ;
  foldl := fun {b} {a} => instance_Foldable_GHC_Generics_U1_foldl ;
  foldl' := fun {b} {a} => instance_Foldable_GHC_Generics_U1_foldl' ;
  foldl1 := fun {a} => instance_Foldable_GHC_Generics_U1_foldl1 ;
  foldr := fun {a} {b} => instance_Foldable_GHC_Generics_U1_foldr ;
  foldr' := fun {a} {b} => instance_Foldable_GHC_Generics_U1_foldr' ;
  foldr1 := fun {a} => instance_Foldable_GHC_Generics_U1_foldr1 ;
  length := fun {a} => instance_Foldable_GHC_Generics_U1_length ;
  maximum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_GHC_Generics_U1_maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_GHC_Generics_U1_minimum ;
  null := fun {a} => instance_Foldable_GHC_Generics_U1_null ;
  product := fun {a} `{GHC.Num.Num a} =>
    instance_Foldable_GHC_Generics_U1_product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable_GHC_Generics_U1_sum ;
  toList := fun {a} => instance_Foldable_GHC_Generics_U1_toList }.
*)

Instance instance_forall___GHC_Base_Ord_a___GHC_Base_Monoid__Min_a_
  : !forall `{GHC.Base.Ord a}, GHC.Base.Monoid (Min a) := {}.
Proof.
Admitted.

(*
Local Definition instance_Foldable_Data_Monoid_Last_minimum : forall {a},
                                                                forall `{GHC.Base.Ord a}, Data.Monoid.Last a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"minimum: empty structure"))
                               (Coq.Program.Basics.compose getMin (instance_Foldable_Data_Monoid_Last_foldMap
                                                           (hashDot Mk_Min (Some : a -> option a)))).
*)

(*
Instance instance_Foldable_Data_Monoid_Last : !Foldable Data.Monoid.Last := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable_Data_Monoid_Last_elem ;
  fold := fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Last_fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_Last_foldMap ;
  foldl := fun {b} {a} => instance_Foldable_Data_Monoid_Last_foldl ;
  foldl' := fun {b} {a} => instance_Foldable_Data_Monoid_Last_foldl' ;
  foldl1 := fun {a} => instance_Foldable_Data_Monoid_Last_foldl1 ;
  foldr := fun {a} {b} => instance_Foldable_Data_Monoid_Last_foldr ;
  foldr' := fun {a} {b} => instance_Foldable_Data_Monoid_Last_foldr' ;
  foldr1 := fun {a} => instance_Foldable_Data_Monoid_Last_foldr1 ;
  length := fun {a} => instance_Foldable_Data_Monoid_Last_length ;
  maximum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Monoid_Last_maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Monoid_Last_minimum ;
  null := fun {a} => instance_Foldable_Data_Monoid_Last_null ;
  product := fun {a} `{GHC.Num.Num a} =>
    instance_Foldable_Data_Monoid_Last_product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable_Data_Monoid_Last_sum ;
  toList := fun {a} => instance_Foldable_Data_Monoid_Last_toList }.

Local Definition instance_Foldable_Data_Monoid_First_minimum : forall {a},
                                                                 forall `{GHC.Base.Ord a}, Data.Monoid.First a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"minimum: empty structure"))
                               (Coq.Program.Basics.compose getMin (instance_Foldable_Data_Monoid_First_foldMap
                                                           (hashDot Mk_Min (Some : a -> option a)))).

Instance instance_Foldable_Data_Monoid_First : !Foldable Data.Monoid.First := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable_Data_Monoid_First_elem ;
  fold := fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_First_fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Monoid_First_foldMap ;
  foldl := fun {b} {a} => instance_Foldable_Data_Monoid_First_foldl ;
  foldl' := fun {b} {a} => instance_Foldable_Data_Monoid_First_foldl' ;
  foldl1 := fun {a} => instance_Foldable_Data_Monoid_First_foldl1 ;
  foldr := fun {a} {b} => instance_Foldable_Data_Monoid_First_foldr ;
  foldr' := fun {a} {b} => instance_Foldable_Data_Monoid_First_foldr' ;
  foldr1 := fun {a} => instance_Foldable_Data_Monoid_First_foldr1 ;
  length := fun {a} => instance_Foldable_Data_Monoid_First_length ;
  maximum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Monoid_First_maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Monoid_First_minimum ;
  null := fun {a} => instance_Foldable_Data_Monoid_First_null ;
  product := fun {a} `{GHC.Num.Num a} =>
    instance_Foldable_Data_Monoid_First_product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable_Data_Monoid_First_sum ;
  toList := fun {a} => instance_Foldable_Data_Monoid_First_toList }.
*)
(*
Local Definition instance_Foldable_Data_Proxy_Proxy_minimum : forall {a},
                                                                forall `{GHC.Base.Ord a}, Data.Proxy.Proxy a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"minimum: empty structure"))
                               (Coq.Program.Basics.compose getMin (instance_Foldable_Data_Proxy_Proxy_foldMap
                                                           (hashDot Mk_Min (Some : a -> option a)))).
*)

(*
Instance instance_Foldable_Data_Proxy_Proxy : !Foldable Data.Proxy.Proxy := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable_Data_Proxy_Proxy_elem ;
  fold := fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Proxy_Proxy_fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable_Data_Proxy_Proxy_foldMap ;
  foldl := fun {b} {a} => instance_Foldable_Data_Proxy_Proxy_foldl ;
  foldl' := fun {b} {a} => instance_Foldable_Data_Proxy_Proxy_foldl' ;
  foldl1 := fun {a} => instance_Foldable_Data_Proxy_Proxy_foldl1 ;
  foldr := fun {a} {b} => instance_Foldable_Data_Proxy_Proxy_foldr ;
  foldr' := fun {a} {b} => instance_Foldable_Data_Proxy_Proxy_foldr' ;
  foldr1 := fun {a} => instance_Foldable_Data_Proxy_Proxy_foldr1 ;
  length := fun {a} => instance_Foldable_Data_Proxy_Proxy_length ;
  maximum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Proxy_Proxy_maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable_Data_Proxy_Proxy_minimum ;
  null := fun {a} => instance_Foldable_Data_Proxy_Proxy_null ;
  product := fun {a} `{GHC.Num.Num a} =>
    instance_Foldable_Data_Proxy_Proxy_product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable_Data_Proxy_Proxy_sum ;
  toList := fun {a} => instance_Foldable_Data_Proxy_Proxy_toList }.
*)

(*
Local Definition instance_Foldable__GHC_Arr_Array_i__minimum : forall {a},
                                                                 forall `{GHC.Base.Ord a}, (GHC.Arr.Array i) a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"minimum: empty structure"))
                               (Coq.Program.Basics.compose getMin (instance_Foldable__GHC_Arr_Array_i__foldMap
                                                           (hashDot Mk_Min (Some : a -> option a)))).

Instance instance_Foldable__GHC_Arr_Array_i_ : !Foldable (GHC.Arr.Array i) := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable__GHC_Arr_Array_i__elem ;
  fold := fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable__GHC_Arr_Array_i__fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable__GHC_Arr_Array_i__foldMap ;
  foldl := fun {b} {a} => instance_Foldable__GHC_Arr_Array_i__foldl ;
  foldl' := fun {b} {a} => instance_Foldable__GHC_Arr_Array_i__foldl' ;
  foldl1 := fun {a} => instance_Foldable__GHC_Arr_Array_i__foldl1 ;
  foldr := fun {a} {b} => instance_Foldable__GHC_Arr_Array_i__foldr ;
  foldr' := fun {a} {b} => instance_Foldable__GHC_Arr_Array_i__foldr' ;
  foldr1 := fun {a} => instance_Foldable__GHC_Arr_Array_i__foldr1 ;
  length := fun {a} => instance_Foldable__GHC_Arr_Array_i__length ;
  maximum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable__GHC_Arr_Array_i__maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable__GHC_Arr_Array_i__minimum ;
  null := fun {a} => instance_Foldable__GHC_Arr_Array_i__null ;
  product := fun {a} `{GHC.Num.Num a} =>
    instance_Foldable__GHC_Arr_Array_i__product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable__GHC_Arr_Array_i__sum ;
  toList := fun {a} => instance_Foldable__GHC_Arr_Array_i__toList }.

Local Definition instance_Foldable__GHC_Tuple_____a__minimum : forall {a},
                                                                 forall `{GHC.Base.Ord a}, (GHC.Tuple.[,] a) a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"minimum: empty structure"))
                               (Coq.Program.Basics.compose getMin (instance_Foldable__GHC_Tuple_____a__foldMap
                                                           (hashDot Mk_Min (Some : a -> option a)))).

Instance instance_Foldable__GHC_Tuple_____a_ : !Foldable (GHC.Tuple.[,] a) := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable__GHC_Tuple_____a__elem ;
  fold := fun {m} `{GHC.Base.Monoid m} =>
    instance_Foldable__GHC_Tuple_____a__fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable__GHC_Tuple_____a__foldMap ;
  foldl := fun {b} {a} => instance_Foldable__GHC_Tuple_____a__foldl ;
  foldl' := fun {b} {a} => instance_Foldable__GHC_Tuple_____a__foldl' ;
  foldl1 := fun {a} => instance_Foldable__GHC_Tuple_____a__foldl1 ;
  foldr := fun {a} {b} => instance_Foldable__GHC_Tuple_____a__foldr ;
  foldr' := fun {a} {b} => instance_Foldable__GHC_Tuple_____a__foldr' ;
  foldr1 := fun {a} => instance_Foldable__GHC_Tuple_____a__foldr1 ;
  length := fun {a} => instance_Foldable__GHC_Tuple_____a__length ;
  maximum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable__GHC_Tuple_____a__maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} =>
    instance_Foldable__GHC_Tuple_____a__minimum ;
  null := fun {a} => instance_Foldable__GHC_Tuple_____a__null ;
  product := fun {a} `{GHC.Num.Num a} =>
    instance_Foldable__GHC_Tuple_____a__product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable__GHC_Tuple_____a__sum ;
  toList := fun {a} => instance_Foldable__GHC_Tuple_____a__toList }.
*)
(*
Local Definition instance_Foldable__sum_a__minimum : forall {a},
                                                       forall `{GHC.Base.Ord a}, (sum a) a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"minimum: empty structure"))
                               (Coq.Program.Basics.compose getMin (instance_Foldable__sum_a__foldMap (hashDot
                                                                                                     Mk_Min
                                                                                                     (Some : a -> option
                                                                                                     a)))).
*)
(*
Instance instance_Foldable__sum_a_ : !Foldable (fun x => (a + x)%type) := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable__sum_a__elem ;
  fold := fun {m} `{GHC.Base.Monoid m} => instance_Foldable__sum_a__fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable__sum_a__foldMap ;
  foldl := fun {b} {a} => instance_Foldable__sum_a__foldl ;
  foldl' := fun {b} {a} => instance_Foldable__sum_a__foldl' ;
  foldl1 := fun {a} => instance_Foldable__sum_a__foldl1 ;
  foldr := fun {a} {b} => instance_Foldable__sum_a__foldr ;
  foldr' := fun {a} {b} => instance_Foldable__sum_a__foldr' ;
  foldr1 := fun {a} => instance_Foldable__sum_a__foldr1 ;
  length := fun {a} => instance_Foldable__sum_a__length ;
  maximum := fun {a} `{GHC.Base.Ord a} => instance_Foldable__sum_a__maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} => instance_Foldable__sum_a__minimum ;
  null := fun {a} => instance_Foldable__sum_a__null ;
  product := fun {a} `{GHC.Num.Num a} => instance_Foldable__sum_a__product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable__sum_a__sum ;
  toList := fun {a} => instance_Foldable__sum_a__toList }.
*)
(*
Local Definition instance_Foldable_option_minimum : forall {a},
                                                      forall `{GHC.Base.Ord a}, option a -> a :=
  fun {a} `{GHC.Base.Ord a} =>
    Coq.Program.Basics.compose (Data.Maybe.fromMaybe
                               (GHC.Base.errorWithoutStackTrace &"minimum: empty structure"))
                               (Coq.Program.Basics.compose getMin (instance_Foldable_option_foldMap (hashDot
                                                                                                    Mk_Min
                                                                                                    (Some : a -> option
                                                                                                  a)))).
*)
(*
Instance instance_Foldable_option : !Foldable option := {
  elem := fun {a} `{GHC.Base.Eq_ a} => instance_Foldable_option_elem ;
  fold := fun {m} `{GHC.Base.Monoid m} => instance_Foldable_option_fold ;
  foldMap := fun {m} {a} `{GHC.Base.Monoid m} =>
    instance_Foldable_option_foldMap ;
  foldl := fun {b} {a} => instance_Foldable_option_foldl ;
  foldl' := fun {b} {a} => instance_Foldable_option_foldl' ;
  foldl1 := fun {a} => instance_Foldable_option_foldl1 ;
  foldr := fun {a} {b} => instance_Foldable_option_foldr ;
  foldr' := fun {a} {b} => instance_Foldable_option_foldr' ;
  foldr1 := fun {a} => instance_Foldable_option_foldr1 ;
  length := fun {a} => instance_Foldable_option_length ;
  maximum := fun {a} `{GHC.Base.Ord a} => instance_Foldable_option_maximum ;
  minimum := fun {a} `{GHC.Base.Ord a} => instance_Foldable_option_minimum ;
  null := fun {a} => instance_Foldable_option_null ;
  product := fun {a} `{GHC.Num.Num a} => instance_Foldable_option_product ;
  sum := fun {a} `{GHC.Num.Num a} => instance_Foldable_option_sum ;
  toList := fun {a} => instance_Foldable_option_toList }.
*)
(* Unbound variables:
     Coq.Program.Basics.compose Data.Either.isLeft Data.Maybe.fromMaybe
     Data.Monoid.All Data.Monoid.Any Data.Monoid.Dual Data.Monoid.Endo
     Data.Monoid.First Data.Monoid.Last Data.Monoid.Product Data.Monoid.Sum
     Data.Proxy.Proxy GHC.Arr.Array GHC.Arr.elems GHC.Arr.foldl1Elems
     GHC.Arr.foldlElems GHC.Arr.foldlElems' GHC.Arr.foldr1Elems GHC.Arr.foldrElems
     GHC.Arr.foldrElems' GHC.Arr.numElements GHC.Base.MonadPlus Base.build
     GHC.Base.empty GHC.Base.mappend GHC.Base.mempty GHC.Base.op_zdzn__
     GHC.Base.op_zgzg__ GHC.Base.op_zgzgze__ GHC.Base.op_zlzbzg__ GHC.Base.op_ztzg__
     GHC.Base.pure GHC.Base.return_ GHC.Base.Alternative GHC.Base.Applicative
     GHC.Base.Monad GHC.Base.Monoid GHC.Base.flip GHC.Base.foldr
     GHC.Base.id GHC.Generics.U1 GHC.List.elem GHC.List.foldl GHC.List.foldl'
     GHC.List.foldl1 GHC.List.foldr1 GHC.List.length GHC.List.maximum
     GHC.List.minimum GHC.List.null GHC.List.product GHC.List.sum GHC.Num.Int
     GHC.Num.Num GHC.Num.op_zp__ GHC.Base.Eq_ GHC.Base.Ord GHC.Base.coerce
     GHC.Base.errorWithoutStackTrace GHC.Base.op_zeze__ GHC.Tuple.[,]
     GHC.Types.Coercible None Some appEndo bool comparison cons false getAll getAny
     getDual getFirst getLast getProduct getSum hashDot i inl inr list negb nil
     option pair true tt unit
*)
