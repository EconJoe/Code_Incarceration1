
cd B:\Research\Projects\Incarceration\Ohio\data
import delimited "ohio_data_test.txt", clear varnames(1) delimiter(tab) stringcols(_all)
tempfile hold
save `hold', replace

clear
gen offnum=""
tempfile offnum
save `offnum', replace
local vals `" "A" "R" "W" "'
foreach i in `vals' {
	cd B:\Research\Projects\Incarceration\Ohio\data
	import delimited "ohio_offnumbers_`i'.txt", clear delimiter(tab) varnames(nonames) stringcols(_all) 
	rename v1 offnum
	append using `offnum'
	save `offnum', replace
}

merge 1:m offnum using `hold'
keep if _merge==3
drop _merge
cd B:\Research\Projects\Incarceration\Ohio\data
export delimited using "ohio_final", replace

cd B:\Research\Projects\Incarceration\Michigan\data
import delimited "michigan_data_test.txt", clear varnames(1) delimiter(tab) stringcols(_all) 
tempfile hold
save `hold', replace

cd B:\Research\Projects\Incarceration\Michigan\data
import delimited "michigan_offnumbers.txt", clear varnames(1) delimiter(tab) stringcols(_all) 
rename v1 offnum
merge 1:m offnum using `hold'
keep if _merge==3
drop _merge

cd B:\Research\Projects\Incarceration\Michigan\data
export delimited using "michigan_final", replace
