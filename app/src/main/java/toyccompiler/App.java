package toyccompiler;

import org.antlr.v4.runtime.*;

import java.io.IOException;
import java.io.InputStream;

import antlr.*;

public class App {
    public static void main(String[] args) {
        try {
            InputStream inputStream = System.in;
            CharStream charStream = CharStreams.fromStream(inputStream);
            Lexer lexer = new ToycLexer(charStream);
            TokenStream tokenStream = new CommonTokenStream(lexer);
            ToycParser parser = new ToycParser(tokenStream);
            ToycParser.StartRuleContext ast = parser.startRule();
            System.out.println(ast.toStringTree(parser));
        } catch (IOException ignored){
        }
    }
}
