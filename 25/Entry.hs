import Data.List
import Data.Maybe ( fromJust, isJust )
import qualified Data.IntMap.Strict as IM

entry :: [[Bool]] -> Int -> Int -> [Int]
entry mat a b = fromJust $ entry' (adjToMap mat) a b []

entry' :: IM.IntMap [Int] -> Int -> Int -> [Int] -> Maybe [Int]
entry' graph a b visited
	| a == b     = Just [b]
	| null next = Nothing
	| a /= b     = Just $ (:) a $ fromJust $ fromJust $ find isJust $ map (\x -> entry' graph x b (a : visited)) next
	where
		next = fromJust (IM.lookup a graph) \\ visited

adjToMap :: [[Bool]] -> IM.IntMap [Int]
adjToMap mat = IM.fromList [(idx, [ v | (True, v) <- zip row [0..]]) | (idx, row) <- zip [0..] mat]
