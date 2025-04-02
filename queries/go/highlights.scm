; extends

((comment) @string (#lua-match? @string "^//go:"))

([
  (interpreted_string_literal_content)
  (raw_string_literal_content)
  ] @sql.queries
 (#match? @sql.queries "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete).+(FROM|from|INTO|into|VALUES|values|SET|set).*(WHERE|where|GROUP BY|group by)?")
)
