; extends

((comment) @type.builtin (#lua-match? @type.builtin "^//go:"))

((comment) @string (#lua-match? @string "^// *[Tt][Oo][Dd][Oo]"))

([
  (interpreted_string_literal_content)
  (raw_string_literal_content)
  ] @sql.queries
 (#match? @sql.queries "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
)

