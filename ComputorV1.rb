#!/usr/bin/ruby -w
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
def solve(arr1,arr2)
    i = 0
    i2 = 1
    arr1[i] = arr2[0]
    while i2 < arr2.length
        if(arr2[i2] == "+" || arr2[i2] == "-")
            i += 1
            arr1[i] = arr2[i2]
        else
            if arr1[i].include? "/"
                div = arr1[i].split("/")
                arr1[i] = (div[0].to_f / div[1].to_f).to_s
            end
            arr1[i] = arr1[i] + arr2[i2]
        end
        i2 += 1
    end
end
def flipSign(arr)
    i = 0
    while(i < arr.length)
        if(arr[i][0] == '-')
            arr[i][0] = '+'
        elsif (arr[i][0] == '+')
            arr[i][0] = '-'
        else
            arr[i] = "-" + arr[i]
        end
        i += 1
    end
end
def degree_sort(degree0,degree1,degree2,fin)
    i = 0
    pd = 0
    while i < fin.length
        d = fin[i].split("^")
        if d[1] == "0"
            degree0.append(fin[i])
        elsif d[1] == "1"
            degree1.append(fin[i])
        elsif d[1] == "2"
            degree2.append(fin[i])
        end
        if(d[1].to_i > pd)
            pd = d[1].to_i
        end
        i += 1
    end
    if(degree0.length == 0)
        degree0.append("0*X^0")
    elsif(degree1.length == 0)
        degree1.append("0*X^1")
    elsif(degree2.length == 0)
        degree2.append("0*X^2")
    end
    return pd
end
def simplify(degree)
    i = 0
    tot = 0
    a = ""
    if degree.length > 0
        m = degree[i].split("*")
        while(i < degree.length)
            s = degree[i].split("*")
            tot = tot + s[0].to_f
            i += 1
        end
        t = tot.to_s.split(".")
        tot = (t[1] == "0") ? t[0] : tot
        a = tot.to_s + "*" + m[1]
    end
    return a
end
def sqroot(number)
    error = 0.000001;#define the precision of your result
    number = number.to_f
    s = number
    while ((s-number/s) > error) #loop until precision satisfied
        s = (s + number / s)/2
    end
    return s;
end
solve(lhs,left)
solve(rhs,right)
flipSign(rhs)
fin = lhs + rhs
pd = degree_sort(degree0,degree1,degree2,fin)
a = ""
b = ""
c = ""
a = simplify(degree2)
b = simplify(degree1)
c = simplify(degree0)
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