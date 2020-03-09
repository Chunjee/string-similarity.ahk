#Include ..\export.ahk
#Include ..\node_modules
#Include unit-testing.ahk\export.ahk
#Include json.ahk\export.ahk

#NoEnv
#NoTrayIcon
#SingleInstance force
SetBatchLines, -1

stringSimilarity := new stringsimilarity()
assert := new unittesting()


;; Test compareTwoStrings()
assert.test((stringSimilarity.compareTwoStrings("The eturn of the king", "The Return of the King") > 0.90 ), true)
assert.test((stringSimilarity.compareTwoStrings("The Mask", "the mask") = 1 ), true)
assert.test((stringSimilarity.compareTwoStrings("set", "ste") = 0 ), true)

;; Test simpleBestMatch()
assert.test(stringSimilarity.simpleBestMatch("setting", ["ste","one","set"]), "set")
assert.test(stringSimilarity.simpleBestMatch("Smart", ["smarts","farts","clip-art"]), "smarts")
assert.test(stringSimilarity.simpleBestMatch("Olive-green table", ["green Subaru Impreza","table in very good","mountain bike with"]), "table in very good")

assert.test(stringSimilarity.simpleBestMatch("Olive-green table for sale, in extremely good condition."
    , ["For sale: green Subaru Impreza, 210,000 miles"
    , "For sale: table in very good condition, olive green in colour."
    , "Wanted: mountain bike with at least 21 gears."])
, "For sale: table in very good condition, olive green in colour.")

;; Test findBestMatch()
testVar := stringSimilarity.findBestMatch("similar", ["levenshtein","matching","similarity"])
assert.test(testVar.bestMatch.target, "similarity")
assert.test(testVar.bestMatch.rating, "0.80")
testVar2 := stringSimilarity.findBestMatch("Hard to", [" hard to    ","hard to","Hard 2"])
assert.test(testVar2.bestMatch.target, "hard to")
assert.test(testVar2.bestMatch.rating, "1")


;; Display test results in GUI
assert.fullReport()
assert.writeTestResultsToFile()

ExitApp
