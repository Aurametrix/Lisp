(loop for x in '(1 2 3 b 4)
      if (not (integerp x)) return nil
      else collect (1+ x))
