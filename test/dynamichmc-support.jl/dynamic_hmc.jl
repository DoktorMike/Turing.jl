using DynamicHMC, Turing, Test

@model gdemo(x, y) = begin
  s ~ InverseGamma(2,3)
  m ~ Normal(0,sqrt(s))
  x ~ Normal(m, sqrt(s))
  y ~ Normal(m, sqrt(s))
  return s, m
end

mf = gdemo(1.5, 2.0)

@time chn = sample(mf, DynamicNUTS(100_000));
@time chn = sample(mf, Turing.NUTS(100_000, 2_000, 0.8));

@test mean(chn[:s].value) ≈ 49/24 atol=0.2
@test mean(chn[:m].value) ≈ 7/6 atol=0.2
1+1
