#Include export.ahk
#Include ..\unit-testing.ahk\export.ahk
#Include ..\sort-array.ahk\export.ahk
#NoTrayIcon
SetBatchLines, -1

stringSimilarity := new stringsimilarity()


;; Run some unit tests
assert := new unittest_class()
assert.test((stringSimilarity.compareTwoStrings("The eturn of the king", "The Return of the King") > 0.90 ),true)
assert.test((stringSimilarity.compareTwoStrings("The Mask", "the mask") = 1 ),true)
assert.test((stringSimilarity.compareTwoStrings("set", "ste") = 0 ),true)
assert.test(stringSimilarity.simpleBestMatch("setting", ["ste","one","set"]),"set")
assert.test(stringSimilarity.simpleBestMatch("Smart", ["smarts","farts","clip-art"]),"smarts")
assert.test(stringSimilarity.simpleBestMatch("Olive-green table", ["green Subaru Impreza","table in very good","mountain bike with"]),"table in very good")
assert.report()

ExitApp
