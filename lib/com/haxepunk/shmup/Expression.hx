package com.haxepunk.shmup;

import com.haxepunk.HXP;
import com.haxepunk.shmup.util.Random;

class Expression
{
	public var string:String;
	
	private var operators:Array<Operator>;
	private var random:Random;
	private var parsedOperators:Array<Array<Operator>>;
	
	public function new(s:String, ?random:Random)
	{
		string = s;
		operators = parseToRPN(string.split(" ").join("").split("\t").join(""));
		
		if ( random != null )
			this.random = random;
		else
			this.random = new Random();
	}
	
	public function calc(actor:Actor):Float
	{
		var vars = actor.vars;
		var stack = new Array<Float>();
		//HXP.console.log(["+[Ex] calc ops", operators.toString()]);
		for (op in operators) 
		{
			switch (op)
			{
				case Value(v):
					stack.push(v);
					
				case Variable(name):
					var v = vars.get(name);
					if (v == null) throw "VARIABLE " + name + " doesn't exist";
					stack.push(v.value);
					
				case ReadOnlyVariable(name):
					stack.push(actor.getReadOnlyVariableValue(name));
					
				case Sin, Cos, UnaryMinus, UnaryNot:
					var v = stack.pop();
					stack.push(calcUnaryOperator(op, v));
					
				case IntRandom, NumberRandom, OrRandom,
				Plus, Minus, Multiple, Division, Modolo,
				Greater, GreaterEqual, Lesser, LesserEqual, Equal, NotEqual, And, Or:
					var v1 = stack.pop();
					var v2 = stack.pop();
					stack.push(calcBinaryOperator(op, v2, v1));
					
				case Ternary:
					var v1 = stack.pop();
					var v2 = stack.pop();
					var v3 = stack.pop();
					stack.push(calcTernaryOperator(op, v3, v2, v1));
					
				default:
					throw "invalid OPERATOR: " + op;
			}
		}
		return stack.pop();
	}
	
	public function getAsName():String
	{
		var op = operators[0];
		switch (op)
		{
			case Variable(name): 
				return name;
			default:
				throw "invalid NAME: " + string;
		}
	}
	
	public static inline function TRUE()
	{
		return new Expression("1");
	}
	public static inline function FALSE()
	{
		return new Expression("0");
	}
	private static inline var PARSED_PREFIX_STRING = "parse_";
	private static inline var PARSED_POSTFIX_STRING = "_d";
	private static inline function PARSED_PATTERN()
	{
		return new EReg("^" + PARSED_PREFIX_STRING + "(\\d+)" + PARSED_POSTFIX_STRING + "$", "");
	}
	private static inline function PARSED_PATTERN_MATCH()
	{
		return new EReg(PARSED_PREFIX_STRING + "(\\d+)" + PARSED_POSTFIX_STRING, "");
	}
	private static inline function IN_BRACKETS_PATTERN()
	{
		return "\\(([^()]+)\\)";
	}
	private static inline function FUNCTION_PATTERN()
	{
		return new EReg("(sin|cos)" + IN_BRACKETS_PATTERN(), "");
	}
	private static inline function BRACKETS_PATTERN()
	{
		return new EReg(IN_BRACKETS_PATTERN(), "");
	}
	private static inline function VALUE_PATTERN()
	{
		return "(\\d+(?:\\.\\d+)?|[@\\$:]?\\w+)";
	}
	private static inline function UNARY_PATTERN()
	{
		return new EReg("([!\\._\\|*\\/%\\+\\-<>=%&\\?:]|^)([\\-!])" + VALUE_PATTERN(), "");
	}
	private static inline function RANDOM_PATTERN()
	{
		return new EReg(VALUE_PATTERN() + "(\\.\\.|__|\\|)" + VALUE_PATTERN(), "");
	}
	private static inline function MULDIV_PATTERN()
	{
		return new EReg(VALUE_PATTERN() + "([*\\/%])" + VALUE_PATTERN(), "");
	}
	private static inline function ADDSUB_PATTERN()
	{
		return new EReg(VALUE_PATTERN() + "([\\+\\-])" + VALUE_PATTERN(), "");
	}
	private static inline function COMPARE_PATTERN()
	{
		return new EReg(VALUE_PATTERN() + "([<>]=?)" + VALUE_PATTERN(), "");
	}
	private static inline function EQUAL_PATTERN()
	{
		return new EReg(VALUE_PATTERN() + "([!=]=)" + VALUE_PATTERN(), "");
	}
	private static inline function LOGIC_PATTERN()
	{
		return new EReg(VALUE_PATTERN() + "(&&|\\|\\|)" + VALUE_PATTERN(), "");
	}
	private static inline function TERNARY_PATTERN()
	{
		return new EReg(VALUE_PATTERN() + "(\\?)" + VALUE_PATTERN() + "(:)" + VALUE_PATTERN(), "");
	}
	
