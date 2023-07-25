entry = exp => {
    prec = 0
    while(isNaN(exp)){
       texp = ""
       spc = " ".repeat(prec)
       rspc = new RegExp("-?\\d"+spc+"[+\\-\\/*]"+spc+"-?\\d")
       do {
           texp = exp
           exp = exp.replace(rspc,
           (exp, _a, _b, _c, _d, _e, _f, _g) => eval(exp))
       } while (exp != texp)
       prec++
    }
    return exp
}
console.log("9 / 1+2  -  1    /    2 -> "+entry("9 / 1+2  -  1    /    2"))
console.log("0-6 * 2 -> "+entry("0-6 * 2"))
console.log("4  /  1 + 1 -> "+entry("4  /  1 + 1"))
console.log("2-4/2 -> "+entry("2-4/2"))
console.log("-4 -> "+entry("-4"))
console.log("34 -> "+entry("34"))
console.log("1 / 0 -> "+entry("1 / 0"))
console.log("9*9*9*9*9*9*9*9*9*9 -> "+entry("9*9*9*9*9*9*9*9*9*9"))
