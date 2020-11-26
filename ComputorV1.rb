require_relative "Functions"
if(ARGV.length != 1)
    abort("Too many or little arguments")
end
pd = 0
lhs = Array.new
rhs = Array.new
degree0 = Array.new
degree1 = Array.new
degree2 = Array.new
equation =  ARGV[0].split("=")
left = equation[0].split(" ")
right = equation[1].split(" ")
solve(lhs,left)
solve(rhs,right)
flipSign(rhs)
fin = lhs + rhs
pd = degree_sort(degree0,degree1,degree2,fin)
a = b = c = ""
a = simplify(degree2)
b = simplify(degree1)
c = simplify(degree0)
if a[0] == '0'
    pd -= 1
end
if pd == 2
    puts "Reduced form: "+a+" + "+b+" + "+c+" = 0"
elsif pd == 1
    puts "Reduced form: "+b+" + "+c+" = 0"
end
puts "Polynomial degree: " + pd.to_s
if(pd > 2)
    abort("The polynomial degree is stricly greater than 2, I can't solve.")
end
a = a.to_f
b = b.to_f
c = c.to_f
discriminant =(b*b) - (4*(a*c))
if pd == 0
    if discriminant == 0
        abort("This equation accepts all real numbers as solution.")
    else
        abort("This equation has no solution.")
    end
end
discriminant = discriminant.to_f
if pd == 2
    if discriminant > 0
        puts "Discriminant is strictly positive, the two solutions are:"
    elsif discriminant < 0
        puts "Discriminant is strictly negative, the two solutions are:"
    else
        puts "Discriminant is zero, the solution is:"
        sol = (-b - sqroot(discriminant)) / (2 * a)
        abort(sol.to_s)
    end
    sol1 = (-b - sqroot(discriminant)) / (2 * a)
    sol2 = (-b + sqroot(discriminant)) / (2 * a)
    puts sol1
    puts sol2
elsif pd == 1
    sol = -c/b
    puts sol
end