	private function parseToRPN(string:String):Array<Operator> 
	{
		var ppEreg = PARSED_PATTERN();
		if (ppEreg.match(string)) 
		{
			var pi = Std.parseInt(ppEreg.matched(1));
			return parsedOperators[pi];
		}
		
		string = searchFunction(string, FUNCTION_PATTERN(),
		function(opStr:String, operators:Array<Operator>) 
		{
			switch (opStr) 
			{
				case "sin": 
					pushOperator(Sin, operators);
					
				case "cos": 
					pushOperator(Cos, operators);
			}
		});
		
		string = searchOpeator(string, BRACKETS_PATTERN(), 1, null);
		
		string = searchUnaryOpeator(string, UNARY_PATTERN(),
		function(opStr:String, operators:Array<Operator>) 
		{
			switch (opStr) 
			{
				case "-": 
					pushOperator(UnaryMinus, operators);
					
				case "!": 
					pushOperator(UnaryNot, operators);
			}
		});
		
		string = searchOpeator(string, RANDOM_PATTERN(), 2,
		function(opStr:String, operators:Array<Operator>) 
		{
			switch(opStr) 
			{
				case "..": 
					pushOperator(IntRandom, operators);
					
				case "__": 
					pushOperator(NumberRandom, operators);
					
				case "|": 
					pushOperator(OrRandom, operators);
			}
		});
		
		string = searchOpeator(string, MULDIV_PATTERN(), 2,
		function(opStr:String, operators:Array<Operator>) 
		{
			switch(opStr) 
			{
				case "*": 
					pushOperator(Multiple, operators);
					
				case "/": 
					pushOperator(Division, operators);
					
				case "%": 
					pushOperator(Modolo, operators);
			}
		});
		
		string = searchOpeator(string, ADDSUB_PATTERN(), 2,
		function(opStr:String, operators:Array<Operator>) 
		{
			switch(opStr) 
			{
				case "+": 
					pushOperator(Plus, operators);
				
				case "-": 
					pushOperator(Minus, operators);
			}
		});
		
		string = searchOpeator(string, COMPARE_PATTERN(), 2,
		function(opStr:String, operators:Array<Operator>) 
		{
			switch(opStr) 
			{
				case ">": 
					pushOperator(Greater, operators);
				
				case ">=": 
					pushOperator(GreaterEqual, operators);
				
				case "<": 
					pushOperator(Lesser, operators);
				
				case "<=": 
					pushOperator(LesserEqual, operators);
			}
		});
		
		string = searchOpeator(string, EQUAL_PATTERN(), 2,
		function(opStr:String, operators:Array<Operator>) 
		{
			switch(opStr) 
			{
				case "==": 
					pushOperator(Equal, operators);
					
				case "!=": 
					pushOperator(NotEqual, operators);
			}
		});
		
		string = searchOpeator(string, LOGIC_PATTERN(), 2,
		function(opStr:String, operators:Array<Operator>) 
		{
			switch(opStr) 
			{
				case "&&":
					pushOperator(And, operators);
					
				case "||": 
					pushOperator(Or, operators);
			}
		});
		
		string = searchOpeator(string, TERNARY_PATTERN(), 3,
		function(opStr:String, operators:Array<Operator>) 
		{
			switch(opStr) 
			{
				case "?": 
					pushOperator(Ternary, operators);
			}
		});
		
		return parseFloatValue(string);
    }
	
	private function addParsed(operators:Array<Operator>):Int 
	{
		if (parsedOperators == null) 
			parsedOperators = new Array<Array<Operator>>();
		parsedOperators.push(operators);
		
		return parsedOperators.length - 1;
	}
	
	private function searchFunction(string:String, ereg:EReg, pushOperatorFunc:String -> Array<Operator> -> Void):String
	{
		while (ereg.match(string)) 
		{
			var operators = parseToRPN(ereg.matched(2));
			pushOperatorFunc(ereg.matched(1), operators);
			string = ereg.replace(string, PARSED_PREFIX_STRING + addParsed(operators) + PARSED_POSTFIX_STRING);
		}
		return string;
	}
	
	private function searchUnaryOpeator(string:String, ereg:EReg, pushOperatorFunc:String -> Array<Operator> -> Void):String
	{
		while (ereg.match(string))
		{
			var operators = parseToRPN(ereg.matched(3));
			pushOperatorFunc(ereg.matched(2), operators);
			string = ereg.replace(string, "$1" + PARSED_PREFIX_STRING + addParsed(operators) + PARSED_POSTFIX_STRING);
		}
		return string;
	}
	
	private function searchOpeator(string:String, ereg:EReg, n:Int, pushOperatorFunc:String -> Array<Operator> -> Void):String
	{
		while (ereg.match(string))
		{
			var operators = new Array<Operator>();
			for (i in 0...n)
			{
				operators = operators.concat(parseToRPN(ereg.matched(i * 2 + 1)));
			}
			for (i in 0...n - 1)
			{
				pushOperatorFunc(ereg.matched(i * 2 + 2), operators);
			}
			string = ereg.replace(string, PARSED_PREFIX_STRING + addParsed(operators) + PARSED_POSTFIX_STRING);
		}
		return string;
	}
	
