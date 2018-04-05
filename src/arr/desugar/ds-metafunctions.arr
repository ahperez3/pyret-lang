provide *

include string-dict
include file("ds-structs.arr")
import file("ds-resugar.arr") as RS

fun reverse-term(e):
  cases (Term) e:
    | g-list(lst) => g-list(lst.reverse())
    | else => fail("Reverse bijection: expected a list, but found: " + tostring(e))
  end
end

add-bijection("reverse", reverse-term, reverse-term)

add-metafunction("get-loc-of", 1,
  lam(args, _):
    cases (Term) args.get(0):
      | g-core(_, shadow args) => args.get(0)
      # TODO: might want to support g-var
      | else =>
        fail("get-loc-of should be used on an already desugared value. Got " +
             tostring(args.get(0)))
    end
  end)

add-metafunction("resugar", 1,
  lam(args, env):
    cases (Option) RS.resugar(args.get(0)):
      | some(e) => g-option(some(e))
      | none => g-option(none)
    end
  end)

add-metafunction("string-append", 2,
  lam(args, _):
    fun get-string(t :: Term) -> String:
      cases (Term) t:
        | g-prim(p) =>
          cases (GenericPrimitive) p:
            | e-str(s) => s
            | else => fail("string-append: expect a string, got " + tostring(t))
          end
        | else => fail("string-append: expect a string, got " + tostring(t))
      end
    end

    (get-string(args.get(0)) + get-string(args.get(1))) ^ e-str ^ g-prim
  end)

add-metafunction("srcloc-to-string", 1,
  lam(args, _):
    cases (Term) args.get(0):
      | g-prim(p) =>
        cases (GenericPrimitive) p:
          | e-loc(l) => l.format(false) ^ e-str ^ g-prim
          | else => fail("srcloc-to-string: expect a srcloc, got " + tostring(args.get(0)))
        end
      | else => fail("srcloc-to-string: expect a srcloc, got " + tostring(args.get(0)))
    end
  end)
