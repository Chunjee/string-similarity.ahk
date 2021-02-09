Class stringsimilarity {

	__New() {
		this.info_Array
	}


	compareTwoStrings(param_string1, param_string2) {
		;Sørensen-Dice coefficient
		savedBatchLines := A_BatchLines
		SetBatchLines, -1

		vCount := 0
		oArray := {}
		oArray := {base:{__Get:Func("Abs").Bind(0)}} ;make default key value 0 instead of a blank string
		Loop, % vCount1 := StrLen(param_string1) - 1
			oArray["z" SubStr(param_string1, A_Index, 2)]++
		Loop, % vCount2 := StrLen(param_string2) - 1
			if (oArray["z" SubStr(param_string2, A_Index, 2)] > 0) {
				oArray["z" SubStr(param_string2, A_Index, 2)]--
				vCount++
			}
		vSDC := Round((2 * vCount) / (vCount1 + vCount2),2)
		if (!vSDC || vSDC < 0.005) { ;round to 0 if less than 0.005
			return 0
		}
		if (vSDC = 1) {
			return 1
		}
		SetBatchLines, % savedBatchLines
		return vSDC
	}


	findBestMatch(param_string, param_array) {
		savedBatchLines := A_BatchLines
		SetBatchLines, -1
		if (!IsObject(param_array)) {
			SetBatchLines, % savedBatchLines
			return false
		}

		this.info_Array := []

		; Score each option and save into a new array
		loop, % param_array.MaxIndex() {
			this.info_Array[A_Index, "rating"] := this.compareTwoStrings(param_string, param_array[A_Index])
			this.info_Array[A_Index, "target"] := param_array[A_Index]
		}

		;sort the rated array
		l_sortedArray := this.internal_Sort2DArrayFast(this.info_Array,"rating")
		; create the besMatch property and final object
		l_object := {bestMatch:l_sortedArray[1].clone(), ratings:l_sortedArray}
		SetBatchLines, % savedBatchLines
		return l_object
	}


	simpleBestMatch(param_string, param_array) {
		if (!IsObject(param_array)) {
			return false
		}

		l_array := this.findBestMatch(param_string, param_array)
		return l_array.bestMatch.target
	}



	internal_Sort2DArrayFast(param_arr, param_key, Ascending := True)
	{
		for index, obj in param_arr
			out .= obj[param_key] "+" index "|" ; "+" allows for sort to work with just the value
		; out will look like:   value+index|value+index|

		v := param_arr[param_arr.minIndex(), param_key]
		if v is number
			type := " N "
		out := subStr(out, 1, strLen(out) -1) ; remove trailing |
		Sort, out, % "D| " type  " R"
		l_storage := []
		loop, parse, out, |
			l_storage.insert(param_arr[SubStr(A_LoopField, InStr(A_LoopField, "+") + 1)])
		return l_storage
	}
}
