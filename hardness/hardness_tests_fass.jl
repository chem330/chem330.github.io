[
inst_ca_stock = 0.51136 # mg/L
inst_mg_stock = 0.5860 # mg/L

function check_dilutions(X, stock, vf, pip; species, a = 0.00001)
  if all(.!ismissing.(vf)) && all(.!ismissing.(pip)) && all(.!ismissing.(X))
    if all(isapprox.(X, stock .* pip ./ vf, atol = a)) || all(isapprox.(reverse(X), stock .* pip ./ vf), atol = a) 
      Markdown.MD(Markdown.Admonition("correct", "Correct!", [md"Your $(species) standard concentrations appear to be correct!"]))
    else
      Markdown.MD(Markdown.Admonition("danger", "This doesn't seem right...", [md"One or more of your $(species) standard concentrations is incorrect."]))
    end
  end
end
]
