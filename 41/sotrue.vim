" Made In Emacs
" Tested In VIM - Vi IMproved 8.1
" Open File
" Enter Insert Mode, Type In Your Program
" Enter Normal Mode, Type :so sotrue.vim<RET> 

" Nested Comments Are Supported

let program = join(getline(1, '$'), "\n")

" remove comments and find strings
let s:index = 0
let s:tokens = []
while s:index < program->len()
   let item = program[s:index]
   if item == '{' " comment '{'
      let start = s:index
      let depth = 1
      let s:index = s:index + 1
      while depth != 0 " close comment '}'
         let depth = depth + (program[s:index] == '{') - (program[s:index] == '}')
         let s:index = s:index + 1
      endwhile
      let s:index = s:index - 1
   elseif item == '"' " string '"'
      let start = s:index + 1
      let s:index = s:index + 1
      while program[s:index] != '"'
         let s:index = s:index + 1
      endwhile
      let s:tokens = s:tokens->add(["print",program[start:s:index-1]])
   elseif item =~# '\d'
      let num = 0
      while program[s:index] =~# '\d'
         let num = num * 10 + str2nr(program[s:index])
         let s:index = s:index + 1
      endwhile
      let s:index = s:index - 1
      let s:tokens = s:tokens->add(["num",num])
   elseif item == "'"
      let s:tokens = s:tokens->add(["num",char2nr(program[s:index + 1])])
      let s:index = s:index + 1
   elseif item == '[' || item == ']'
      let s:tokens = s:tokens->add(["sq",program[s:index:s:index]])
   elseif item =~# '[a-z]'
      let s:tokens = s:tokens->add(["var",program[s:index:s:index]])
   elseif item =~# '\s'
   else
      let s:tokens = s:tokens->add(["cmd",program[s:index:s:index]])
   endif 
   let s:index = s:index + 1
endwhile


" parse quotations
let s:stk = []
let s:topquot = []
for [type,data] in s:tokens
   if type == "sq" && data == "["
      let s:stk = add(s:stk, s:topquot)
      let s:topquot = []
   elseif type == "sq" && data == "]"
      let tmp = remove(s:stk, -1)
      let s:topquot = add(tmp,["quot",s:topquot])
      " pop from stk, add topquot to it, add it to top quot
   else
      let s:topquot = add(s:topquot, [type,data])
   endif
endfor

" run the program
let s:plen = len(s:topquot)
let s:pptrs = [] " program pointers
let s:cstk = [] " call stack
let s:vars = {} " variables in the FALSE program
let s:cptr = 0 " current execution point
let s:cprg = s:topquot " current quotation to execute, starting at full program

" for while mainly
let s:mode = "exec"
let s:sndq = []  " stores quote for while loop


let s:mstk = []
while s:cptr < s:plen
   if s:cptr >= len(s:cprg) " handle quots
      if s:mode == "whilecond"
         if remove(s:mstk, -1) != 0
            let temp = s:cprg
            let s:cprg = s:sndq
            let s:sndq = temp
            let s:cptr = -1
            let s:mode = "whilebody"
         else " lower level of nesting.
            let [mo,cp,pr,sn] = remove(s:cstk, -1)
            let s:mode = mo
            let s:cptr = cp 
            let s:cprg = pr
            let s:sndq = sn
         endif
      elseif s:mode == "whilebody"
         let temp = s:cprg
         let s:cprg = s:sndq
         let s:sndq = temp
         let s:cptr = -1
         let s:mode = "whilecond" 
      elseif s:mode == "exec"
         let [mo,cp,pr,sn] = remove(s:cstk, -1)
         let s:mode = mo
         let s:cptr = cp 
         let s:cprg = pr
         let s:sndq = sn
      endif
   else
      let [type, data] = s:cprg[s:cptr]
      if type == 'cmd'
         if data == ';'
            let a = remove(s:mstk, -1)
            call add(s:mstk, vars[a])
         elseif data == ':'
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            let s:vars[a] = b
         elseif data == '$'
            call add(s:mstk, deepcopy(s:mstk[-1]))
         elseif data == '%'
            call remove(s:mstk, -1)
         elseif data == '\'
            let s:mstk[-2:-1] = reverse(s:mstk[-2:-1])
         elseif data == '@'
            call add(s:mstk,remove(s:mstk,-3))
         elseif data == 'O'
            let a = remove(s:mstk, -1)
            call add(s:mstk,deepcopy(s:mstk[a]))
         elseif data == '+' 
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            call add(s:mstk,a+b)
         elseif data == '-' 
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            call add(s:mstk,a-b)
         elseif data == '*' 
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            call add(s:mstk,a*b)
         elseif data == '/' 
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            call add(s:mstk,a/b)
         elseif data == '_'
            call add(s:mstk,-remove(s:mstk,-1))
         elseif data == '&'
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            call add(s:mstk,str2nr(system($"echo $(({a}&{b}))")))
         elseif data == '|'
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            call add(s:mstk,str2nr(system($"echo $(({a}|{b}))")))
         elseif data == '~'
            let a = remove(s:mstk, -1)
            call add(s:mstk,str2nr(system($"echo $((~{a}))")))
         elseif data == '='
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            call add(s:mstk, a == b ? -1 : 0)
         elseif data == '>'
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            call add(s:mstk, b > a ? -1 : 0)
         elseif data == '!'
            call add(s:cstk, [s:mode, s:cptr, copy(s:cprg), copy(s:sndq)])
            let s:mode = "exec"
            let s:cptr = -1
            let s:cond = []
            let s:cprg = remove(s:mstk, -1)
         elseif data == '?'
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            if a != 0
               call add(s:cstk, [s:mode, s:cptr, copy(s:cprg), copy(s:sndq)])
               let s:mode = "exec"
               let s:cptr = -1
               let s:cond = []
               let s:cprg = a
            endif
         elseif data == '#'
            let a = remove(s:mstk, -1)
            let b = remove(s:mstk, -1)
            call add(s:cstk, [s:mode, s:cptr, copy(s:cprg), copy(s:sndq)])
            let s:mode = "whilecond"
            let s:cptr = -1
            let s:sndq = a
            let s:cprg = b
         elseif data == '^'
            call add(s:mstk, getchar())
         elseif data == ','
            echo nr2char(remove(s:mstk, -1))
         elseif data == '.'
            echo remove(s:mstk, -1)
         else
            throw 'Invalid Instruction' + data
         endif
      elseif type == 'var'
         call add(s:mstk, data)
      elseif type == 'quot'
         call add(s:mstk, data)
      elseif type == 'num'
         call add(s:mstk, data)
      elseif type == 'print'
         echon data
      else
      endif
   endif
   let s:cptr = s:cptr + 1 
endwhile
