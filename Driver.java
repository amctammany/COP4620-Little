// import ANTLR's runtime libraries
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import java.io.PrintWriter;

class ErrorStrategy extends DefaultErrorStrategy {
	@Override
	public void recover(Parser recognizer, RecognitionException e) {
		throw new RuntimeException(e);
	}
	@Override
	public Token recoverInline(Parser recognizer) throws RecognitionException {
		throw new RuntimeException(new InputMismatchException(recognizer));
	}
	@Override
   public void reportError(Parser recognizer, RecognitionException e) {
		throw new RuntimeException(e);
	}
	@Override
	public void sync(Parser recognizer) {}
}
public class Driver
{

	public static void main(String[] args) throws Exception 
	{
		// Establish character stream from System.in to Lexer
		CharStream input = CharStreams.fromStream(System.in);
		LittleLexer lexer = new LittleLexer(input);
		
		// Capture tokens from lexer
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		tokens.fill();
		
		// Output To StdOut
		PrintWriter printWriter = new PrintWriter(System.out);
		
		try {
		LittleParser parser = new LittleParser(tokens);
		parser.setErrorHandler(new ErrorStrategy());
		ParseTree tree = parser.program();
			System.out.println("Accepted");

//		System.out.println(tree.toStringTree(parser));
		} catch (Exception e) {

			System.out.println("Not accepted");
		}

		
		// Closing writing resources
		printWriter.close();
	}
	

}


