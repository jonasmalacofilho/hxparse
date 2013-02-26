package hxparse;

class Unexpected<Token> {
	public var token:Token;
	public var msg:String;
	public function new(token:Token, ?msg:String) {
		this.token = token;
		this.msg = msg;
	}
}

enum ParserState {
	NoMatch;
}

@:autoBuild(hxparse.ParserBuilder.build())
class Parser<Token> {
	var stream:LexerStream<Token>;
	var noMatch:Dynamic;
	
	public function new(stream:LexerStream<Token>) {
		this.stream = stream;
		noMatch = NoMatch;
	}
	
	inline function junk() {
		stream.junk();
	}
	
	inline function peek():Token {
		return stream.peek();
	}
	
	inline function unexpected(t:Token):Dynamic {
		throw new Unexpected(t);
		return null;
	}
	
	inline function serror():Dynamic {
		throw new Unexpected(peek());
		return null;
	}
}