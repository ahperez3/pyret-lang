# THIS FILE IS AUTOMATICALLY GENERATED FROM autogenerate.arr. PLEASE DO NOT EDIT.
provide *

include ast
include string-dict
include lists
include option
include json-structs
include srcloc
import global as _
import base as _
aTYPE = "t"
aVALUE = "v"
aNAME = "n"
aPATTERNS = "ps"
aSTRING = "St"
aNUMBER = "N"
aBOOL = "B"
aLOC = "Lo"
aSURFACE = "S"
aCORE = "C"
aLIST = "L"
aNONE = "None"
aSOME = "Some"
aVAR = "Var"
aTAG = "Tag"
aPVAR = "PVar"
aDROP = "Drop"
aFRESH = "Fresh"
aCAPTURE = "Capture"
aEXT = "Ext"
aAUX = "Aux"
aMETA = "Meta"
fun wrap-str(s): { t: aSTRING, v: s } end
fun wrap-num(n): { t: aNUMBER, v: num-to-string(n) } end
fun wrap-bool(b): { t: aBOOL, v: b } end
fun wrap-loc(l): { t: aLOC, v: l.serialize() } end
fun wrap-surf(name, args):
  { t: aSURFACE, n: name, ps: builtins.raw-array-from-list(args) }
end
fun wrap-list(l): { t: aLIST, v: builtins.raw-array-from-list(l) } end
fun wrap-option(opt):
  cases(Option) opt: | none => { t: aNONE } | some(v) => { t: aSOME, v: v } end