	private function parseFloatValue(string:String):Array<Operator>
	{
		var ppEreg = PARSED_PATTERN();
		if (ppEreg.match(string))
		{
			var pi = Std.parseInt(ppEreg.matched(1));
			return parsedOperators[pi];
		}
		var operators = new Array<Operator>();
		var valueEreg = new EReg("^" + VALUE_PATTERN() + "$", "");
		var ppmEreg = PARSED_PATTERN_MATCH();
		if (ppmEreg.match(string) || !valueEreg.match(string))
		{
			while (ppmEreg.match(string))
			{
				string = ppmEreg.replace(string, "");
			}
			throw "invalid VALUE: " + string;
		}
		var v = Std.parseFloat(string);
		if (Math.isNaN(v)) 
			pushVariable(string, operators);
		else 
			pushValue(v, operators);
		
		return operators;
	}
	
	private function pushOperator(op:Operator, operators:Array<Operator>):Void
	{
		switch (op) 
		{
			case UnaryMinus, UnaryNot:
				if (!doInstantUnaryOperation(op, operators)) 
					operators.push(op);
			case Plus, Minus, Multiple, Division, Modolo:
				if (!doInstantBinaryOperation(op, operators)) 
					operators.push(op);
			default:
				operators.push(op);
		}
	}
	
	private function doInstantUnaryOperation(op:Operator, operators:Array<Operator>):Bool
	{
		switch (operators[operators.length - 1])
		{
			case Value(v):
				operators.pop();
				pushValue(calcUnaryOperator(op, v), operators);
				return true;
			default:
				return false;
		}
	}
	
	private function doInstantBinaryOperation(op:Operator, operators:Array<Operator>):Bool
	{
		switch (operators[operators.length - 2])
		{
			case Value(v2):
				switch (operators[operators.length - 1]) 
				{
					case Value(v1):
						operators.pop();
						operators.pop();
						pushValue(calcBinaryOperator(op, v2, v1), operators);
						return true;
					default:
						return false;
				}
			default:
				return false;
		}
	}
	
	private function pushVariable(name:String, operators:Array<Operator>):Void
	{
		if (name.charAt(0) == "$")
			operators.push(ReadOnlyVariable(name));
		else
			operators.push(Variable(name));
	}
	
	private function pushValue(v:Float, operators:Array<Operator>):Void
	{
		operators.push(Value(v));
	}
	
	private function calcUnaryOperator(op:Operator, v:Float):Float
	{
		switch (op)
		{
			case Sin:
				return Math.sin(v * Math.PI / 180);
			case Cos:
				return Math.cos(v * Math.PI / 180);
			case UnaryMinus:
				return -v;
			case UnaryNot:
				return (v == 0 ? 1 : 0);
			default:
				throw "invalid OPERATOR: " + op;
		}
	}
	
	private function calcBinaryOperator(op:Operator, v1:Float, v2:Float):Float
	{
		//HXP.console.log([" +[Ex] calc binary operator", op, v1, v2]);
		
		switch (op)
		{
			case IntRandom:
				var sv = (v1 < 0 ? Std.int(v1) - 1 : Std.int(v1));
				return random.i(Std.int(v2 - v1 + 1), sv);
			
			case NumberRandom: 
				return random.n(v2 - v1, v1);
			
			case OrRandom:
				return (random.i(2) == 0 ? v1 : v2);
			
			case Plus:
				return v1 + v2;
			
			case Minus:
				return v1 - v2;
			
			case Multiple:
				return v1 * v2;
			
			case Division:
				if (v2 == 0) throw "divide by zero";
				return v1 / v2;
			
			case Modolo:
				if (v2 == 0) throw "divide by zero";
				return v1 % v2;
			
			case Greater:
				return (v1 > v2 ? 1 : 0);
			
			case GreaterEqual:
				return (v1 >= v2 ? 1 : 0);
			
			case Lesser:
				return (v1 < v2 ? 1 : 0);
			
			case LesserEqual:
				return (v1 <= v2 ? 1 : 0);
			
			case Equal:
				return (v1 == v2 ? 1 : 0);
			
			case NotEqual: 
				return (v1 != v2 ? 1 : 0);
			
			case And: 
				return (v1 * v2 == 0 ? 0 : 1);
			
			case Or: 
				return (v1 + v2 == 0 ? 0 : 1);
			
			default: 
				//HXP.console.log([" ![Ex] Invalid OPERATOR!", op]);
				//return 0.0;
				throw "invalid OPERATOR: " + op;
		}
	}
	
	private function calcTernaryOperator(op:Operator, v1:Float, v2:Float, v3:Float):Float 
	{
		switch (op) {
			case Ternary: 
				return (v1 == 0 ? v3 : v2);
			default:
				throw "invalid OPERATOR: " + op;
		}
	}
}

enum Operator 
{
	Sin;
	Cos;
	UnaryMinus;
	UnaryNot;
	IntRandom;
	NumberRandom;
	OrRandom;
	Multiple;
	Division;
	Modolo;
	Plus;
	Minus;
	Greater;
	GreaterEqual;
	Lesser;
	LesserEqual;
	Equal;
	NotEqual;
	And;
	Or;
	Ternary;
	Variable(name:String);
	ReadOnlyVariable(name:String);
	Value(v:Float);
}
