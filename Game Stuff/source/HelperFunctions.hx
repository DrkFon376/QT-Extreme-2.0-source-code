//If I don't put this, CachedFrames doesn't detect it and the game never opens lol
//I only use CatchedFrames to use Expurgation mechanics
class HelperFunctions
{
    public static function truncateFloat( number : Float, precision : Int): Float {
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round( num ) / Math.pow(10, precision);
		return num;
	}
}