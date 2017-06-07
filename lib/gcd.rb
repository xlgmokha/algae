require 'pp'

def gcd(p, q)
  return p if q == 0
  gcd(q, p % q)
end

fail unless gcd(1440, 408) == 24
fail unless gcd(102, 68) == 34
