func kilocalories(#fats: Double, #proteins: Double, #carbohydrates: Double) ->Double
{
    return 4 * (carbohydrates + proteins) + 9 * fats;
}

var fats = 20.0
var proteins = 15.0
var carbohydrates = 32.0


println("kilocalories = \(kilocalories(fats: fats, proteins: proteins, carbohydrates: carbohydrates))")