end
shadow ast-to-term-visitor =
  {
    method option(self, opt): opt.and-then(_.visit(self)) end,
    method list(self, lst): lst.map(_.visit(self)) end,
    method s-underscore(self, l):
      wrap-surf("s-underscore", [list: wrap-loc(l)])
    end,
    method s-name(self, l, s):
      {
        t: aSURFACE,
        n: "s-name",
        ps: [raw-array: wrap-loc(l), { t: aVAR, v: s }]
      }
    end,
    method s-global(self, s):
      wrap-surf("s-global", [list: wrap-loc(dummy-loc), wrap-str(s)])
    end,
    method s-type-global(self, s):
      wrap-surf("s-type-global", [list: wrap-loc(dummy-loc), wrap-str(s)])
    end,
    method s-atom(self, base, serial):
      wrap-surf("s-atom",
        [list: wrap-loc(dummy-loc), wrap-str(base), wrap-num(serial)])
    end,
    method app-info-c(self, is-recursive, is-tail):
      wrap-surf("app-info-c",
        [list: wrap-loc(dummy-loc), wrap-bool(is-recursive), wrap-bool(is-tail)])
    end,
    method prim-app-info-c(self, needs-step):
      wrap-surf("prim-app-info-c",
        [list: wrap-loc(dummy-loc), wrap-bool(needs-step)])
    end,
    method s-program(self, l, _provide, provided-types, imports, block):
      wrap-surf("s-program",
        [list: 
          wrap-loc(l),
          _provide.visit(self),
          provided-types.visit(self),
          wrap-list(self.list(imports)),
          block.visit(self)
        ])
    end,
    method s-include(self, l, mod):
      wrap-surf("s-include", [list: wrap-loc(l), mod.visit(self)])
    end,
    method s-import(self, l, file, name):
      wrap-surf("s-import",
        [list: wrap-loc(l), file.visit(self), name.visit(self)])
    end,
    method s-import-types(self, l, file, name, types):
      wrap-surf("s-import-types",
        [list: 
          wrap-loc(l),
          file.visit(self),
          name.visit(self),
          types.visit(self)
        ])
    end,
    method s-import-fields(self, l, fields, file):
      wrap-surf("s-import-fields",
        [list: wrap-loc(l), wrap-list(self.list(fields)), file.visit(self)])
    end,
    method s-import-complete(
        self,
        l,
        values,
        types,
        import-type,
        vals-name,
        types-name
      ):
      wrap-surf("s-import-complete",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(values)),
          wrap-list(self.list(types)),
          import-type.visit(self),
          vals-name.visit(self),
          types-name.visit(self)
        ])
    end,
    method p-value(self, l, v, ann):
      wrap-surf("p-value", [list: wrap-loc(l), v.visit(self), ann.visit(self)])
    end,
    method p-alias(self, l, in-name, out-name, mod):
      wrap-surf("p-alias",
        [list: 
          wrap-loc(l),
          in-name.visit(self),
          out-name.visit(self),
          wrap-option(self.option(mod))
        ])
    end,
    method p-data(self, l, d, mod):
      wrap-surf("p-data",
        [list: wrap-loc(l), d.visit(self), wrap-option(self.option(mod))])
    end,
    method s-provide(self, l, block):
      wrap-surf("s-provide", [list: wrap-loc(l), block.visit(self)])
    end,
    method s-provide-complete(self, l, values, aliases, data-definitions):
      wrap-surf("s-provide-complete",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(values)),
          wrap-list(self.list(aliases)),
          wrap-list(self.list(data-definitions))
        ])
    end,
    method s-provide-all(self, l):
      wrap-surf("s-provide-all", [list: wrap-loc(l)])
    end,
    method s-provide-none(self, l):
      wrap-surf("s-provide-none", [list: wrap-loc(l)])
    end,
    method s-provide-types(self, l, ann):
      wrap-surf("s-provide-types",
        [list: wrap-loc(l), wrap-list(self.list(ann))])
    end,
    method s-provide-types-all(self, l):
      wrap-surf("s-provide-types-all", [list: wrap-loc(l)])
    end,
    method s-provide-types-none(self, l):
      wrap-surf("s-provide-types-none", [list: wrap-loc(l)])
    end,
    method s-const-import(self, l, mod):
      wrap-surf("s-const-import", [list: wrap-loc(l), wrap-str(mod)])
    end,
    method s-special-import(self, l, kind, args):
      wrap-surf("s-special-import",
        [list: wrap-loc(l), wrap-str(kind), wrap-list(args.map(wrap-str))])
    end,
    method h-use-loc(self, l): wrap-surf("h-use-loc", [list: wrap-loc(l)]) end,
    method s-let-bind(self, l, b, value):
      wrap-surf("s-let-bind",
        [list: wrap-loc(l), b.visit(self), value.visit(self)])
    end,
    method s-var-bind(self, l, b, value):
      wrap-surf("s-var-bind",
        [list: wrap-loc(l), b.visit(self), value.visit(self)])
    end,
    method s-letrec-bind(self, l, b, value):
      wrap-surf("s-letrec-bind",
        [list: wrap-loc(l), b.visit(self), value.visit(self)])
    end,
    method s-type-bind(self, l, name, params, ann):
      wrap-surf("s-type-bind",
        [list: 
          wrap-loc(l),
          name.visit(self),
          wrap-list(self.list(params)),
          ann.visit(self)
        ])
    end,
    method s-newtype-bind(self, l, name, namet):
      wrap-surf("s-newtype-bind",
        [list: wrap-loc(l), name.visit(self), namet.visit(self)])
    end,
    method s-defined-value(self, name, value):
      wrap-surf("s-defined-value",
        [list: wrap-loc(dummy-loc), wrap-str(name), value.visit(self)])
    end,
    method s-defined-var(self, name, id):
      wrap-surf("s-defined-var",
        [list: wrap-loc(dummy-loc), wrap-str(name), id.visit(self)])
    end,
    method s-defined-type(self, name, typ):
      wrap-surf("s-defined-type",
        [list: wrap-loc(dummy-loc), wrap-str(name), typ.visit(self)])
    end,
    method s-module(
        self,
        l,
        answer,
        defined-values,
        defined-types,
        provided-values,
        provided-types,
        checks
      ):
      wrap-surf("s-module",
        [list: 
          wrap-loc(l),
          answer.visit(self),
          wrap-list(self.list(defined-values)),
          wrap-list(self.list(defined-types)),
          provided-values.visit(self),
          wrap-list(self.list(provided-types)),
          checks.visit(self)
        ])
    end,
    method s-template(self, l): wrap-surf("s-template", [list: wrap-loc(l)]) end,
    method s-type-let-expr(self, l, binds, body, blocky):
      wrap-surf("s-type-let-expr",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(binds)),
          body.visit(self),
          wrap-bool(blocky)
        ])
    end,
    method s-let-expr(self, l, binds, body, blocky):
      wrap-surf("s-let-expr",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(binds)),
          body.visit(self),
          wrap-bool(blocky)
        ])
    end,
    method s-letrec(self, l, binds, body, blocky):
      wrap-surf("s-letrec",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(binds)),
          body.visit(self),
          wrap-bool(blocky)
        ])
    end,
    method s-hint-exp(self, l, hints, exp):
      wrap-surf("s-hint-exp",
        [list: wrap-loc(l), wrap-list(self.list(hints)), exp.visit(self)])
    end,
    method s-instantiate(self, l, expr, params):
      wrap-surf("s-instantiate",
        [list: wrap-loc(l), expr.visit(self), wrap-list(self.list(params))])
    end,
    method s-block(self, l, stmts):
      wrap-surf("s-block", [list: wrap-loc(l), wrap-list(self.list(stmts))])
    end,
    method s-user-block(self, l, body):
      wrap-surf("s-user-block", [list: wrap-loc(l), body.visit(self)])
    end,
    method s-fun(
        self,
        l,
        name,
        params,
        args,
        ann,
        doc,
        body,
        _check-loc,
        _check,
        blocky
      ):
      wrap-surf("s-fun",
        [list: 
          wrap-loc(l),
          wrap-str(name),
          wrap-list(self.list(params)),
          wrap-list(self.list(args)),
          ann.visit(self),
          wrap-str(doc),
          body.visit(self),
          wrap-option(_check-loc.and-then(wrap-loc)),
          wrap-option(self.option(_check)),
          wrap-bool(blocky)
        ])
    end,
    method s-type(self, l, name, params, ann):
      wrap-surf("s-type",
        [list: 
          wrap-loc(l),
          name.visit(self),
          wrap-list(self.list(params)),
          ann.visit(self)
        ])
    end,
    method s-newtype(self, l, name, namet):
      wrap-surf("s-newtype",
        [list: wrap-loc(l), name.visit(self), namet.visit(self)])
    end,
    method s-var(self, l, name, value):
      wrap-surf("s-var",
        [list: wrap-loc(l), name.visit(self), value.visit(self)])
    end,
    method s-rec(self, l, name, value):
      wrap-surf("s-rec",
        [list: wrap-loc(l), name.visit(self), value.visit(self)])
    end,
    method s-let(self, l, name, value, keyword-val):
      wrap-surf("s-let",
        [list: 
          wrap-loc(l),
          name.visit(self),
          value.visit(self),
          wrap-bool(keyword-val)
        ])
    end,
    method s-ref(self, l, ann):
      wrap-surf("s-ref", [list: wrap-loc(l), wrap-option(self.option(ann))])
    end,
    method s-contract(self, l, name, params, ann):
      wrap-surf("s-contract",
        [list: 
          wrap-loc(l),
          name.visit(self),
          wrap-list(self.list(params)),
          ann.visit(self)
        ])
    end,
    method s-when(self, l, test, block, blocky):
      wrap-surf("s-when",
        [list: 
          wrap-loc(l),
          test.visit(self),
          block.visit(self),
          wrap-bool(blocky)
        ])
    end,
    method s-assign(self, l, id, value):
      wrap-surf("s-assign",
        [list: wrap-loc(l), id.visit(self), value.visit(self)])
    end,
    method s-if-pipe(self, l, branches, blocky):
      wrap-surf("s-if-pipe",
        [list: wrap-loc(l), wrap-list(self.list(branches)), wrap-bool(blocky)])
    end,
    method s-if-pipe-else(self, l, branches, _else, blocky):
      wrap-surf("s-if-pipe-else",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(branches)),
          _else.visit(self),
          wrap-bool(blocky)
        ])
    end,
    method s-if(self, l, branches, blocky):
      wrap-surf("s-if",
        [list: wrap-loc(l), wrap-list(self.list(branches)), wrap-bool(blocky)])
    end,
    method s-if-else(self, l, branches, _else, blocky):
      wrap-surf("s-if-else",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(branches)),
          _else.visit(self),
          wrap-bool(blocky)
        ])
    end,
    method s-cases(self, l, typ, val, branches, blocky):
      wrap-surf("s-cases",
        [list: 
          wrap-loc(l),
          typ.visit(self),
          val.visit(self),
          wrap-list(self.list(branches)),
          wrap-bool(blocky)
        ])
    end,
    method s-cases-else(self, l, typ, val, branches, _else, blocky):
      wrap-surf("s-cases-else",
        [list: 
          wrap-loc(l),
          typ.visit(self),
          val.visit(self),
          wrap-list(self.list(branches)),
          _else.visit(self),
          wrap-bool(blocky)
        ])
    end,
    method s-op(self, l, op-l, op, left, right):
      wrap-surf("s-op",
        [list: 
          wrap-loc(l),
          wrap-loc(op-l),
          wrap-str(op),
          left.visit(self),
          right.visit(self)
        ])
    end,
    method s-check-test(self, l, op, refinement, left, right):
      wrap-surf("s-check-test",
        [list: 
          wrap-loc(l),
          op.visit(self),
          wrap-option(self.option(refinement)),
          left.visit(self),
          wrap-option(self.option(right))
        ])
    end,
    method s-check-expr(self, l, expr, ann):
      wrap-surf("s-check-expr",
        [list: wrap-loc(l), expr.visit(self), ann.visit(self)])
    end,
    method s-paren(self, l, expr):
      wrap-surf("s-paren", [list: wrap-loc(l), expr.visit(self)])
    end,
    method s-lam(
        self,
        l,
        name,
        params,
        args,
        ann,
        doc,
        body,
        _check-loc,
        _check,
        blocky
      ):
      wrap-surf("s-lam",
        [list: 
          wrap-loc(l),
          wrap-str(name),
          wrap-list(self.list(params)),
          wrap-list(self.list(args)),
          ann.visit(self),
          wrap-str(doc),
          body.visit(self),
          wrap-option(_check-loc.and-then(wrap-loc)),
          wrap-option(self.option(_check)),
          wrap-bool(blocky)
        ])
    end,
    method s-method(
        self,
        l,
        name,
        params,
        args,
        ann,
        doc,
        body,
        _check-loc,
        _check,
        blocky
      ):
      wrap-surf("s-method",
        [list: 
          wrap-loc(l),
          wrap-str(name),
          wrap-list(self.list(params)),
          wrap-list(self.list(args)),
          ann.visit(self),
          wrap-str(doc),
          body.visit(self),
          wrap-option(_check-loc.and-then(wrap-loc)),
          wrap-option(self.option(_check)),
          wrap-bool(blocky)
        ])
    end,
    method s-extend(self, l, supe, fields):
      wrap-surf("s-extend",
        [list: wrap-loc(l), supe.visit(self), wrap-list(self.list(fields))])
    end,
    method s-update(self, l, supe, fields):
      wrap-surf("s-update",
        [list: wrap-loc(l), supe.visit(self), wrap-list(self.list(fields))])
    end,
    method s-tuple(self, l, fields):
      wrap-surf("s-tuple", [list: wrap-loc(l), wrap-list(self.list(fields))])
    end,
    method s-tuple-get(self, l, tup, index, index-loc):
      wrap-surf("s-tuple-get",
        [list: 
          wrap-loc(l),
          tup.visit(self),
          wrap-num(index),
          wrap-loc(index-loc)
        ])
    end,
    method s-obj(self, l, fields):
      wrap-surf("s-obj", [list: wrap-loc(l), wrap-list(self.list(fields))])
    end,
    method s-array(self, l, values):
      wrap-surf("s-array", [list: wrap-loc(l), wrap-list(self.list(values))])
    end,
    method s-construct(self, l, modifier, constructor, values):
      wrap-surf("s-construct",
        [list: 
          wrap-loc(l),
          modifier.visit(self),
          constructor.visit(self),
          wrap-list(self.list(values))
        ])
    end,
    method s-app(self, l, _fun, args):
      cases(Expr) _fun:
        | s-dot(l-dot, obj, field) =>
          {
              t: aSURFACE,
              n: "s-method-app",
              ps: [raw-array: 
                  wrap-loc(l),
                  wrap-loc(l-dot),
                  obj.visit(self),
                  wrap-str(field),
                  wrap-list(self.list(args))
                ]
            }
        | else =>
          wrap-surf("s-app",
            [list: wrap-loc(l), _fun.visit(self), wrap-list(self.list(args))])
      end
    end,
    method s-app-enriched(self, l, _fun, args, app-info):
      wrap-surf("s-app-enriched",
        [list: 
          wrap-loc(l),
          _fun.visit(self),
          wrap-list(self.list(args)),
          app-info.visit(self)
        ])
    end,
    method s-prim-app(self, l, _fun, args, app-info):
      wrap-surf("s-prim-app",
        [list: 
          wrap-loc(l),
          wrap-str(_fun),
          wrap-list(self.list(args)),
          app-info.visit(self)
        ])
    end,
    method s-prim-val(self, l, name):
      wrap-surf("s-prim-val", [list: wrap-loc(l), wrap-str(name)])
    end,
    method s-id(self, l, id):
      wrap-surf("s-id", [list: wrap-loc(l), id.visit(self)])
    end,
    method s-id-var(self, l, id):
      wrap-surf("s-id-var", [list: wrap-loc(l), id.visit(self)])
    end,
    method s-id-letrec(self, l, id, safe):
      wrap-surf("s-id-letrec",
        [list: wrap-loc(l), id.visit(self), wrap-bool(safe)])
    end,
    method s-undefined(self, l):
      wrap-surf("s-undefined", [list: wrap-loc(l)])
    end,
    method s-srcloc(self, l, loc):
      wrap-surf("s-srcloc", [list: wrap-loc(l), wrap-loc(loc)])
    end,
    method s-num(self, l, n):
      wrap-surf("s-num", [list: wrap-loc(l), wrap-num(n)])
    end,
    method s-frac(self, l, num, den):
      wrap-surf("s-frac", [list: wrap-loc(l), wrap-num(num), wrap-num(den)])
    end,
    method s-rfrac(self, l, num, den):
      wrap-surf("s-rfrac", [list: wrap-loc(l), wrap-num(num), wrap-num(den)])
    end,
    method s-bool(self, l, b):
      wrap-surf("s-bool", [list: wrap-loc(l), wrap-bool(b)])
    end,
    method s-str(self, l, s):
      wrap-surf("s-str", [list: wrap-loc(l), wrap-str(s)])
    end,
    method s-dot(self, l, obj, field):
      wrap-surf("s-dot", [list: wrap-loc(l), obj.visit(self), wrap-str(field)])
    end,
    method s-get-bang(self, l, obj, field):
      wrap-surf("s-get-bang",
        [list: wrap-loc(l), obj.visit(self), wrap-str(field)])
    end,
    method s-bracket(self, l, obj, key):
      wrap-surf("s-bracket",
        [list: wrap-loc(l), obj.visit(self), key.visit(self)])
    end,
    method s-data(
        self,
        l,
        name,
        params,
        mixins,
        variants,
        shared-members,
        _check-loc,
        _check
      ):
      wrap-surf("s-data",
        [list: 
          wrap-loc(l),
          wrap-str(name),
          wrap-list(self.list(params)),
          wrap-list(self.list(mixins)),
          wrap-list(self.list(variants)),
          wrap-list(self.list(shared-members)),
          wrap-option(_check-loc.and-then(wrap-loc)),
          wrap-option(self.option(_check))
        ])
    end,
    method s-data-expr(
        self,
        l,
        name,
        namet,
        params,
        mixins,
        variants,
        shared-members,
        _check-loc,
        _check
      ):
      wrap-surf("s-data-expr",
        [list: 
          wrap-loc(l),
          wrap-str(name),
          namet.visit(self),
          wrap-list(self.list(params)),
          wrap-list(self.list(mixins)),
          wrap-list(self.list(variants)),
          wrap-list(self.list(shared-members)),
          wrap-option(_check-loc.and-then(wrap-loc)),
          wrap-option(self.option(_check))
        ])
    end,
    method s-for(self, l, iterator, bindings, ann, body, blocky):
      wrap-surf("s-for",
        [list: 
          wrap-loc(l),
          iterator.visit(self),
          wrap-list(self.list(bindings)),
          ann.visit(self),
          body.visit(self),
          wrap-bool(blocky)
        ])
    end,
    method s-check(self, l, name, body, keyword-check):
      wrap-surf("s-check",
        [list: 
          wrap-loc(l),
          wrap-option(name.and-then(wrap-str)),
          body.visit(self),
          wrap-bool(keyword-check)
        ])
    end,
    method s-reactor(self, l, fields):
      wrap-surf("s-reactor", [list: wrap-loc(l), wrap-list(self.list(fields))])
    end,
    method s-table-extend(self, l, column-binds, extensions):
      wrap-surf("s-table-extend",
        [list: 
          wrap-loc(l),
          column-binds.visit(self),
          wrap-list(self.list(extensions))
        ])
    end,
    method s-table-update(self, l, column-binds, updates):
      wrap-surf("s-table-update",
        [list: 
          wrap-loc(l),
          column-binds.visit(self),
          wrap-list(self.list(updates))
        ])
    end,
    method s-table-select(self, l, columns, table):
      wrap-surf("s-table-select",
        [list: wrap-loc(l), wrap-list(self.list(columns)), table.visit(self)])
    end,
    method s-table-order(self, l, table, ordering):
      wrap-surf("s-table-order",
        [list: wrap-loc(l), table.visit(self), wrap-list(self.list(ordering))])
    end,
    method s-table-filter(self, l, column-binds, predicate):
      wrap-surf("s-table-filter",
        [list: wrap-loc(l), column-binds.visit(self), predicate.visit(self)])
    end,
    method s-table-extract(self, l, column, table):
      wrap-surf("s-table-extract",
        [list: wrap-loc(l), column.visit(self), table.visit(self)])
    end,
    method s-table(self, l, headers, rows):
      wrap-surf("s-table",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(headers)),
          wrap-list(self.list(rows))
        ])
    end,
    method s-load-table(self, l, headers, spec):
      wrap-surf("s-load-table",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(headers)),
          wrap-list(self.list(spec))
        ])
    end,
    method s-spy-block(self, l, message, contents):
      wrap-surf("s-spy-block",
        [list: 
          wrap-loc(l),
          wrap-option(self.option(message)),
          wrap-list(self.list(contents))
        ])
    end,
    method s-table-row(self, l, elems):
      wrap-surf("s-table-row", [list: wrap-loc(l), wrap-list(self.list(elems))])
    end,
    method s-spy-expr(self, l, name, value, implicit-label):
      wrap-surf("s-spy-expr",
        [list: 
          wrap-loc(l),
          wrap-str(name),
          value.visit(self),
          wrap-bool(implicit-label)
        ])
    end,
    method s-construct-normal(self):
      wrap-surf("s-construct-normal", [list: wrap-loc(dummy-loc)])
    end,
    method s-construct-lazy(self):
      wrap-surf("s-construct-lazy", [list: wrap-loc(dummy-loc)])
    end,
    method s-bind(self, l, shadows, id, ann):
      wrap-surf("s-bind",
        [list: wrap-loc(l), wrap-bool(shadows), id.visit(self), ann.visit(self)])
    end,
    method s-tuple-bind(self, l, fields, as-name):
      wrap-surf("s-tuple-bind",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(fields)),
          wrap-option(self.option(as-name))
        ])
    end,
    method s-data-field(self, l, name, value):
      wrap-surf("s-data-field",
        [list: wrap-loc(l), wrap-str(name), value.visit(self)])
    end,
    method s-mutable-field(self, l, name, ann, value):
      wrap-surf("s-mutable-field",
        [list: wrap-loc(l), wrap-str(name), ann.visit(self), value.visit(self)])
    end,
    method s-method-field(
        self,
        l,
        name,
        params,
        args,
        ann,
        doc,
        body,
        _check-loc,
        _check,
        blocky
      ):
      wrap-surf("s-method-field",
        [list: 
          wrap-loc(l),
          wrap-str(name),
          wrap-list(self.list(params)),
          wrap-list(self.list(args)),
          ann.visit(self),
          wrap-str(doc),
          body.visit(self),
          wrap-option(_check-loc.and-then(wrap-loc)),
          wrap-option(self.option(_check)),
          wrap-bool(blocky)
        ])
    end,
    method s-field-name(self, l, name, ann):
      wrap-surf("s-field-name",
        [list: wrap-loc(l), wrap-str(name), ann.visit(self)])
    end,
    method s-for-bind(self, l, bind, value):
      wrap-surf("s-for-bind",
        [list: wrap-loc(l), bind.visit(self), value.visit(self)])
    end,
    method s-column-binds(self, l, binds, table):
      wrap-surf("s-column-binds",
        [list: wrap-loc(l), wrap-list(self.list(binds)), table.visit(self)])
    end,
    method ASCENDING(self):
      wrap-surf("ASCENDING", [list: wrap-loc(dummy-loc)])
    end,
    method DESCENDING(self):
      wrap-surf("DESCENDING", [list: wrap-loc(dummy-loc)])
    end,
    method s-column-sort(self, l, column, direction):
      wrap-surf("s-column-sort",
        [list: wrap-loc(l), column.visit(self), direction.visit(self)])
    end,
    method s-table-extend-field(self, l, name, value, ann):
      wrap-surf("s-table-extend-field",
        [list: wrap-loc(l), wrap-str(name), value.visit(self), ann.visit(self)])
    end,
    method s-table-extend-reducer(self, l, name, reducer, col, ann):
      wrap-surf("s-table-extend-reducer",
        [list: 
          wrap-loc(l),
          wrap-str(name),
          reducer.visit(self),
          col.visit(self),
          ann.visit(self)
        ])
    end,
    method s-sanitize(self, l, name, sanitizer):
      wrap-surf("s-sanitize",
        [list: wrap-loc(l), name.visit(self), sanitizer.visit(self)])
    end,
    method s-table-src(self, l, src):
      wrap-surf("s-table-src", [list: wrap-loc(l), src.visit(self)])
    end,
    method s-normal(self):
      wrap-surf("s-normal", [list: wrap-loc(dummy-loc)])
    end,
    method s-mutable(self):
      wrap-surf("s-mutable", [list: wrap-loc(dummy-loc)])
    end,
    method s-variant-member(self, l, member-type, bind):
      wrap-surf("s-variant-member",
        [list: wrap-loc(l), member-type.visit(self), bind.visit(self)])
    end,
    method s-variant(self, l, constr-loc, name, members, with-members):
      wrap-surf("s-variant",
        [list: 
          wrap-loc(l),
          wrap-loc(constr-loc),
          wrap-str(name),
          wrap-list(self.list(members)),
          wrap-list(self.list(with-members))
        ])
    end,
    method s-singleton-variant(self, l, name, with-members):
      wrap-surf("s-singleton-variant",
        [list: wrap-loc(l), wrap-str(name), wrap-list(self.list(with-members))])
    end,
    method s-if-branch(self, l, test, body):
      wrap-surf("s-if-branch",
        [list: wrap-loc(l), test.visit(self), body.visit(self)])
    end,
    method s-if-pipe-branch(self, l, test, body):
      wrap-surf("s-if-pipe-branch",
        [list: wrap-loc(l), test.visit(self), body.visit(self)])
    end,
    method s-cases-bind-ref(self):
      wrap-surf("s-cases-bind-ref", [list: wrap-loc(dummy-loc)])
    end,
    method s-cases-bind-normal(self):
      wrap-surf("s-cases-bind-normal", [list: wrap-loc(dummy-loc)])
    end,
    method s-cases-bind(self, l, field-type, bind):
      wrap-surf("s-cases-bind",
        [list: wrap-loc(l), field-type.visit(self), bind.visit(self)])
    end,
    method s-cases-branch(self, l, pat-loc, name, args, body):
      wrap-surf("s-cases-branch",
        [list: 
          wrap-loc(l),
          wrap-loc(pat-loc),
          wrap-str(name),
          wrap-list(self.list(args)),
          body.visit(self)
        ])
    end,
    method s-singleton-cases-branch(self, l, pat-loc, name, body):
      wrap-surf("s-singleton-cases-branch",
        [list: wrap-loc(l), wrap-loc(pat-loc), wrap-str(name), body.visit(self)])
    end,
    method s-op-is(self, l): wrap-surf("s-op-is", [list: wrap-loc(l)]) end,
    method s-op-is-roughly(self, l):
      wrap-surf("s-op-is-roughly", [list: wrap-loc(l)])
    end,
    method s-op-is-op(self, l, op):
      wrap-surf("s-op-is-op", [list: wrap-loc(l), wrap-str(op)])
    end,
    method s-op-is-not(self, l):
      wrap-surf("s-op-is-not", [list: wrap-loc(l)])
    end,
    method s-op-is-not-op(self, l, op):
      wrap-surf("s-op-is-not-op", [list: wrap-loc(l), wrap-str(op)])
    end,
    method s-op-satisfies(self, l):
      wrap-surf("s-op-satisfies", [list: wrap-loc(l)])
    end,
    method s-op-satisfies-not(self, l):
      wrap-surf("s-op-satisfies-not", [list: wrap-loc(l)])
    end,
    method s-op-raises(self, l):
      wrap-surf("s-op-raises", [list: wrap-loc(l)])
    end,
    method s-op-raises-other(self, l):
      wrap-surf("s-op-raises-other", [list: wrap-loc(l)])
    end,
    method s-op-raises-not(self, l):
      wrap-surf("s-op-raises-not", [list: wrap-loc(l)])
    end,
    method s-op-raises-satisfies(self, l):
      wrap-surf("s-op-raises-satisfies", [list: wrap-loc(l)])
    end,
    method s-op-raises-violates(self, l):
      wrap-surf("s-op-raises-violates", [list: wrap-loc(l)])
    end,
    method a-blank(self): wrap-surf("a-blank", [list: wrap-loc(dummy-loc)]) end,
    method a-any(self, l): wrap-surf("a-any", [list: wrap-loc(l)]) end,
    method a-name(self, l, id):
      wrap-surf("a-name", [list: wrap-loc(l), id.visit(self)])
    end,
    method a-type-var(self, l, id):
      wrap-surf("a-type-var", [list: wrap-loc(l), id.visit(self)])
    end,
    method a-arrow(self, l, args, ret, use-parens):
      wrap-surf("a-arrow",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(args)),
          ret.visit(self),
          wrap-bool(use-parens)
        ])
    end,
    method a-arrow-argnames(self, l, args, ret, use-parens):
      wrap-surf("a-arrow-argnames",
        [list: 
          wrap-loc(l),
          wrap-list(self.list(args)),
          ret.visit(self),
          wrap-bool(use-parens)
        ])
    end,
    method a-method(self, l, args, ret):
      wrap-surf("a-method",
        [list: wrap-loc(l), wrap-list(self.list(args)), ret.visit(self)])
    end,
    method a-record(self, l, fields):
      wrap-surf("a-record", [list: wrap-loc(l), wrap-list(self.list(fields))])
    end,
    method a-tuple(self, l, fields):
      wrap-surf("a-tuple", [list: wrap-loc(l), wrap-list(self.list(fields))])
    end,
    method a-app(self, l, ann, args):
      wrap-surf("a-app",
        [list: wrap-loc(l), ann.visit(self), wrap-list(self.list(args))])
    end,
    method a-pred(self, l, ann, exp):
      wrap-surf("a-pred", [list: wrap-loc(l), ann.visit(self), exp.visit(self)])
    end,
    method a-dot(self, l, obj, field):
      wrap-surf("a-dot", [list: wrap-loc(l), obj.visit(self), wrap-str(field)])
    end,
    method a-checked(self, checked, residual):
      wrap-surf("a-checked",
        [list: wrap-loc(dummy-loc), checked.visit(self), residual.visit(self)])
    end,
    method a-field(self, l, name, ann):
      wrap-surf("a-field", [list: wrap-loc(l), wrap-str(name), ann.visit(self)])
    end
  }