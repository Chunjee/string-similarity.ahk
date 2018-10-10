Class stringsimilarity {
	#Include ../../lib/sort_arrays/export.ahk

	__New() {
        this.info_Array
	}


    compareTwoStrings(para_string1,para_string2) {
        ;Sørensen-Dice coefficient
        vCount := 0
        oArray := {}
        oArray := {base:{__Get:Func("Abs").Bind(0)}} ;make default key value 0 instead of a blank string
        Loop, % vCount1 := StrLen(para_string1) - 1
            oArray["z" SubStr(para_string1, A_Index, 2)]++
        Loop, % vCount2 := StrLen(para_string2) - 1
            if (oArray["z" SubStr(para_string2, A_Index, 2)] > 0) {
                oArray["z" SubStr(para_string2, A_Index, 2)]--
                vCount++
            }
        vDSC := (2 * vCount) / (vCount1 + vCount2)
        ; MsgBox, % vCount " " vCount1 " " vCount2 "`r`n" vDSC
        return Round(vDSC,2)
    }


    findBestMatch(para_string,para_array) {
        if (!IsObject(para_array)) {
            return false
        }
        this.info_Array := []

        ; Score each option and save into a new array
        loop, % para_array.MaxIndex() {
            this.info_Array[A_Index, "rating"] := this.compareTwoStrings(para_string, para_array[A_Index])
            this.info_Array[A_Index, "target"] := para_array[A_Index]
        }

        ;sort the scored array and return the bestmatch
        sortedArray := Fn_Sort2DArrayFast(this.info_Array,"rating", false) ;false reverses the order so the highest scoring is at the top
        oObject := {bestMatch:sortedArray[1], ratings:sortedArray}
        return oObject
    }


    simpleBestMatch(para_string,para_array) {
        if (!IsObject(para_array)) {
            return false
        }

        l_array := this.findBestMatch(para_string,para_array)
        return l_array.bestMatch.target
    }
}
