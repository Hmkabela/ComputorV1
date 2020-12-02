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
                if div[1].to_f == 0
                    abort(arr1[i] + " : Denominator is 0, Number is undefined")
                end
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
        elsif d[1].to_f < 0
            abort("Cant have negative exponents")
        elsif d[1].include? "/"
            abort("Cant have fractional exponent")
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
    error = 0.000001;
    number = number.to_f
    s = number
    while ((s-number/s) > error)
        s = (s + number / s)/2
    end
    return s;
end