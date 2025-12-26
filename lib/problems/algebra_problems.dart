// ═══════════════════════════════════════════════════════════════════════════════
// ALGEBRA PROBLEMS - Question Generation Instructions
// ═══════════════════════════════════════════════════════════════════════════════
//
// ┌─────────────────────────────────────────────────────────────────────────────┐
// │ PHILOSOPHY: This app is for people RELEARNING and MASTERING material,      │
// │ NOT learning it for the first time. Even "easy" questions should require   │
// │ genuine mathematical thinking—no mindless arithmetic or trivial plug-and-  │
// │ chug problems. Every question should feel like a mini-puzzle worth solving.│
// └─────────────────────────────────────────────────────────────────────────────┘
//
// ═══════════════════════════════════════════════════════════════════════════════
// DIFFICULTY LEVELS (Based on AMC 10/12 Competition Standards)
// ═══════════════════════════════════════════════════════════════════════════════
//
// DIFFICULTY 1 (Easy):
//   - Equivalent to AMC 10/12 problems #1-8
//   - Should still require thought—not just formula application
//   - Test core concept understanding with a slight twist
//   - A student who truly understands the material solves in 1-2 minutes
//
// DIFFICULTY 2 (Medium):
//   - Equivalent to AMC 10/12 problems #9-15
//   - Requires combining multiple concepts or multi-step reasoning
//   - May have elegant solutions that reward mathematical insight
//   - Should take 2-4 minutes for a prepared student
//
// DIFFICULTY 3 (Hard):
//   - Equivalent to AMC 10/12 problems #16-25
//   - Challenging problems that require creative problem-solving
//   - May require non-obvious approaches or clever manipulation
//   - Should take 4-8 minutes even for strong students
//
// ═══════════════════════════════════════════════════════════════════════════════
// CHALLENGE PROBLEMS (Topic ID: 100)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Challenge problems are OPTIONAL and exist separately from regular lessons.
// 
// DIFFICULTY: American Invitational Mathematics Examination (AIME) level
//   - Problems #1-10 of AIME difficulty for most challenges
//   - Include 1-2 problems approaching USA Mathematical Olympiad (USAMO) level
//   - These should genuinely challenge students who have mastered all topics
//   - Expect 10-20+ minutes per problem for strong students
//
// Challenge problems should:
//   - Combine multiple algebraic concepts in unexpected ways
//   - Require creative insight or non-standard approaches
//   - Have elegant solutions that feel satisfying to discover
//   - Test deep understanding, not just procedural knowledge
//
// ═══════════════════════════════════════════════════════════════════════════════
// TOPICS TO COVER (20 Topics + Challenge)
// ═══════════════════════════════════════════════════════════════════════════════
//
// Each topic needs exactly 20 questions distributed as:
//   - 7 questions at difficulty 1 (Easy)
//   - 7 questions at difficulty 2 (Medium)
//   - 6 questions at difficulty 3 (Hard)
//
// Challenge topic (ID: 100) needs 15 questions:
//   - All at AIME/USAMO difficulty level (use difficulty: 3)
//
// TOTAL: 20 topics × 20 questions + 15 challenge = 415 questions
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 1: Function Notation (f(x))
// ───────────────────────────────────────────────────────────────────────────────
//   - Evaluate functions at specific values, including nested functions
//   - Function composition: (f∘g)(x), f(g(x))
//   - Find values where f(x) = g(x)
//   - Domain and range from function definitions
//   - Piecewise function evaluation
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 2: Linear Systems
// ───────────────────────────────────────────────────────────────────────────────
//   - Systems of 2 equations in 2 variables (substitution, elimination)
//   - Word problems leading to systems
//   - Systems with infinitely many or no solutions
//   - Finding when systems have special solution sets
//   - Systems with parameters
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 3: Absolute Value (|x|)
// ───────────────────────────────────────────────────────────────────────────────
//   - Solve |ax + b| = c and |ax + b| = |cx + d|
//   - Absolute value inequalities
//   - Graphing absolute value functions
//   - Distance interpretation problems
//   - Nested absolute values
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 4: Polynomials
// ───────────────────────────────────────────────────────────────────────────────
//   - Factor polynomials (including sum/difference of cubes)
//   - Polynomial division and synthetic division
//   - Remainder and factor theorems
//   - Vieta's formulas for roots
//   - Constructing polynomials from given roots
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 5: Rational Expressions
// ───────────────────────────────────────────────────────────────────────────────
//   - Simplify complex rational expressions
//   - Add/subtract/multiply/divide rational expressions
//   - Partial fraction decomposition (introductory)
//   - Domain restrictions
//   - Simplifying compound fractions
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 6: Rational Equations
// ───────────────────────────────────────────────────────────────────────────────
//   - Solve equations with rational expressions
//   - Identify and check for extraneous solutions
//   - Work/rate problems
//   - Mixture problems
//   - Equations with multiple rational terms
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 7: Literal Equations
// ───────────────────────────────────────────────────────────────────────────────
//   - Solve formulas for a specified variable
//   - Rearrange complex formulas
//   - Physics/science formula manipulation
//   - Equations with the variable appearing multiple times
//   - Formulas involving radicals or exponents
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 8: Exponents & Radicals (xⁿ √x)
// ───────────────────────────────────────────────────────────────────────────────
//   - Laws of exponents with rational exponents
//   - Convert between radical and exponential form
//   - Simplify expressions with negative and fractional exponents
//   - Compare expressions with different bases/exponents
//   - Solve exponential equations (without logs)
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 9: Simplify Radicals
// ───────────────────────────────────────────────────────────────────────────────
//   - Simplify radical expressions (square roots, cube roots, nth roots)
//   - Rationalize denominators (including conjugates)
//   - Add/subtract/multiply radical expressions
//   - Nested radicals
//   - Simplify expressions like √(a + √b)
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 10: Radical Equations
// ───────────────────────────────────────────────────────────────────────────────
//   - Solve equations with one or more radicals
//   - Check for extraneous solutions
//   - Equations requiring squaring twice
//   - Radical equations with rational exponents
//   - Application problems involving radicals
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 11: Quadratic Equations (x²=0)
// ───────────────────────────────────────────────────────────────────────────────
//   - Solve by factoring, completing the square, quadratic formula
//   - Discriminant analysis
//   - Sum and product of roots (Vieta's)
//   - Quadratics with parameters
//   - Word problems leading to quadratics
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 12: Quadratic Graphs (Parabola)
// ───────────────────────────────────────────────────────────────────────────────
//   - Vertex form, standard form, factored form conversions
//   - Find vertex, axis of symmetry, intercepts
//   - Transformations of parabolas
//   - Quadratic inequalities (graphical approach)
//   - Maximum/minimum value problems
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 13: Complex Numbers (i)
// ───────────────────────────────────────────────────────────────────────────────
//   - Operations with complex numbers (add, subtract, multiply, divide)
//   - Powers of i
//   - Complex conjugates
//   - Solving equations with complex solutions
//   - Absolute value (modulus) of complex numbers
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 14: Polynomial Functions
// ───────────────────────────────────────────────────────────────────────────────
//   - End behavior of polynomials
//   - Finding zeros (rational root theorem, etc.)
//   - Multiplicity of zeros and graph behavior
//   - Constructing polynomials from conditions
//   - Polynomial inequalities
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 15: Rational Functions (Graphs)
// ───────────────────────────────────────────────────────────────────────────────
//   - Vertical and horizontal asymptotes
//   - Holes in graphs
//   - Slant/oblique asymptotes
//   - Graphing rational functions
//   - Solving rational inequalities
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 16: Exponential Functions (eˣ)
// ───────────────────────────────────────────────────────────────────────────────
//   - Graph exponential functions and transformations
//   - Exponential growth and decay models
//   - Compound interest problems
//   - Comparing exponential expressions
//   - Solving exponential equations (using same base)
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 17: Logarithms (log)
// ───────────────────────────────────────────────────────────────────────────────
//   - Convert between exponential and logarithmic form
//   - Properties of logarithms (product, quotient, power rules)
//   - Solve logarithmic equations
//   - Change of base formula
//   - Natural logarithm and e
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 18: Sequences & Series (Σ aₙ)
// ───────────────────────────────────────────────────────────────────────────────
//   - Arithmetic sequences: find nth term, sum of n terms
//   - Geometric sequences: find nth term, sum of n terms
//   - Infinite geometric series
//   - Recursive sequences
//   - Sigma notation
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 19: Conic Sections
// ───────────────────────────────────────────────────────────────────────────────
//   - Circles: standard form, find center/radius
//   - Ellipses: standard form, foci, vertices
//   - Parabolas: vertex, focus, directrix
//   - Hyperbolas: standard form, asymptotes
//   - Identify conic from general equation
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 20: Matrices
// ───────────────────────────────────────────────────────────────────────────────
//   - Matrix operations (add, subtract, multiply)
//   - Determinants (2×2 and 3×3)
//   - Matrix inverses
//   - Solve systems using matrices
//   - Matrix transformations
//
// ───────────────────────────────────────────────────────────────────────────────
// TOPIC 100: Challenge Problems (AIME/USAMO Level)
// ───────────────────────────────────────────────────────────────────────────────
//   - 15 problems at AIME difficulty (#1-10 style)
//   - Include 1-2 problems at early USAMO difficulty
//   - Should combine multiple topics creatively
//   - Require mathematical insight and clever techniques
//   - Examples: Vieta jumping, clever substitutions, symmetric function
//     manipulation, elegant algebraic identities
//
// ═══════════════════════════════════════════════════════════════════════════════
// QUESTION FORMAT
// ═══════════════════════════════════════════════════════════════════════════════
//
// {
//   'name': 'T{topic}P{problem}',  // e.g., 'T1P1' for Topic 1, Problem 1
//   'category': 'Algebra',
//   'topic': {topic_id},           // 1-20 for regular, 100 for challenge
//   'difficulty': {1|2|3},         // 1=Easy, 2=Medium, 3=Hard
//   'content': '{question text}',  // Use LaTeX: \\( inline \\) or \\[ block \\]
//   'answers': '{a};{b};{c};{d}',  // Four answer choices separated by semicolons
//   'correct': '{correct_answer}', // Must exactly match one of the answers
// }
//
// ═══════════════════════════════════════════════════════════════════════════════

const List<Map<String, dynamic>> algProblems = [
  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 1: Function Notation (f(x))
  // ════════════════════════════════════════════════════════════════════════════
  
  // -- Difficulty 1 (Easy) --
  {
    'name': 'T1P1',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 1,
    'content': 'Given \\( f(x) = x^2 - x \\). If \\( f(a) = 6 \\), find the sum of all possible values of \\( a \\).',
    'answers': '1;-1;6;0',
    'correct': '1',
  },
  {
    'name': 'T1P2',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 1,
    'content': 'Let \\( f(x) = 2x + 1 \\) and \\( g(x) = x - 3 \\). What is \\( f(g(4)) - g(f(4)) \\)?',
    'answers': '-3;3;0;9',
    'correct': '-3',
  },
  {
    'name': 'T1P3',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 1,
    'content': 'If \\( f(x) = 3x - 5 \\), for what value of \\( x \\) is \\( f(f(x)) = x \\)?',
    'answers': '2.5;2;3;4',
    'correct': '2.5',
  },
  {
    'name': 'T1P4',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 1,
    'content': 'The graph of \\( f(x) = ax + b \\) passes through \\( (1, 5) \\) and \\( (3, 11) \\). What is \\( f(5) \\)?',
    'answers': '17;15;18;20',
    'correct': '17',
  },
  {
    'name': 'T1P5',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 1,
    'content': 'Let \\( f(x) = x^2 \\). Find the value of \\( \\frac{f(f(2))}{f(2)} \\).',
    'answers': '4;2;8;16',
    'correct': '4',
  },
  {
    'name': 'T1P6',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 1,
    'content': '\\( P(x) \\) is a function such that \\( P(x) + P(2x) = 3x \\) for all \\( x \\). If \\( P(x) = ax \\), find \\( a \\).',
    'answers': '1;2;3;0.5',
    'correct': '1',
  },
  {
    'name': 'T1P7',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 1,
    'content': 'If \\( f(x) = |x - 3| \\), what is the smallest value of \\( f(x) + f(x+1) \\)?',
    'answers': '1;0;2;1.5',
    'correct': '1',
  },

  // -- Difficulty 2 (Medium) --
  {
    'name': 'T1P8',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 2,
    'content': 'Let \\( f(x) = ax^7 + bx^3 + cx - 5 \\). If \\( f(-7) = 7 \\), find \\( f(7) \\).',
    'answers': '-17;17;-12;7',
    'correct': '-17',
  },
  {
    'name': 'T1P9',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 2,
    'content': '\\( f(x) \\) is a linear function such that \\( f(x+2) - f(x) = 6 \\) and \\( f(1) = 2 \\). Find \\( f(5) \\).',
    'answers': '14;12;10;16',
    'correct': '14',
  },
  {
    'name': 'T1P10',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 2,
    'content': 'What is the domain of \\( f(x) = \\frac{\\sqrt{1 - x^2}}{x} \\)?',
    'answers': '[-1, 0) U (0, 1];[-1, 1];(-1, 1);(-inf, -1] U [1, inf)',
    'correct': '[-1, 0) U (0, 1]',
  },
  {
    'name': 'T1P11',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 2,
    'content': 'If \\( f(x) = \\frac{1}{1-x} \\), calculate \\( f(f(f(x))) \\).',
    'answers': 'x;1/x;-x;1-x',
    'correct': 'x',
  },
  {
    'name': 'T1P12',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 2,
    'content': 'If \\( f(x) f(y) = f(x+y) + f(x-y) \\) and \\( f(1) = 3 \\), find \\( f(0) \\).',
    'answers': '2;1;0;3',
    'correct': '2',
  },
  {
    'name': 'T1P13',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 2,
    'content': 'Find the number of intersection points of \\( f(x) = 2^x \\) and \\( g(x) = \\log_2(x) \\).',
    'answers': '0;1;2;3',
    'correct': '0',
  },
  {
    'name': 'T1P14',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 2,
    'content': 'Let \\( f(x) = \\begin{cases} 2x & x < 2 \\\\ x^2 & x \\ge 2 \\end{cases} \\). Solve \\( f(x) = 10 \\).',
    'answers': '\\(\\sqrt{10}\\);5;\\(\\sqrt{10}\\) and 5;No solution',
    'correct': '\\(\\sqrt{10}\\)',
  },

  // -- Difficulty 3 (Hard) --
  {
    'name': 'T1P15',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 3,
    'content': 'If \\( f(x) + 2f(\\frac{1}{x}) = 3x \\), find \\( f(2) \\).',
    'answers': '-1;1;2;0',
    'correct': '-1',
  },
  {
    'name': 'T1P16',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 3,
    'content': 'Find the range of the function \\( f(x) = \\frac{x}{1 + x^2} \\).',
    'answers': '[-0.5, 0.5];(-0.5, 0.5);[-1, 1];All real numbers',
    'correct': '[-0.5, 0.5]',
  },
  {
    'name': 'T1P17',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 3,
    'content': 'Find the sum of all values of \\( x \\) in \\( [0, 5] \\) such that \\( \\lfloor 3x \\rfloor = 2x \\).',
    'answers': '0.5;0;1.5;2',
    'correct': '0.5',
  },
  {
    'name': 'T1P18',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 3,
    'content': 'Let \\( f: \\mathbb{R} \\to \\mathbb{R} \\) satisfy \\( f(x+y) = f(x) + f(y) + 2xy \\) for all \\( x,y \\) and \\( f(1) = 2 \\). Find \\( f(4) \\).',
    'answers': '20;16;18;24',
    'correct': '20',
  },
  {
    'name': 'T1P19',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 3,
    'content': 'Let \\( f(x) = 2x^2 - 1 \\). Find the number of distinct real roots of \\( f(f(x)) = x \\).',
    'answers': '4;2;3;0',
    'correct': '4',
  },
  {
    'name': 'T1P20',
    'category': 'Algebra',
    'topic': 1,
    'difficulty': 3,
    'content': 'If \\( f(x) = \\frac{3^x - 1}{3^x + 1} \\), find \\( f^{-1}(x) \\).',
    'answers': '\\(\\log_3\\frac{1+x}{1-x}\\);\\(\\log_3\\frac{1-x}{1+x}\\);\\(\\frac{3^x+1}{3^x-1}\\);None',
    'correct': '\\(\\log_3\\frac{1+x}{1-x}\\)',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 2: Linear Systems
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy) --
  {
    'name': 'T2P1',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 1,
    'content': 'Solve for \\( x \\) and \\( y \\): \\begin{cases} x + y = 5 \\\\ x - y = 1 \\end{cases}',
    'answers': '(3, 2);(2, 3);(4, 1);(3, 3)',
    'correct': '(3, 2)',
  },
  {
    'name': 'T2P2',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 1,
    'content': 'If \\( 2x + y = 10 \\) and \\( y = x + 1 \\), what is the value of \\( x \\)?',
    'answers': '3;4;2;5',
    'correct': '3',
  },
  {
    'name': 'T2P3',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 1,
    'content': 'In the system \\( \\begin{cases} 3x + 2y = 12 \\\\ x = 2 \\end{cases} \\), what is \\( y \\)?',
    'answers': '3;2;4;0',
    'correct': '3',
  },
  {
    'name': 'T2P4',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 1,
    'content': 'The sum of two numbers is 20 and their difference is 4. What is the larger number?',
    'answers': '12;10;14;16',
    'correct': '12',
  },
  {
    'name': 'T2P5',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 1,
    'content': 'Which of the following is a solution to \\( x + 2y = 8 \\)?',
    'answers': '(2, 3);(1, 4);(0, 5);(4, 1)',
    'correct': '(2, 3)',
  },
  {
    'name': 'T2P6',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 1,
    'content': 'Find the intersection point of the lines \\( y = 2x \\) and \\( y = x + 2 \\).',
    'answers': '(2, 4);(1, 3);(0, 0);(-2, 0)',
    'correct': '(2, 4)',
  },
  {
    'name': 'T2P7',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 1,
    'content': 'Solve for \\( a \\) if the system \\( \\begin{cases} x + y = a \\\\ x - y = 2a \\end{cases} \\) has \\( x = 6 \\).',
    'answers': '4;2;3;6',
    'correct': '4',
  },

  // -- Difficulty 2 (Medium) --
  {
    'name': 'T2P8',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 2,
    'content': 'For what value of \\( k \\) does the system \\begin{cases} kx + 3y = 6 \\\\ 2x + y = 2 \\end{cases} have no solution?',
    'answers': '6;3;2;1.5',
    'correct': '6',
  },
  {
    'name': 'T2P9',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 2,
    'content': 'Find the value of \\( x+y \\) if \\( 3x + 4y = 12 \\) and \\( 5x - y = 8 \\).',
    'answers': '\\(\\approx 2.78\\);3;4;5',
    'correct': '\\(\\approx 2.78\\)',
  },
  {
    'name': 'T2P10',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 2,
    'content': 'A boat travels 24 km downstream in 2 hours and returns upstream in 4 hours. What is the speed of the current?',
    'answers': '3 km/h;9 km/h;4 km/h;6 km/h',
    'correct': '3 km/h',
  },
  {
    'name': 'T2P11',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 2,
    'content': 'If \\( ax + y = 5 \\) and \\( x + by = 2 \\) have the solution \\( (1, 1) \\), find \\( a + b \\).',
    'answers': '5;3;4;6',
    'correct': '5',
  },
  {
    'name': 'T2P12',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 2,
    'content': 'Solve for \\( x \\): \\begin{cases} \\frac{1}{x} + \\frac{1}{y} = 5 \\\\ \\frac{1}{x} - \\frac{1}{y} = 1 \\end{cases}',
    'answers': '1/3;1/2;2;3',
    'correct': '1/3',
  },
  {
    'name': 'T2P13',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 2,
    'content': 'The system \\( 2x + 3y = 7 \\) and \\( 4x + 6y = c \\) has infinitely many solutions. Find \\( c \\).',
    'answers': '14;7;10;0',
    'correct': '14',
  },
  {
    'name': 'T2P14',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 2,
    'content': 'If 3 apples and 2 oranges cost \$1.80, and 1 apple and 4 oranges cost \$2.60, what is the cost of an orange?',
    'answers': '\$0.60;\$0.20;\$0.40;\$0.50',
    'correct': '\$0.60',
  },

  // -- Difficulty 3 (Hard) --
  {
    'name': 'T2P15',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 3,
    'content': 'Solve \\( \\begin{cases} \\frac{2}{x} + \\frac{3}{y} = -2 \\\\ \\frac{4}{x} - \\frac{1}{y} = 17 \\end{cases} \\) for \\( y \\).',
    'answers': '-1/3;1/2;-3;1/3',
    'correct': '-1/3',
  },
  {
    'name': 'T2P16',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 3,
    'content': 'For what values of \\( k \\) does \\( |x| + y = 5 \\) and \\( x + |y| = k \\) have exactly 2 solutions?',
    'answers': '5;0;-5;Indeterminate',
    'correct': '5',
  },
  {
    'name': 'T2P17',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 3,
    'content': 'Find \\( k \\) such that the system \\( kx + y = 1 \\) and \\( x + ky = 1 \\) has NO solution.',
    'answers': '-1;1;0;2',
    'correct': '-1',
  },
  {
    'name': 'T2P18',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 3,
    'content': 'Find the area of the region bounded by \\( |3x - 18| + |2y + 7| \\le 6 \\).',
    'answers': '12;24;36;18',
    'correct': '12',
  },
  {
    'name': 'T2P19',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 3,
    'content': 'Solve for \\( z \\) in the system: \\( x+y+z=6, 2x-y+z=3, x-2y+3z=6 \\).',
    'answers': '3;1;2;0',
    'correct': '3',
  },
  {
    'name': 'T2P20',
    'category': 'Algebra',
    'topic': 2,
    'difficulty': 3,
    'content': 'If \\( x^2 + xy + y^2 = 84 \\) and \\( x - \\sqrt{xy} + y = 6 \\), find \\( xy \\).',
    'answers': '16;9;25;36',
    'correct': '16',
  },
  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 3: Absolute Value (|x|)
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy) --
  {
    'name': 'T3P1',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 1,
    'content': 'Solve for \\( x \\): \\( |x - 7| = 3 \\).',
    'answers': '10, 4;10, -4;4, -4;10',
    'correct': '10, 4',
  },
  {
    'name': 'T3P2',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 1,
    'content': 'What are the solutions to \\( |3x| = 12 \\)?',
    'answers': '4, -4;4;3;12',
    'correct': '4, -4',
  },
  {
    'name': 'T3P3',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 1,
    'content': 'Solve \\( |x + 2| = -5 \\).',
    'answers': 'No solution;-7;3;-7, 3',
    'correct': 'No solution',
  },
  {
    'name': 'T3P4',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 1,
    'content': 'Find all \\( x \\) such that \\( |2x - 1| = 5 \\).',
    'answers': '3, -2;3, 2;-3, 2;3',
    'correct': '3, -2',
  },
  {
    'name': 'T3P5',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 1,
    'content': 'If \\( |x| + 5 = 3 \\), how many solutions are there?',
    'answers': '0;1;2;Infinitely many',
    'correct': '0',
  },
  {
    'name': 'T3P6',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 1,
    'content': 'What is the range of \\( f(x) = |x| \\)?',
    'answers': '[0, inf);(-inf, inf);(0, inf);[-1, 1]',
    'correct': '[0, inf)',
  },
  {
    'name': 'T3P7',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 1,
    'content': 'Solve the inequality \\( |x - 3| < 2 \\).',
    'answers': '1 < x < 5;x < 5;x > 1;x < 1 or x > 5',
    'correct': '1 < x < 5',
  },

  // -- Difficulty 2 (Medium) --
  {
    'name': 'T3P8',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 2,
    'content': 'Solve \\( |x + 3| = 2x \\).',
    'answers': '3;-1;3, -1;No solution',
    'correct': '3',
  },
  {
    'name': 'T3P9',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 2,
    'content': 'Solve \\( |2x - 1| = |x + 5| \\).',
    'answers': '6, -4/3;6, 4/3;-6, -4/3;6',
    'correct': '6, -4/3',
  },
  {
    'name': 'T3P10',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 2,
    'content': 'Find all real solutions to \\( |x^2 - 4| = 5 \\).',
    'answers': '3, -3;3;9, -9;1, -1',
    'correct': '3, -3',
  },
  {
    'name': 'T3P11',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 2,
    'content': 'What is the minimum value of \\( f(x) = |x - 1| + |x - 5| \\)?',
    'answers': '4;0;1;5',
    'correct': '4',
  },
  {
    'name': 'T3P12',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 2,
    'content': 'Solve \\( |\\frac{x}{2} - 3| \\le 1 \\).',
    'answers': '4 <= x <= 8;2 <= x <= 4;x <= 8;x >= 4',
    'correct': '4 <= x <= 8',
  },
  {
    'name': 'T3P13',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 2,
    'content': 'The graph of \\( y = |x| + |x-2| \\) looks like a:',
    'answers': 'Bucket/Basin;V-shape;Line;Parabola',
    'correct': 'Bucket/Basin',
  },
  {
    'name': 'T3P14',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 2,
    'content': 'Find the intersection points of \\( y = |x| \\) and \\( y = 2 \\).',
    'answers': '(2, 2), (-2, 2);(2, 2);(0, 0);(-2, -2)',
    'correct': '(2, 2), (-2, 2)',
  },

  // -- Difficulty 3 (Hard) --
  {
    'name': 'T3P15',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 3,
    'content': 'Find the sum of all solutions to \\( ||x - 2| - 3| = 1 \\).',
    'answers': '8;6;4;0',
    'correct': '8',
  },
  {
    'name': 'T3P16',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 3,
    'content': 'Calculate the area of the region defined by \\( |x| + |y| \\le 4 \\).',
    'answers': '32;16;64;8',
    'correct': '32',
  },
  {
    'name': 'T3P17',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 3,
    'content': 'Find the minimum value of \\( |x-1| + |x-2| + |x-3| \\).',
    'answers': '2;0;1;3',
    'correct': '2',
  },
  {
    'name': 'T3P18',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 3,
    'content': 'How many solutions does \\( |x - a| = a \\) have if \\( a > 0 \\)?',
    'answers': '2;1;0;3',
    'correct': '2',
  },
  {
    'name': 'T3P19',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 3,
    'content': 'Solve \\( |x^2 - 1| = x + 1 \\).',
    'answers': '0, -1, 2;-1, 2;0, 2;1, -1',
    'correct': '0, -1, 2',
  },
  {
    'name': 'T3P20',
    'category': 'Algebra',
    'topic': 3,
    'difficulty': 3,
    'content': 'Find the smallest value of \\( x \\) satisfying \\( |x^2 - 3x| < 2 \\).',
    'answers': '\\(\\frac{3-\\sqrt{17}}{2}\\);1;0;\\(\\frac{3-\\sqrt{13}}{2}\\)',
    'correct': '\\(\\frac{3-\\sqrt{17}}{2}\\)',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 4: Polynomials
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy) --
  {
    'name': 'T4P1',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 1,
    'content': 'Factor \\( x^2 - 5x + 6 \\) completely.',
    'answers': '(x-2)(x-3);(x+2)(x+3);(x-1)(x-6);(x-2)(x+3)',
    'correct': '(x-2)(x-3)',
  },
  {
    'name': 'T4P2',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 1,
    'content': 'Expand \\( (x-1)^2 \\).',
    'answers': 'x^2 - 2x + 1;x^2 + 2x + 1;x^2 - 1;x^2 - x + 1',
    'correct': 'x^2 - 2x + 1',
  },
  {
    'name': 'T4P3',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 1,
    'content': 'Find the real root of \\( x^3 - 8 = 0 \\).',
    'answers': '2;4;2 and -2;No real root',
    'correct': '2',
  },
  {
    'name': 'T4P4',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 1,
    'content': 'If \\( P(x) = 2x^3 - x + 1 \\), what is \\( P(2) \\)?',
    'answers': '15;17;13;16',
    'correct': '15',
  },
  {
    'name': 'T4P5',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 1,
    'content': 'What is the degree of \\( (x^2+1)^3 \\)?',
    'answers': '6;5;3;8',
    'correct': '6',
  },
  {
    'name': 'T4P6',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 1,
    'content': 'Find the remainder when \\( x^2 + 1 \\) is divided by \\( x - 1 \\).',
    'answers': '2;0;1;-1',
    'correct': '2',
  },
  {
    'name': 'T4P7',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 1,
    'content': 'What are the zeros of \\( x(x-1)(x+2) \\)?',
    'answers': '0, 1, -2;1, -2;0, -1, 2;1, 2',
    'correct': '0, 1, -2',
  },

  // -- Difficulty 2 (Medium) --
  {
    'name': 'T4P8',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 2,
    'content': 'Find \\( k \\) if \\( x - 2 \\) is a factor of \\( x^3 - kx + 2 \\).',
    'answers': '5;4;2;3',
    'correct': '5',
  },
  {
    'name': 'T4P9',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 2,
    'content': 'Factor \\( x^3 - 27 \\).',
    'answers': '(x-3)(x^2+3x+9);(x-3)(x^2-3x+9);(x+3)(x^2-3x+9);(x-3)^3',
    'correct': '(x-3)(x^2+3x+9)',
  },
  {
    'name': 'T4P10',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 2,
    'content': 'If the cubic \\( x^3 + ax + b = 0 \\) has roots 1 and 2, what is the third root?',
    'answers': '-3;3;-1;0',
    'correct': '-3',
  },
  {
    'name': 'T4P11',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 2,
    'content': 'Find the remainder when \\( x^{10} + 1 \\) is divided by \\( x + 1 \\).',
    'answers': '2;0;-2;1',
    'correct': '2',
  },
  {
    'name': 'T4P12',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 2,
    'content': 'Which polynomial has roots 1, -1, and 2?',
    'answers': 'x^3 - 2x^2 - x + 2;x^3 + 2x^2 - x - 2;x^3 - x^2 + x - 1;x^3 - 2x^2 + x - 2',
    'correct': 'x^3 - 2x^2 - x + 2',
  },
  {
    'name': 'T4P13',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 2,
    'content': 'How many real roots does \\( x^4 - 16 = 0 \\) have?',
    'answers': '2;4;0;1',
    'correct': '2',
  },
  {
    'name': 'T4P14',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 2,
    'content': 'If \\( P(x) \\) divided by \\( x-1 \\) leaves remainder 3, and by \\( x-2 \\) leaves 4, find the remainder when divided by \\( (x-1)(x-2) \\).',
    'answers': 'x + 2;x - 2;2x + 1;7',
    'correct': 'x + 2',
  },

  // -- Difficulty 3 (Hard) --
  {
    'name': 'T4P15',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 3,
    'content': 'Solve for real \\( x \\): \\( x^3 - 3x^2 + 3x - 1 = 8 \\).',
    'answers': '3;2;1;4',
    'correct': '3',
  },
  {
    'name': 'T4P16',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 3,
    'content': 'Find the remainder when \\( x^{100} \\) is divided by \\( x^2 - 3x + 2 \\).',
    'answers': '(2^{100}-1)x + (2-2^{100});2^{100}x;x + 2;2^{100}-1',
    'correct': '(2^{100}-1)x + (2-2^{100})',
  },
  {
    'name': 'T4P17',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 3,
    'content': 'The roots of \\( x^3 - 7x^2 + 14x - 8 = 0 \\) form a geometric progression. Find the roots.',
    'answers': '1, 2, 4;2, 4, 8;1, 3, 9;1/2, 1, 2',
    'correct': '1, 2, 4',
  },
  {
    'name': 'T4P18',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 3,
    'content': 'Solve the reciprocal equation \\( 2x^4 - x^3 - 6x^2 - x + 2 = 0 \\).',
    'answers': '2, 1/2, -1, -1;2, 1/2, 1, 1;2, -2, 1, -1;None',
    'correct': '2, 1/2, -1, -1',
  },
  {
    'name': 'T4P19',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 3,
    'content': 'Factor \\( x^4 + x^2 + 1 \\) over real numbers.',
    'answers': '(x^2-x+1)(x^2+x+1);(x^2+1)^2-x^2;(x^2+1)(x^2-1);Cannot be factored',
    'correct': '(x^2-x+1)(x^2+x+1)',
  },
  {
    'name': 'T4P20',
    'category': 'Algebra',
    'topic': 4,
    'difficulty': 3,
    'content': 'Find the sum of coefficients of the polynomial \\( P(x) = (x^2 - x + 1)^{2025} \\).',
    'answers': '1;0;2025;3^{2025}',
    'correct': '1',
  },
  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 5: Rational Expressions
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy) --
  {
    'name': 'T5P1',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 1,
    'content': 'Simplify \\( \\frac{x^2 - 1}{x + 1} \\) (assuming \\( x \\ne -1 \\)).',
    'answers': 'x - 1;x + 1;x^2 - 1;1',
    'correct': 'x - 1',
  },
  {
    'name': 'T5P2',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 1,
    'content': 'Simplify \\( \\frac{2}{x} + \\frac{3}{x} \\).',
    'answers': '5/x;5/2x;1/x;6/x^2',
    'correct': '5/x',
  },
  {
    'name': 'T5P3',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 1,
    'content': 'Multiplying \\( \\frac{1}{x} \\cdot \\frac{x^2}{2} \\) gives:',
    'answers': 'x/2;2/x;x;x^2/2',
    'correct': 'x/2',
  },
  {
    'name': 'T5P4',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 1,
    'content': 'Simplify \\( \\frac{x+1}{x^2+2x+1} \\).',
    'answers': '1/(x+1);x+1;1/(x-1);1',
    'correct': '1/(x+1)',
  },
  {
    'name': 'T5P5',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 1,
    'content': 'What is the excluded value for the domain of \\( \\frac{1}{x+5} \\)?',
    'answers': '-5;5;0;1',
    'correct': '-5',
  },
  {
    'name': 'T5P6',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 1,
    'content': 'Simplify \\( \\frac{x+1}{1} \\).',
    'answers': 'x+1;1;x;0',
    'correct': 'x+1',
  },
  {
    'name': 'T5P7',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 1,
    'content': 'Simplify \\( \\frac{1}{1/x} \\).',
    'answers': 'x;1/x;1;x^2',
    'correct': 'x',
  },

  // -- Difficulty 2 (Medium) --
  {
    'name': 'T5P8',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 2,
    'content': 'Simplify \\( \\frac{1}{x-1} - \\frac{1}{x+1} \\).',
    'answers': '\\(\\frac{2}{x^2-1}\\);\\(\\frac{2x}{x^2-1}\\);0;\\(\\frac{-2}{x^2-1}\\)',
    'correct': '\\(\\frac{2}{x^2-1}\\)',
  },
  {
    'name': 'T5P9',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 2,
    'content': 'Simplify \\( \\frac{x^2 - 9}{x^2 + 6x + 9} \\).',
    'answers': '\\(\\frac{x-3}{x+3}\\);\\(\\frac{x+3}{x-3}\\);1;-1',
    'correct': '\\(\\frac{x-3}{x+3}\\)',
  },
  {
    'name': 'T5P10',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 2,
    'content': 'Combine \\( 1 + \\frac{1}{x} \\) into a single fraction.',
    'answers': '\\(\\frac{x+1}{x}\\);\\(\\frac{x}{x+1}\\);\\(\\frac{1}{x}\\);x+1',
    'correct': '\\(\\frac{x+1}{x}\\)',
  },
  {
    'name': 'T5P11',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 2,
    'content': 'Simplify \\( \\frac{ \\frac{1}{x} + \\frac{1}{y} }{ \\frac{1}{x} - \\frac{1}{y} } \\).',
    'answers': '\\(\\frac{y+x}{y-x}\\);\\(\\frac{y-x}{y+x}\\);1;-1',
    'correct': '\\(\\frac{y+x}{y-x}\\)',
  },
  {
    'name': 'T5P12',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 2,
    'content': 'Simplify \\( \\frac{x^3 - 1}{x - 1} \\).',
    'answers': 'x^2 + x + 1;x^2 - x + 1;x^2 + 1;x^2 - 1',
    'correct': 'x^2 + x + 1',
  },
  {
    'name': 'T5P13',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 2,
    'content': 'Simplify \\( \\frac{x}{1+x} + 1 \\).',
    'answers': '\\(\\frac{2x+1}{x+1}\\);\\(\\frac{x+1}{x}\\);2;\\(\\frac{2x}{x+1}\\)',
    'correct': '\\(\\frac{2x+1}{x+1}\\)',
  },
  {
    'name': 'T5P14',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 2,
    'content': 'Simplify \\( \\frac{x+2}{x-1} \\cdot \\frac{x^2-1}{x^2-4} \\).',
    'answers': '\\(\\frac{x+1}{x-2}\\);\\(\\frac{x-1}{x+2}\\);\\(\\frac{x+2}{x-1}\\);1',
    'correct': '\\(\\frac{x+1}{x-2}\\)',
  },

  // -- Difficulty 3 (Hard) --
  {
    'name': 'T5P15',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 3,
    'content': 'Calculate the sum \\( \\frac{1}{1\\cdot2} + \\frac{1}{2\\cdot3} + \\dots + \\frac{1}{9\\cdot10} \\).',
    'answers': '9/10;1;99/100;1/2',
    'correct': '9/10',
  },
  {
    'name': 'T5P16',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 3,
    'content': 'If \\( \\frac{1}{x} + \\frac{1}{y} + \\frac{1}{z} = 0 \\), find \\( \\frac{(x+y+z)^2}{x^2+y^2+z^2} \\).',
    'answers': '1;0;2;3',
    'correct': '1',
  },
  {
    'name': 'T5P17',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 3,
    'content': 'Let \\( f(x) = \\frac{1}{1-x} \\). Find \\( f(f(f(x))) \\).',
    'answers': 'x;1/x;-x;1-x',
    'correct': 'x',
  },
  {
    'name': 'T5P18',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 3,
    'content': 'Find the range of \\( f(x) = \\frac{x^2}{x^2+1} \\).',
    'answers': '[0, 1);[0, 1];(0, 1);(-1, 1)',
    'correct': '[0, 1)',
  },
  {
    'name': 'T5P19',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 3,
    'content': 'Simplify \\( \\frac{x^4 - 1}{x^2 - 1} \\).',
    'answers': 'x^2 + 1;x^2 - 1;x^2;1',
    'correct': 'x^2 + 1',
  },
  {
    'name': 'T5P20',
    'category': 'Algebra',
    'topic': 5,
    'difficulty': 3,
    'content': 'Find the slant asymptote of \\( y = \\frac{x^2+1}{x-1} \\).',
    'answers': 'y = x + 1;y = x - 1;y = x;y = x + 2',
    'correct': 'y = x + 1',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 100: Challenge (AIME/USAMO Level)
  // ════════════════════════════════════════════════════════════════════════════
  {
    'name': 'T100P1',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'If \\( x + y = 1 \\) and \\( x^2 + y^2 = 2 \\), find \\( x^3 + y^3 \\).',
    'answers': '2.5;1.5;3;2',
    'correct': '2.5',
  },
  {
    'name': 'T100P2',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'Evaluate \\( \\tan(\\arctan(1/2) + \\arctan(1/3)) \\).',
    'answers': '1;1/2;2;0',
    'correct': '1',
  },
  {
    'name': 'T100P3',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'Solve \\( \\sqrt{x + \\sqrt{x + \\sqrt{x + \\dots}}} = 3 \\).',
    'answers': '6;3;9;2',
    'correct': '6',
  },
  {
    'name': 'T100P4',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'If \\( x + \\frac{1}{x} = 3 \\), find \\( x^5 + \\frac{1}{x^5} \\).',
    'answers': '123;126;120;119',
    'correct': '123',
  },
  {
    'name': 'T100P5',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'How many integers \\( x \\) satisfy \\( \\lfloor \\log_2 x \\rfloor = 3 \\) and \\( \\lfloor \\log_3 x \\rfloor = 2 \\)?',
    'answers': '7;6;5;8',
    'correct': '7',
  },
  {
    'name': 'T100P6',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'Evaluate the sum \\( \\sum_{n=1}^{\\infty} \\frac{n}{2^n} \\).',
    'answers': '2;1;3;1.5',
    'correct': '2',
  },
  {
    'name': 'T100P7',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'What is the last digit of \\( 3^{2025} \\)?',
    'answers': '3;9;7;1',
    'correct': '3',
  },
  {
    'name': 'T100P8',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'How many ordered triples of positive integers \\( (x,y,z) \\) satisfy \\( \\frac{1}{x} + \\frac{1}{y} + \\frac{1}{z} = 1 \\)?',
    'answers': '10;6;3;12',
    'correct': '10',
  },
  {
    'name': 'T100P9',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'How many pairs of positive integers \\( (x,y) \\) satisfy \\( x^2 - y^2 = 2024 \\)?',
    'answers': '4;2;8;6',
    'correct': '4',
  },
  {
    'name': 'T100P10',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'Let \\( P(x) \\) be a quadratic with \\( P(0)=1, P(1)=2, P(2)=5 \\). Find \\( P(3) \\).',
    'answers': '10;8;9;12',
    'correct': '10',
  },
  {
    'name': 'T100P11',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'Let \\( z \\) be a complex root of \\( z^3 = 1, z \\ne 1 \\). Value of \\( (1-z+z^2)(1+z-z^2) \\).',
    'answers': '4;1;2;0',
    'correct': '4',
  },
  {
    'name': 'T100P12',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'Solve \\( \\log_2(\\log_3(\\log_4 x)) = 0 \\).',
    'answers': '64;12;24;81',
    'correct': '64',
  },
  {
    'name': 'T100P13',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'Find the maximum distance from the origin to a point on \\( x^2 - 6x + y^2 + 8y = 0 \\).',
    'answers': '10;5;15;8',
    'correct': '10',
  },
  {
    'name': 'T100P14',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'If \\( a_1 = 1, a_{n+1} = \\frac{1}{1+a_n} \\), find \\( \\lim_{n \\to \\infty} a_n \\).',
    'answers': '\\(\\frac{-1+\\sqrt{5}}{2}\\);\\(\\frac{1+\\sqrt{5}}{2}\\);1;0',
    'correct': '\\(\\frac{-1+\\sqrt{5}}{2}\\)',
  },
  {
    'name': 'T100P15',
    'category': 'Algebra',
    'topic': 100,
    'difficulty': 3,
    'content': 'How many positive integer factors does 2025 have?',
    'answers': '15;10;12;20',
    'correct': '15',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 6: Rational Equations
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T6P1',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 1,
    'content': 'Solve \\( \\frac{3}{x-2} + \\frac{1}{x+2} = \\frac{12}{x^2-4} \\).',
    'answers': '2;4;No solution;0',
    'correct': 'No solution',
  },
  {
    'name': 'T6P2',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 1,
    'content': 'Solve for \\( y \\): \\( \\frac{y+2}{y-2} - \\frac{y-2}{y+2} = \\frac{16}{y^2-4} \\).',
    'answers': '2;-2;0;4',
    'correct': '2',
  },
  {
    'name': 'T6P3',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 1,
    'content': 'Find the sum of solutions to \\( \\frac{x}{x-3} - \\frac{3}{x} = 2 \\).',
    'answers': '3;9;0;-1',
    'correct': '9',
  },
  {
    'name': 'T6P4',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 1,
    'content': 'Solve \\( \\frac{2}{x^2-x-6} + \\frac{3}{x+2} = \\frac{1}{x-3} \\).',
    'answers': '-0.5;0.5;1;-1',
    'correct': '-0.5',
  },
  {
    'name': 'T6P5',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 1,
    'content': 'If \\( \\frac{1}{A} = \\frac{1}{B} + \\frac{1}{C} \\), solve for \\( A \\).',
    'answers': '\\(\\frac{BC}{B+C}\\);\\(\\frac{B+C}{BC}\\);BC;B+C',
    'correct': '\\(\\frac{BC}{B+C}\\)',
  },
  {
    'name': 'T6P6',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 1,
    'content': 'Solve \\( 1 - \\frac{6}{x} + \\frac{8}{x^2} = 0 \\).',
    'answers': '2, 4;2;4;-2, -4',
    'correct': '2, 4',
  },
  {
    'name': 'T6P7',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 1,
    'content': 'Solve \\( \\frac{x-1}{x} = \\frac{x+1}{x+3} \\).',
    'answers': '3;2;1.5;0',
    'correct': '3',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T6P8',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 2,
    'content': 'Solve \\( \\frac{4x}{x^2-9} - \\frac{2}{x+3} = \\frac{2}{x-3} \\).',
    'answers': 'No solution;All real numbers except \\(\\pm 3\\);0;1',
    'correct': 'No solution',
  },
  {
    'name': 'T6P9',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 2,
    'content': 'Find \\( k \\) such that \\( \\frac{kx}{x-2} - \\frac{3}{x} = 4 \\) has an extraneous solution at \\( x=2 \\).',
    'answers': '3.5;4;2.5;5',
    'correct': '3.5',
  },
  {
    'name': 'T6P10',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 2,
    'content': 'If \\( x + \\frac{1}{x} = 5 \\), find \\( \\frac{x}{x^2+x+1} \\).',
    'answers': '1/6;1/5;1/7;5',
    'correct': '1/6',
  },
  {
    'name': 'T6P11',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 2,
    'content': 'Solve \\( \\frac{1}{x^2+4x+3} + \\frac{1}{x^2+8x+15} = \\frac{1}{3} \\).',
    'answers': '0, -6;-1, -3, -5;1, 2;No real solution',
    'correct': '0, -6',
  },
  {
    'name': 'T6P12',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 2,
    'content': 'For what \\( x \\) is the function \\( f(x) = \\frac{x-2}{x^2-4} \\times \\frac{x+2}{x^2-4x+4} \\) undefined?',
    'answers': '2, -2;2;-2;0',
    'correct': '2, -2',
  },
  {
    'name': 'T6P13',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 2,
    'content': 'If \\( \\frac{x}{y} = \\frac{3}{4} \\) and \\( \\frac{y}{z} = \\frac{5}{6} \\), find \\( \\frac{x+y+z}{z} \\).',
    'answers': '\\(\\frac{49}{24}\\);2;\\(\\frac{30}{15}\\);3',
    'correct': '\\(\\frac{49}{24}\\)',
  },
  {
    'name': 'T6P14',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 2,
    'content': 'Solve \\( \\frac{1}{x+1} + \\frac{1}{x-1} = \\frac{1}{x^2-1} \\).',
    'answers': '0.5;1;-1;0',
    'correct': '0.5',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T6P15',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 3,
    'content': 'Pipe A fills a tank in 4 hours, Pipe B in 6 hours. After Pipe A runs for 1 hour, Pipe B is turned on. How many MORE hours until full?',
    'answers': '1.8;2;2.5;1.5',
    'correct': '1.8',
  },
  {
    'name': 'T6P16',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 3,
    'content': 'A boat goes 24 km upstream and 24 km downstream in 5 hours total. The current is 2 km/h. Find the boat speed in still water.',
    'answers': '10 km/h;8 km/h;12 km/h;11 km/h',
    'correct': '10 km/h',
  },
  {
    'name': 'T6P17',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 3,
    'content': 'Working together, Alice and Bob finish a task in 3 days. Alice is twice as fast as Bob. How long would Bob take alone?',
    'answers': '9 days;4.5 days;6 days;12 days',
    'correct': '9 days',
  },
  {
    'name': 'T6P18',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 3,
    'content': 'A mixture is 20 liters of 10% salt. How much pure salt must be added to increase the concentration to 25%?',
    'answers': '4 L;3 L;5 L;2.5 L',
    'correct': '4 L',
  },
  {
    'name': 'T6P19',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 3,
    'content': 'Two cyclists start 120 km apart and ride toward each other. Cyclist A is 5 km/h faster than B. They meet in 4 hours. Find B\' total speed.',
    'answers': '12.5 km/h;17.5 km/h;15 km/h;10 km/h',
    'correct': '12.5 km/h',
  },
  {
    'name': 'T6P20',
    'category': 'Algebra',
    'topic': 6,
    'difficulty': 3,
    'content': 'It takes pump X 3 hours more than pump Y to empty a pool. Together they take 2 hours. How long for pump X alone?',
    'answers': '6 hours;3 hours;4 hours;5 hours',
    'correct': '6 hours',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 7: Literal Equations
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T7P1',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 1,
    'content': 'Solve \\( A = \\frac{1}{2}h(b_1 + b_2) \\) for \\( b_1 \\).',
    'answers': '\\( \\frac{2A}{h} - b_2 \\);\\( \\frac{2A - b_2}{h} \\);\\( \\frac{A}{2h} - b_2 \\);\\( 2A - h b_2 \\)',
    'correct': '\\( \\frac{2A}{h} - b_2 \\)',
  },
  {
    'name': 'T7P2',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 1,
    'content': 'Solve \\( S = 2\\pi r h + 2\\pi r^2 \\) for \\( h \\).',
    'answers': '\\( \\frac{S}{2\\pi r} - r \\);\\( \\frac{S - 2\\pi r^2}{2r} \\);\\( S - r \\);\\( \\frac{S}{r} - 2\\pi r \\)',
    'correct': '\\( \\frac{S}{2\\pi r} - r \\)',
  },
  {
    'name': 'T7P3',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 1,
    'content': 'If \\( P = \\frac{a b c}{a+b+c} \\), solve for \\( a \\).',
    'answers': '\\(\\frac{P(b+c)}{bc-P}\\);\\(\\frac{P(b+c)}{bc+P}\\);\\(\\frac{b+c}{bc-P}\\);Pb+Pc',
    'correct': '\\(\\frac{P(b+c)}{bc-P}\\)',
  },
  {
    'name': 'T7P4',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 1,
    'content': 'Make \\( t \\) the subject: \\( v = u + at \\).',
    'answers': '\\((v-u)/a\\);\\(v-u-a\\);\\(v/a - u\\);\\((u-v)/a\\)',
    'correct': '\\((v-u)/a\\)',
  },
  {
    'name': 'T7P5',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 1,
    'content': 'Solve \\( \\frac{1}{R} = \\frac{1}{R_1} + \\frac{1}{R_2} \\) for \\( R_1 \\).',
    'answers': '\\(\\frac{R R_2}{R_2 - R}\\);\\(\\frac{R R_2}{R_2 + R}\\);\\(R - R_2\\);\\(R_2 - R\\)',
    'correct': '\\(\\frac{R R_2}{R_2 - R}\\)',
  },
  {
    'name': 'T7P6',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 1,
    'content': 'Solve \\( y = \\frac{x+1}{x-1} \\) for \\( x \\).',
    'answers': '\\(\\frac{y+1}{y-1}\\);\\(\\frac{y-1}{y+1}\\);\\(\\frac{1-y}{1+y}\\);y+1',
    'correct': '\\(\\frac{y+1}{y-1}\\)',
  },
  {
    'name': 'T7P7',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 1,
    'content': 'If \\( F = \\frac{9}{5}C + 32 \\), solve for \\( C \\).',
    'answers': '\\(\\frac{5}{9}(F-32)\\);\\(\\frac{9}{5}(F-32)\\);\\(5F - 160\\);\\(\\frac{5}{9}F - 32\\)',
    'correct': '\\(\\frac{5}{9}(F-32)\\)',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T7P8',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 2,
    'content': 'Solve \\( T = 2\\pi \\sqrt{\\frac{L}{g}} \\) for \\( L \\).',
    'answers': '\\(\\frac{g T^2}{4\\pi^2}\\);\\(\\frac{T^2}{4\\pi^2 g}\\);\\(\\frac{\\sqrt{T}g}{2\\pi}\\);\\(g T^2\\)',
    'correct': '\\(\\frac{g T^2}{4\\pi^2}\\)',
  },
  {
    'name': 'T7P9',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 2,
    'content': 'Solve \\( V = \\pi h^2 (r - \\frac{h}{3}) \\) for \\( r \\).',
    'answers': '\\(\\frac{V}{\\pi h^2} + \\frac{h}{3}\\);\\(\\frac{V}{\\pi h^2} - \\frac{h}{3}\\);\\(\\frac{3V}{\\pi h^2}\\);\\(V - \\pi h^2\\)',
    'correct': '\\(\\frac{V}{\\pi h^2} + \\frac{h}{3}\\)',
  },
  {
    'name': 'T7P10',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 2,
    'content': 'Solve \\( ax + b = c(x - d) \\) for \\( x \\).',
    'answers': '\\(\\frac{cd + b}{c - a}\\);\\(\\frac{b + cd}{a - c}\\);\\(\\frac{cd - b}{c - a}\\);\\(\\frac{b - cd}{c - a}\\)',
    'correct': '\\(\\frac{cd + b}{a - c}\\) should be checked, actually \\(\\frac{-(b+cd)}{a-c} = \\frac{b+cd}{c-a}\\). Correct: \\(\\frac{b+cd}{c-a}\\)',
  },
  {
    'name': 'T7P11',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 2,
    'content': 'If \\( x = \\frac{4y+5}{2y-1} \\), find \\( y \\) in terms of \\( x \\).',
    'answers': '\\(\\frac{x+5}{2x-4}\\);\\(\\frac{x-5}{2x+4}\\);\\(\\frac{x+5}{2x+4}\\);\\(\\frac{2x-4}{x+5}\\)',
    'correct': '\\(\\frac{x+5}{2x-4}\\)',
  },
  {
    'name': 'T7P12',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 2,
    'content': 'Solve \\( E = mc^2 + \\frac{1}{2}mv^2 \\) for \\( m \\).',
    'answers': '\\(\\frac{2E}{2c^2+v^2}\\);\\(\\frac{E}{c^2+v^2}\\);\\(\\frac{2E}{c^2+v^2}\\);\\(E - c^2 - v^2\\)',
    'correct': '\\(\\frac{2E}{2c^2+v^2}\\)',
  },
  {
    'name': 'T7P13',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 2,
    'content': 'Solve \\( \\sqrt{2x - a} = x + 1 \\) for \\( a \\).',
    'answers': '\\(2x - (x+1)^2\\);\\(x+1 - 2x\\);\\((x+1)^2 - 2x\\);\\((x+1)/2\\)',
    'correct': '\\(2x - (x+1)^2\\)',
  },
  {
    'name': 'T7P14',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 2,
    'content': 'Solve \\( y = \\ln(\\frac{1+x}{1-x}) \\) for \\( x \\).',
    'answers': '\\(\\frac{e^y - 1}{e^y + 1}\\);\\(\\frac{e^y + 1}{e^y - 1}\\);\\(e^y - 1\\);\\(\\ln(y)\\)',
    'correct': '\\(\\frac{e^y - 1}{e^y + 1}\\)',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T7P15',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 3,
    'content': 'A rectangular box has volume \\( V \\), width \\( w \\), and length \\( l \\). If width is increased by 20% and length decreased by 10%, how must height \\( h \\) change to keep \\( V \\) constant?',
    'answers': 'Decrease by ~7.4%;Increase by 8%;Decrease by 10%;No change',
    'correct': 'Decrease by ~7.4%',
  },
  {
    'name': 'T7P16',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 3,
    'content': 'In \\( I = \\frac{nE}{R + nr} \\) (current in a circuit), if \\( n \\to \\infty \\), what does \\( I \\) approach?',
    'answers': '\\(E/r\\);\\(E/R\\);0;Infinity',
    'correct': '\\(E/r\\)',
  },
  {
    'name': 'T7P17',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 3,
    'content': 'Given \\( S = \\frac{a(1-r^n)}{1-r} \\). If \\( S, a, n \\) are constant, what equation does \\( r \\) satisfy?',
    'answers': '\\(S(1-r) = a(1-r^n)\\);\\(S = ar^n\\);\\(r = S/a\\);Linear',
    'correct': '\\(S(1-r) = a(1-r^n)\\)',
  },
  {
    'name': 'T7P18',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 3,
    'content': 'Solve \\( \\frac{1}{f} = (n-1)(\\frac{1}{R_1} - \\frac{1}{R_2}) \\) for \\( n \\).',
    'answers': '\\(1 + \\frac{1}{f(\\frac{1}{R_1}-\\frac{1}{R_2})}\\);\\(\\frac{f}{R_1-R_2} + 1\\);\\(f(R_1-R_2)\\);\\(1/f + 1\\)',
    'correct': '\\(1 + \\frac{1}{f(\\frac{1}{R_1}-\\frac{1}{R_2})}\\)',
  },
  {
    'name': 'T7P19',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 3,
    'content': 'If \\( x = ay + b \\) and \\( y = cx + d \\), find the condition for this system to have a unique solution for \\( (x,y) \\).',
    'answers': '\\(ac \\ne 1\\);\\(ac = 1\\);\\(ad \\ne bc\\);\\(a \\ne c\\)',
    'correct': '\\(ac \\ne 1\\)',
  },
  {
    'name': 'T7P20',
    'category': 'Algebra',
    'topic': 7,
    'difficulty': 3,
    'content': 'Solve \\( x^2 + (y-k)^2 = r^2 \\) for \\( y \\). When are there two real solutions?',
    'answers': '\\(y = k \\pm \\sqrt{r^2-x^2}\\), when \\(|x| < r\\);\\(y = k + r\\);Always;Never',
    'correct': '\\(y = k \\pm \\sqrt{r^2-x^2}\\), when \\(|x| < r\\)',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 8: Exponents & Radicals
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T8P1',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 1,
    'content': 'Simplify \\( (x^{2/3} y^{-1/2})^6 \\).',
    'answers': '\\(x^4/y^3\\);\\(x^4 y^3\\);\\(x^8/y^3\\);\\(x^3/y^4\\)',
    'correct': '\\(x^4/y^3\\)',
  },
  {
    'name': 'T8P2',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 1,
    'content': 'Evaluate \\( 81^{-3/4} \\).',
    'answers': '1/27;27;-27;1/81',
    'correct': '1/27',
  },
  {
    'name': 'T8P3',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 1,
    'content': 'Simplify \\( \\sqrt[3]{x^6 y^9 z} \\).',
    'answers': '\\(x^2 y^3 \\sqrt[3]{z}\\);\\(x^3 y^2 z\\);\\(x^2 y^3 z\\);\\(x y z\\)',
    'correct': '\\(x^2 y^3 \\sqrt[3]{z}\\)',
  },
  {
    'name': 'T8P4',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 1,
    'content': 'Calculate \\( (\\frac{1}{8})^{-2/3} + (\\frac{1}{27})^{-2/3} \\).',
    'answers': '13;4;9;25/36',
    'correct': '13',
  },
  {
    'name': 'T8P5',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 1,
    'content': 'Solve \\( x^{1/2} = 5 \\).',
    'answers': '25;10;\\(\\sqrt{5}\\);5',
    'correct': '25',
  },
  {
    'name': 'T8P6',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 1,
    'content': 'Simplify \\( \\sqrt{50} - \\sqrt{18} \\).',
    'answers': '\\(2\\sqrt{2}\\);\\(8\\sqrt{2}\\);\\(\\sqrt{32}\\);\\(2\\)',
    'correct': '\\(2\\sqrt{2}\\)',
  },
  {
    'name': 'T8P7',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 1,
    'content': 'If \\( 2^x = \\frac{1}{64} \\), find \\( x \\).',
    'answers': '-6;6;-5;5',
    'correct': '-6',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T8P8',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 2,
    'content': 'Solve \\( 4^{x} - 2^{x+1} - 8 = 0 \\).',
    'answers': '2;3;1;4',
    'correct': '2',
  },
  {
    'name': 'T8P9',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 2,
    'content': 'Which is larger: \\( 3^{50} \\) or \\( 5^{30} \\)?',
    'answers': '\\(5^{30}\\);\\(3^{50}\\);Equal;Cannot determine',
    'correct': '\\(5^{30}\\)',
  },
  {
    'name': 'T8P10',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 2,
    'content': 'Evaluate \\( \\sqrt{12 + \\sqrt{12 + \\dots}} \\).',
    'answers': '4;3;12;2',
    'correct': '4',
  },
  {
    'name': 'T8P11',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 2,
    'content': 'Simplify \\( \\frac{x^n+1 - x^n}{x^n} \\).',
    'answers': 'x - 1;1;x;x^n',
    'correct': 'x - 1',
  },
  {
    'name': 'T8P12',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 2,
    'content': 'If \\( x = 1 + \\sqrt{2} \\), find \\( x^2 - 2x - 1 \\).',
    'answers': '0;1;2;\\(\\sqrt{2}\\)',
    'correct': '0',
  },
  {
    'name': 'T8P13',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 2,
    'content': 'Simplify \\( \\sqrt[3]{2 + \\sqrt{5}} + \\sqrt[3]{2 - \\sqrt{5}} \\).',
    'answers': '1;2;\\(\\sqrt{5}\\);4',
    'correct': '1',
  },
  {
    'name': 'T8P14',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 2,
    'content': 'Solve \\( (x^2 - x - 1)^{x+2} = 1 \\).',
    'answers': '-1, 2, -2;1, 2;0;2, -2',
    'correct': '-1, 2, -2',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T8P15',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 3,
    'content': 'Bacteria population doubles every 3 hours. If there are 100 initially, find the formula for population \\( P(t) \\) and calculate \\( P(12) \\).',
    'answers': '1600;800;1200;3200',
    'correct': '1600',
  },
  {
    'name': 'T8P16',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 3,
    'content': 'A radioactive substance decays to 1/2 in 1000 years. How long until 1/10 of it remains?',
    'answers': '\\(1000 \\log_2 10\\);3322 years;3000 years;2500 years',
    'correct': '\\(1000 \\log_2 10\\)',
  },
  {
    'name': 'T8P17',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 3,
    'content': 'Compound interest: \$1000 at 5% compounded continuously. How many years to double?',
    'answers': '\\( \\ln 2 / 0.05 \\);\\( \\ln 0.5 / 5 \\);14 years;20 years',
    'correct': '\\( \\ln 2 / 0.05 \\)',
  },
  {
    'name': 'T8P18',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 3,
    'content': 'Solve \\( \\sqrt{x} + \\sqrt{y} = 10 \\) and \\( x + y = 58 \\).',
    'answers': '(49, 9) and (9, 49);(25, 25);(50, 8);(36, 16)',
    'correct': '(49, 9) and (9, 49)',
  },
  {
    'name': 'T8P19',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 3,
    'content': 'If \\( a^b = 216 \\) and \\( b^a = ? \\), where \\( a,b \\) are integers. Find possible \\( b^a \\) if \\( a \\ne b \\).',
    'answers': 'No integer solution;36;243;6561',
    'correct': 'No integer solution',
  },
  {
    'name': 'T8P20',
    'category': 'Algebra',
    'topic': 8,
    'difficulty': 3,
    'content': 'Calculate \\( \\sqrt{6+\\sqrt{6+\\sqrt{6+\\dots}}} \\) divided by \\( \\sqrt{20+\\sqrt{20+\\dots}} \\).',
    'answers': '0.6;1;3/5;2/5',
    'correct': '0.6',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 9: Simplify Radicals
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T9P1',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 1,
    'content': 'Rationalize the denominator: \\( \\frac{1}{\\sqrt{3} + \\sqrt{2}} \\).',
    'answers': '\\(\\sqrt{3} - \\sqrt{2}\\);\\(\\sqrt{3} + \\sqrt{2}\\);1;\\(\\sqrt{6}\\)',
    'correct': '\\(\\sqrt{3} - \\sqrt{2}\\)',
  },
  {
    'name': 'T9P2',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 1,
    'content': 'Simplify \\( \\sqrt{75} + \\sqrt{48} \\).',
    'answers': '\\(9\\sqrt{3}\\);\\(10\\sqrt{3}\\);\\(5\\sqrt{3}\\);\\(12\\sqrt{3}\\)',
    'correct': '\\(9\\sqrt{3}\\)',
  },
  {
    'name': 'T9P3',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 1,
    'content': 'Rationalize \\( \\frac{4}{\\sqrt{5}} \\).',
    'answers': '\\( \\frac{4\\sqrt{5}}{5} \\);\\( 4\\sqrt{5} \\);\\( \\frac{\\sqrt{5}}{4} \\);2',
    'correct': '\\( \\frac{4\\sqrt{5}}{5} \\)',
  },
  {
    'name': 'T9P4',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 1,
    'content': 'Simplify \\( \\frac{\\sqrt{72}}{\\sqrt{2}} \\).',
    'answers': '6;36;4;12',
    'correct': '6',
  },
  {
    'name': 'T9P5',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 1,
    'content': 'Simplify \\( \\sqrt[3]{54} \\).',
    'answers': '\\(3\\sqrt[3]{2}\\);\\(2\\sqrt[3]{3}\\);6;3',
    'correct': '\\(3\\sqrt[3]{2}\\)',
  },
  {
    'name': 'T9P6',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 1,
    'content': 'Multiply \\( (2+\\sqrt{3})(2-\\sqrt{3}) \\).',
    'answers': '1;4;7;0',
    'correct': '1',
  },
  {
    'name': 'T9P7',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 1,
    'content': 'Simplify \\( \\sqrt{x^4 y^3} \\) if \\( x,y > 0 \\).',
    'answers': '\\(x^2 y \\sqrt{y}\\);\\(x y \\sqrt{y}\\);\\(x^2 y^2\\);\\(x y\\)',
    'correct': '\\(x^2 y \\sqrt{y}\\)',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T9P8',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 2,
    'content': 'Simplify \\( \\sqrt{4 + 2\\sqrt{3}} \\).',
    'answers': '\\( \\sqrt{3} + 1 \\);\\( \\sqrt{3} - 1 \\);\\( 2 + \\sqrt{3} \\);2',
    'correct': '\\( \\sqrt{3} + 1 \\)',
  },
  {
    'name': 'T9P9',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 2,
    'content': 'Evaluate \\( \\frac{1}{1+\\sqrt{2}} + \\frac{1}{\\sqrt{2}+\\sqrt{3}} + \\dots + \\frac{1}{\\sqrt{99}+\\sqrt{100}} \\).',
    'answers': '9;10;1;99',
    'correct': '9',
  },
  {
    'name': 'T9P10',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 2,
    'content': 'Simplify \\( \\sqrt[3]{26 + 15\\sqrt{3}} \\).',
    'answers': '\\(2 + \\sqrt{3}\\);\\(2 - \\sqrt{3}\\);3;4',
    'correct': '\\(2 + \\sqrt{3}\\)',
  },
  {
    'name': 'T9P11',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 2,
    'content': 'Rationalize \\( \\frac{1}{1 + \\sqrt{2} + \\sqrt{3}} \\).',
    'answers': '\\( \\frac{2+\\sqrt{2}-\\sqrt{6}}{4} \\);\\( \\frac{1+\\sqrt{2}-\\sqrt{3}}{2} \\);1;0',
    'correct': '\\( \\frac{2+\\sqrt{2}-\\sqrt{6}}{4} \\)',
  },
  {
    'name': 'T9P12',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 2,
    'content': 'Simplify \\( \\sqrt{14 + 6\\sqrt{5}} \\).',
    'answers': '\\(3 + \\sqrt{5}\\);\\(3 - \\sqrt{5}\\);\\(2 + 2\\sqrt{5}\\);5',
    'correct': '\\(3 + \\sqrt{5}\\)',
  },
  {
    'name': 'T9P13',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 2,
    'content': 'Find \\( x \\) if \\( \\sqrt{x\\sqrt{x\\sqrt{x}}} = 128 \\).',
    'answers': '256;64;16;128',
    'correct': '256',
  },
  {
    'name': 'T9P14',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 2,
    'content': 'If \\( x = \\sqrt{3} + 1 \\), what is \\( x^4 \\)?',
    'answers': '\\(28 + 16\\sqrt{3}\\);\\(14 + 8\\sqrt{3}\\);32;16',
    'correct': '\\(28 + 16\\sqrt{3}\\)',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T9P15',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 3,
    'content': 'A square has an area of 50. A rectangle has width \\( \\sqrt{8} \\) and the same area. Find its length simplified.',
    'answers': '\\(12.5\\sqrt{2}\\);\\(25\\sqrt{2}/2\\);\\(5\\sqrt{2}\\);25',
    'correct': '\\(12.5\\sqrt{2}\\)',
  },
  {
    'name': 'T9P16',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 3,
    'content': 'Find the area of a triangle with sides \\( \\sqrt{3}, \\sqrt{4}, \\sqrt{5} \\) (Right triangle check!).',
    'answers': '\\(\\frac{\\sqrt{6}}{2}\\);\\(\\frac{\\sqrt{2}}{2}\\);1;0',
    'correct': '\\(\\frac{\\sqrt{2}}{2}\\)',
  },
  {
    'name': 'T9P17',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 3,
    'content': 'Simplify \\( \\frac{1}{\\sqrt[3]{2} - 1} \\).',
    'answers': '\\( \\sqrt[3]{4} + \\sqrt[3]{2} + 1 \\);\\( \\sqrt[3]{4} - 1 \\);2;1',
    'correct': '\\( \\sqrt[3]{4} + \\sqrt[3]{2} + 1 \\)',
  },
  {
    'name': 'T9P18',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 3,
    'content': 'Find the integer part of \\( \\frac{1}{\\sqrt{2}-1} + \\frac{1}{\\sqrt{3}-\\sqrt{2}} \\dots \\) first 2 terms.',
    'answers': '3.14;3;4;2',
    'correct': '3',
  },
  {
    'name': 'T9P19',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 3,
    'content': 'Solve \\( \\sqrt[3]{x+9} - \\sqrt[3]{x-9} = 3 \\).',
    'answers': 'No Solution;\\(\\pm 8\\);\\(\\pm 5\\);0',
    'correct': 'No Solution',
  },
  {
    'name': 'T9P20',
    'category': 'Algebra',
    'topic': 9,
    'difficulty': 3,
    'content': 'If \\( x = \\frac{\\sqrt{5}-1}{2} \\), find \\( x^2 + x - 1 \\).',
    'answers': '0;1;-1;\\(\\sqrt{5}\\)',
    'correct': '0',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 10: Radical Equations
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T10P1',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 1,
    'content': 'Solve \\( \\sqrt{2x+3} = x \\).',
    'answers': '3, -1;3;-1;No solution',
    'correct': '3',
  },
  {
    'name': 'T10P2',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 1,
    'content': 'Solve \\( \\sqrt{x-5} + \\sqrt{x} = 5 \\).',
    'answers': '9;4;16;25',
    'correct': '9',
  },
  {
    'name': 'T10P3',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 1,
    'content': 'Solve \\( \\sqrt{3x+1} - \\sqrt{x-4} = 3 \\).',
    'answers': '8, 5;8;5;No solution',
    'correct': '8, 5',
  },
  {
    'name': 'T10P4',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 1,
    'content': 'Solve \\( (2x-5)^{1/3} = 3 \\).',
    'answers': '16;11;27;32',
    'correct': '16',
  },
  {
    'name': 'T10P5',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 1,
    'content': 'Check for extraneous: \\( \\sqrt{x+2} = x-4 \\).',
    'answers': '2 and 7 are valid;Only 7 valid;Only 2 valid;None',
    'correct': 'Only 7 valid',
  },
  {
    'name': 'T10P6',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 1,
    'content': 'Solve \\( \\sqrt{x^2+4} = x+2 \\).',
    'answers': '0;2;-2;4',
    'correct': '0',
  },
  {
    'name': 'T10P7',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 1,
    'content': 'Solve \\( \\sqrt[3]{x^2 - 1} = 2 \\).',
    'answers': '3, -3;3;9, -9;5',
    'correct': '3, -3',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T10P8',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 2,
    'content': 'Solve \\( \\sqrt{2x-5} = 1 + \\sqrt{x-3} \\).',
    'answers': '3, 7;7;3;No solution',
    'correct': '3, 7',
  },
  {
    'name': 'T10P9',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 2,
    'content': 'Solve for \\( x \\): \\( x - 4\\sqrt{x} + 3 = 0 \\).',
    'answers': '1, 9;1;9;No solution',
    'correct': '1, 9',
  },
  {
    'name': 'T10P10',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 2,
    'content': 'Solve \\( \\sqrt{x+\\sqrt{x+11}} + \\sqrt{x-\\sqrt{x+11}} = 4 \\).',
    'answers': '5;25;16;4',
    'correct': '5',
  },
  {
    'name': 'T10P11',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 2,
    'content': 'Solve \\( \\sqrt{x+2} - \\sqrt{x-3} = \\sqrt{2x-19} \\).',
    'answers': 'No real solution;7;3;10',
    'correct': 'No real solution',
  },
  {
    'name': 'T10P12',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 2,
    'content': 'Solve \\( \\sqrt[4]{x+15} + \\sqrt[4]{x-1} = 2 \\).',
    'answers': '1;17;1, 17;-15',
    'correct': '1',
  },
  {
    'name': 'T10P13',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 2,
    'content': 'If \\( \\sqrt{x-1} = 3 - \\sqrt{x} \\), solve for \\( x \\).',
    'answers': '2.77 (approx);4;1.78 (approx);13/9',
    'correct': '13/9',
  },
  {
    'name': 'T10P14',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 2,
    'content': 'Solve \\( \\sqrt{2x^2 - 5x + 1} = x - 2 \\).',
    'answers': '3, 1;3;No solution;5',
    'correct': 'No solution',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T10P15',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 3,
    'content': 'A ladder 10 ft long leans against a wall. The bottom slides away at x ft. Height is \\( \\sqrt{100-x^2} \\). If height = x + 2, find x.',
    'answers': '6;8;4;5',
    'correct': '6',
  },
  {
    'name': 'T10P16',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 3,
    'content': 'The period of a pendulum is \\( T = 2\\pi \\sqrt{L/9.8} \\). If we want to double the period, what is the new length \\( L\' \\)?',
    'answers': '4L;2L;L/2;16L',
    'correct': '4L',
  },
  {
    'name': 'T10P17',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 3,
    'content': 'Solve \\( \\sqrt{x} + \\sqrt{y} = 4 \\) and \\( x - y = 8 \\). (Hint: Diff of squares).',
    'answers': '(9, 1);(16, 4);(25, 9);No solution',
    'correct': '(9, 1)',
  },
  {
    'name': 'T10P18',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 3,
    'content': 'Find the minimum of \\( \\sqrt{x^2+ y^2} \\) subject to \\( x+y=10 \\).',
    'answers': '\\(5\\sqrt{2}\\);10;5;50',
    'correct': '\\(5\\sqrt{2}\\)',
  },
  {
    'name': 'T10P19',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 3,
    'content': 'Distance between \\( (x, \\sqrt{x}) \\) and \\( (1, 1) \\) is 1. Find x.',
    'answers': '0, 2;1;2;0, 2, 1',
    'correct': '0, 2',
  },
  {
    'name': 'T10P20',
    'category': 'Algebra',
    'topic': 10,
    'difficulty': 3,
    'content': 'Solve \\( x = \\sqrt{2 + \\sqrt{2 + x}} \\).',
    'answers': '2;1.5;3;1',
    'correct': '2',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 11: Quadratic Equations (x^2=0)
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T11P1',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 1,
    'content': 'Solve \\( 2x^2 - 5x + 3 = 0 \\).',
    'answers': '1, 1.5;1, 3;2, 3;No solution',
    'correct': '1, 1.5',
  },
  {
    'name': 'T11P2',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 1,
    'content': 'Find \\( k \\) such that \\( x^2 + kx + 9 = 0 \\) has only one solution.',
    'answers': '\\(\\pm 6\\);\\(\\pm 3\\);6;9',
    'correct': '\\(\\pm 6\\)',
  },
  {
    'name': 'T11P3',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 1,
    'content': 'Solve \\( (x-3)^2 = 16 \\).',
    'answers': '7, -1;7, 1;4, -4;19, -13',
    'correct': '7, -1',
  },
  {
    'name': 'T11P4',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 1,
    'content': 'Find the sum of the roots of \\( 3x^2 - 12x + 7 = 0 \\).',
    'answers': '4;-4;12;7/3',
    'correct': '4',
  },
  {
    'name': 'T11P5',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 1,
    'content': 'Solve \\( x^2 + 4x - 1 = 0 \\) by completing the square.',
    'answers': '\\(-2 \\pm \\sqrt{5}\\);\\(-4 \\pm \\sqrt{5}\\);\\(2 \\pm \\sqrt{5}\\);\\(-2 \\pm 1\\)',
    'correct': '\\(-2 \\pm \\sqrt{5}\\)',
  },
  {
    'name': 'T11P6',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 1,
    'content': 'One root of \\( x^2 + bx - 10 = 0 \\) is 2. Find \\( b \\).',
    'answers': '3;-3;-8;5',
    'correct': '3',
  },
  {
    'name': 'T11P7',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 1,
    'content': 'For what values of \\( c \\) does \\( x^2 + 4x + c = 0 \\) have no real solutions?',
    'answers': 'c > 4;c < 4;c = 4;c > 0',
    'correct': 'c > 4',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T11P8',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 2,
    'content': 'Solve \\( x^2 - |x| - 6 = 0 \\).',
    'answers': '3, -3;3;2, -2;3, -3, 2, -2',
    'correct': '3, -3',
  },
  {
    'name': 'T11P9',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 2,
    'content': 'If \\( \\alpha, \\beta \\) are roots of \\( x^2 - 3x + 1 = 0 \\), find \\( \\alpha^2 + \\beta^2 \\).',
    'answers': '7;9;11;5',
    'correct': '7',
  },
  {
    'name': 'T11P10',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 2,
    'content': 'Solve \\( (x^2 - 1)^2 - 4(x^2 - 1) + 3 = 0 \\).',
    'answers': '\\(\\pm 2, \\pm \\sqrt{2}\\);1, 3;2, 4;\\(\\pm 1, \\pm 2\\)',
    'correct': '\\(\\pm 2, \\pm \\sqrt{2}\\)',
  },
  {
    'name': 'T11P11',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 2,
    'content': 'Find a quadratic equation with roots \\( 2 + \\sqrt{3} \\) and \\( 2 - \\sqrt{3} \\).',
    'answers': 'x^2 - 4x + 1 = 0;x^2 + 4x + 1 = 0;x^2 - 4x - 1 = 0;x^2 - 1 = 0',
    'correct': 'x^2 - 4x + 1 = 0',
  },
  {
    'name': 'T11P12',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 2,
    'content': 'If roots of \\( ax^2 + bx + c = 0 \\) are \\( \\sin \\theta \\) and \\( \\cos \\theta \\), find the relation between a, b, c.',
    'answers': '\\(b^2 - a^2 = 2ac\\);\\(b^2 = a^2 + c^2\\);\\(b^2 = a^2 + 2ac\\);\\(b^2 + a^2 = 2ac\\)',
    'correct': '\\(b^2 - a^2 = 2ac\\)',
  },
  {
    'name': 'T11P13',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 2,
    'content': 'Solve for x: \\( x^4 - 5x^2 + 4 = 0 \\).',
    'answers': '\\(\\pm 1, \\pm 2\\);1, 4;1, 2;\\(\\pm 1, 4\\)',
    'correct': '\\(\\pm 1, \\pm 2\\)',
  },
  {
    'name': 'T11P14',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 2,
    'content': 'If the sum of squares of roots of \\( x^2 - (a-2)x - (a+1) = 0 \\) is lowest, find \\( a \\).',
    'answers': '1;0;2;-1',
    'correct': '1',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T11P15',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 3,
    'content': 'A 10m wire is cut into two pieces. One piece forms a square, the other a circle. Where to cut for minimal total area?',
    'answers': '\\( \\frac{40}{4+\\pi} \\) m from one end;5m;\\( \\frac{10\\pi}{4+\\pi} \\);Do not cut',
    'correct': '\\( \\frac{40}{4+\\pi} \\) m from one end',
  },
  {
    'name': 'T11P16',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 3,
    'content': 'A rectangular garden has area 600 m². If length is increased by 10 and width decreased by 5, area is unchanged. Find original width.',
    'answers': '20 m;30 m;15 m;25 m',
    'correct': '20 m',
  },
  {
    'name': 'T11P17',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 3,
    'content': 'Two pipes running together fill a tank in 6 minutes. One pipe takes 5 minutes longer than the other to fill the tank alone. Find time for faster pipe.',
    'answers': '10 mins;15 mins;12 mins;8 mins',
    'correct': '10 mins',
  },
  {
    'name': 'T11P18',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 3,
    'content': 'What is the condition for \\( ax^2 + bx + c = 0 \\) to have roots of opposite signs?',
    'answers': 'ac < 0;b = 0;a = c;Discriminant = 0',
    'correct': 'ac < 0',
  },
  {
    'name': 'T11P19',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 3,
    'content': 'Solve \\( \\sqrt{5x^2 - 6x + 8} - \\sqrt{5x^2 - 6x - 7} = 1 \\). (Substitution).',
    'answers': '2, -0.8;3, -1;1, 0;4',
    'correct': '2, -0.8',
  },
  {
    'name': 'T11P20',
    'category': 'Algebra',
    'topic': 11,
    'difficulty': 3,
    'content': 'If \\( r_1, r_2 \\) are roots of \\( x^2 + px + q = 0 \\). Find equation with roots \\( r_1^3, r_2^3 \\).',
    'answers': 'x^2 + (p^3-3pq)x + q^3 = 0;x^2 - p^3 x + q^3 = 0;x^2 + 3pq x + q^3 = 0;x^2 - (p^3-3pq)x + q^3 = 0',
    'correct': 'x^2 + (p^3-3pq)x + q^3 = 0',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 12: Quadratic Graphs (Parabola)
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T12P1',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 1,
    'content': 'Find the vertex of \\( y = 2(x-3)^2 + 4 \\).',
    'answers': '(3, 4);(-3, 4);(3, -4);(0, 4)',
    'correct': '(3, 4)',
  },
  {
    'name': 'T12P2',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 1,
    'content': 'Convert \\( y = x^2 + 6x + 5 \\) to vertex form.',
    'answers': '\\((x+3)^2 - 4\\);\\((x+3)^2 + 5\\);\\((x-3)^2 - 4\\);\\((x+3)^2 + 14\\)',
    'correct': '\\((x+3)^2 - 4\\)',
  },
  {
    'name': 'T12P3',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 1,
    'content': 'Find the axis of symmetry for \\( y = -2x^2 + 8x - 1 \\).',
    'answers': 'x = 2;x = -2;x = 4;x = 8',
    'correct': 'x = 2',
  },
  {
    'name': 'T12P4',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 1,
    'content': 'The range of \\( y = -x^2 + 4 \\) is:',
    'answers': '\\((-\\infty, 4]\\);\\([4, \\infty)\\);All real;\\([-4, 4]\\)',
    'correct': '\\((-\\infty, 4]\\)',
  },
  {
    'name': 'T12P5',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 1,
    'content': 'Find the x-intercepts of \\( y = x^2 - x - 2 \\).',
    'answers': '2, -1;1, -2;2, 1;No x-intercepts',
    'correct': '2, -1',
  },
  {
    'name': 'T12P6',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 1,
    'content': 'Determine the value of \\( a \\) if \\( y = ax^2 \\) passes through \\( (2, 12) \\).',
    'answers': '3;6;4;12',
    'correct': '3',
  },
  {
    'name': 'T12P7',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 1,
    'content': 'Which direction does \\( y = -3(x+1)^2 - 2 \\) open?',
    'answers': 'Down;Up;Right;Left',
    'correct': 'Down',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T12P8',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 2,
    'content': 'A parabola has vertex (1, -2) and passes through (3, 6). Find its equation.',
    'answers': '\\(y = 2(x-1)^2 - 2\\);\\(y = (x-1)^2 - 2\\);\\(y = 2(x+1)^2 - 2\\);\\(y = 4(x-1)^2 - 2\\)',
    'correct': '\\(y = 2(x-1)^2 - 2\\)',
  },
  {
    'name': 'T12P9',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 2,
    'content': 'Find the maximum value of the function \\( f(x) = \\frac{1}{x^2 - 4x + 9} \\).',
    'answers': '0.2;1;5;0.5',
    'correct': '0.2',
  },
  {
    'name': 'T12P10',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 2,
    'content': 'For what \\( k \\) does the parabola \\( y = kx^2 - 2x + (k-1) \\) lie completely above the x-axis?',
    'answers': '\\(k > 2\\);\\(k > 0\\);\\(k < 1\\);\\(1 < k < 2\\)',
    'correct': '\\(k > 2\\)',
  },
  {
    'name': 'T12P11',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 2,
    'content': 'Intersection of \\( y = x^2 \\) and \\( y = x + 2 \\).',
    'answers': '(2, 4) and (-1, 1);(1, 1) and (-2, 4);(2, 4);No intersection',
    'correct': '(2, 4) and (-1, 1)',
  },
  {
    'name': 'T12P12',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 2,
    'content': 'Solve quadratic inequality \\( x^2 - 5x + 6 < 0 \\).',
    'answers': '(2, 3);[2, 3];(-inf, 2) U (3, inf);(-3, -2)',
    'correct': '(2, 3)',
  },
  {
    'name': 'T12P13',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 2,
    'content': 'Find the image of point (1, 2) reflected across the axis of \\( y = (x-3)^2 + 1 \\).',
    'answers': '(5, 2);(3, 2);(1, -2);(5, -2)',
    'correct': '(5, 2)',
  },
  {
    'name': 'T12P14',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 2,
    'content': 'If maximum of \\( -x^2 + bx + c \\) is 10 at \\( x=2 \\). Find \\( (b,c) \\).',
    'answers': '(4, 6);(2, 10);(-4, 6);(4, -6)',
    'correct': '(4, 6)',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T12P15',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 3,
    'content': 'A bridge is a parabolic arch. Width 100m, max height 25m. Find height 20m from center.',
    'answers': '21 m;20 m;16 m;24 m',
    'correct': '21 m',
  },
  {
    'name': 'T12P16',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 3,
    'content': 'A projectile height is \\( h(t) = -16t^2 + 64t + 80 \\). find max height and time to hit ground.',
    'answers': '144ft, 5s;100ft, 4s;120ft, 5s;144ft, 4s',
    'correct': '144ft, 5s',
  },
  {
    'name': 'T12P17',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 3,
    'content': 'Farmer has 120m fence to enclose a rectangular region adjacent to a river (no fence on river side). Max area?',
    'answers': '1800 m²;1200 m²;3600 m²;2400 m²',
    'correct': '1800 m²',
  },
  {
    'name': 'T12P18',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 3,
    'content': 'Find the parabola in form \\(y = ax^2 + bx + c\\) tangent to \\(y = x\\) at \\((1,1)\\) and passes through \\((-1,0)\\).',
    'answers': '\\(y = \\frac{1}{4}x^2 + \\frac{1}{2}x + \\frac{1}{4}\\);\\(y = x^2\\);\\(y = 2x^2-2x\\);None',
    'correct': '\\(y = \\frac{1}{4}x^2 + \\frac{1}{2}x + \\frac{1}{4}\\)',
  },
  {
    'name': 'T12P19',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 3,
    'content': 'Find locus of vertices of parabolas \\( y = x^2 - 2kx + 2k^2 + 1 \\).',
    'answers': 'y = x^2 + 1;y = 2x^2 + 1;y = x^2 - 1;y = k^2 + 1',
    'correct': 'y = x^2 + 1',
  },
  {
    'name': 'T12P20',
    'category': 'Algebra',
    'topic': 12,
    'difficulty': 3,
    'content': 'Rectangle inscribed in triangle with base B, height H. Max area of rectangle?',
    'answers': 'BH/4;BH/2;BH/3;BH/6',
    'correct': 'BH/4',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 13: Complex Numbers (i)
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T13P1',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 1,
    'content': 'Calculate \\( (3+2i)(4-5i) \\).',
    'answers': '22 - 7i;12 - 10i;2 + 7i;22 + 7i',
    'correct': '22 - 7i',
  },
  {
    'name': 'T13P2',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 1,
    'content': 'Evaluate \\( i^{15} \\).',
    'answers': '-i;i;-1;1',
    'correct': '-i',
  },
  {
    'name': 'T13P3',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 1,
    'content': 'Compute \\( \\frac{1}{1+i} \\).',
    'answers': '0.5 - 0.5i;1 - i;0.5 + 0.5i;1 + i',
    'correct': '0.5 - 0.5i',
  },
  {
    'name': 'T13P4',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 1,
    'content': 'Solve \\( x^2 + 16 = 0 \\).',
    'answers': '\\(\\pm 4i\\);\\(\\pm 4\\);\\(\\pm 2i\\);No solution',
    'correct': '\\(\\pm 4i\\)',
  },
  {
    'name': 'T13P5',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 1,
    'content': 'Find \\( |3 - 4i| \\).',
    'answers': '5;7;25;3',
    'correct': '5',
  },
  {
    'name': 'T13P6',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 1,
    'content': 'Simplify \\( \\sqrt{-25} \\times \\sqrt{-4} \\).',
    'answers': '-10;10;10i;-10i',
    'correct': '-10',
  },
  {
    'name': 'T13P7',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 1,
    'content': 'If \\( z = 2+i \\), find \\( z + \\bar{z} \\).',
    'answers': '4;2i;5;0',
    'correct': '4',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T13P8',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 2,
    'content': 'Evaluate \\( (1+i)^{10} \\).',
    'answers': '32i;32;-32i;-32',
    'correct': '32i',
  },
  {
    'name': 'T13P9',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 2,
    'content': 'Solve \\( z^2 + 2z + 5 = 0 \\) for complex \\( z \\).',
    'answers': '\\(-1 \\pm 2i\\);\\(-1 \\pm i\\);\\(1 \\pm 2i\\);\\(-2 \\pm 2i\\)',
    'correct': '\\(-1 \\pm 2i\\)',
  },
  {
    'name': 'T13P10',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 2,
    'content': 'Find the smallest positive integer n such that \\( (1+i)^n \\) is real.',
    'answers': '4;2;8;3',
    'correct': '4',
  },
  {
    'name': 'T13P11',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 2,
    'content': 'Simplify \\( i^1 + i^2 + i^3 + \\dots + i^{102} \\).',
    'answers': 'i - 1;0;i;1 - i',
    'correct': 'i - 1',
  },
  {
    'name': 'T13P12',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 2,
    'content': 'If \\( |z| = 1 \\), what is \\( \\frac{1}{z} \\) equal to?',
    'answers': '\\(\\bar{z}\\);\\(z\\);-\\(\\bar{z}\\);1',
    'correct': '\\(\\bar{z}\\)',
  },
  {
    'name': 'T13P13',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 2,
    'content': 'Find square root of \\( 3 - 4i \\).',
    'answers': '\\(\\pm(2-i)\\);\\(\\pm(2+i)\\);\\(\\pm(1-2i)\\);\\(\\pm(1+2i)\\)',
    'correct': '\\(\\pm(2-i)\\)',
  },
  {
    'name': 'T13P14',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 2,
    'content': 'Solve \\( |z+1| = |z-1| \\) for \\( z \\).',
    'answers': 'Re(z) = 0;Im(z) = 0;|z|=1;z=0',
    'correct': 'Re(z) = 0',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T13P15',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 3,
    'content': 'Find the sum of the 12th roots of unity.',
    'answers': '0;1;12;i',
    'correct': '0',
  },
  {
    'name': 'T13P16',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 3,
    'content': 'If \\( z + \\frac{1}{z} = \\sqrt{3} \\), find \\( z^{100} + \\frac{1}{z^{100}} \\).',
    'answers': '-1;1;2;-2',
    'correct': '-1',
  },
  {
    'name': 'T13P17',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 3,
    'content': 'Convert \\( -1 - i\\sqrt{3} \\) to polar form.',
    'answers': '\\(2 \\ cis(240^\\circ)\\);\\(2 \\ cis(120^\\circ)\\);\\(2 \\ cis(210^\\circ)\\);\\(2 \\ cis(300^\\circ)\\)',
    'correct': '\\(2 \\ cis(240^\\circ)\\)',
  },
  {
    'name': 'T13P18',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 3,
    'content': 'Find the area of the polygon formed by roots of \\( z^6 = 64 \\).',
    'answers': '\\(24\\sqrt{3}\\);\\(12\\sqrt{3}\\);64;12',
    'correct': '\\(24\\sqrt{3}\\)',
  },
  {
    'name': 'T13P19',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 3,
    'content': 'Calculate \\( (1+i\\sqrt{3})^{99} \\).',
    'answers': '\\(-2^{99}\\);\\(2^{99}\\);\\(2^{99}i\\);\\(2^{100}\\)',
    'correct': '\\(-2^{99}\\)',
  },
  {
    'name': 'T13P20',
    'category': 'Algebra',
    'topic': 13,
    'difficulty': 3,
    'content': 'Minimal polynomial for \\( \\sqrt{2} + i \\) over rationals.',
    'answers': 'x^4 - 2x^2 + 9;x^4 + 2x^2 + 9;x^2 - 2x + 9;x^4 - 2',
    'correct': 'x^4 - 2x^2 + 9',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 14: Polynomial Functions
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T14P1',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 1,
    'content': 'Find a polynomial with roots 1 and -2.',
    'answers': 'x^2 + x - 2;x^2 - x - 2;x^2 - x + 2;x^2 + x + 2',
    'correct': 'x^2 + x - 2',
  },
  {
    'name': 'T14P2',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 1,
    'content': 'What is the y-intercept of \\( P(x) = (x-1)(x-2)(x+3) \\)?',
    'answers': '6;-6;5;1',
    'correct': '6',
  },
  {
    'name': 'T14P3',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 1,
    'content': 'Find zeros of \\( f(x) = x^3 - 4x \\).',
    'answers': '0, 2, -2;2, -2;0, 4;0, 2',
    'correct': '0, 2, -2',
  },
  {
    'name': 'T14P4',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 1,
    'content': 'Long behavior of \\( -x^5 + 4x^3 \\) as \\( x \\to \\infty \\).',
    'answers': 'Negative infinity;Positive infinity;Zero;1',
    'correct': 'Negative infinity',
  },
  {
    'name': 'T14P5',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 1,
    'content': 'Is \\( (x-1) \\) a factor of \\( x^{100} - 1 \\)?',
    'answers': 'Yes;No;Only for odd powers;Cannot determine',
    'correct': 'Yes',
  },
  {
    'name': 'T14P6',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 1,
    'content': 'Find the remainder when \\( P(x) = 3x^3 - x + 5 \\) is divided by \\( x + 1 \\).',
    'answers': '3;7;5;1',
    'correct': '3',
  },
  {
    'name': 'T14P7',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 1,
    'content': 'Solve \\( x^3 + 2x^2 - 3x = 0 \\).',
    'answers': '0, 1, -3;0, -1, 3;1, 2, 3;No solution',
    'correct': '0, 1, -3',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T14P8',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 2,
    'content': 'Find cubic polys w/ roots 1, 2, 3 and \\( P(0) = -12 \\).',
    'answers': '2(x-1)(x-2)(x-3);(x-1)(x-2)(x-3);-2(x-1)(x-2)(x-3);6(x-1)(x-2)(x-3)',
    'correct': '2(x-1)(x-2)(x-3)',
  },
  {
    'name': 'T14P9',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 2,
    'content': 'Solve \\( x^4 - 5x^2 + 4 < 0 \\).',
    'answers': '(-2, -1) U (1, 2);(-1, 1);(1, 4);(-2, 2)',
    'correct': '(-2, -1) U (1, 2)',
  },
  {
    'name': 'T14P10',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 2,
    'content': 'Find the sum of squares of roots of \\( x^3 - 4x^2 + x + 6 = 0 \\).',
    'answers': '14;16;18;2',
    'correct': '14',
  },
  {
    'name': 'T14P11',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 2,
    'content': 'Construct polynomial with integer coeffs having root \\( 1+\\sqrt{2} \\).',
    'answers': 'x^2 - 2x - 1;x^2 - 2x + 1;x^2 + 2x - 1;x^2 - 2',
    'correct': 'x^2 - 2x - 1',
  },
  {
    'name': 'T14P12',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 2,
    'content': 'Find all rational roots of \\( 2x^3 - 3x^2 - 8x - 3 = 0 \\).',
    'answers': '-1/2, 3, -1;1/2, -3, 1;3, -1;None',
    'correct': '-1/2, 3, -1',
  },
  {
    'name': 'T14P13',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 2,
    'content': 'If \\( P(x) = x^3 + ax^2 + bx + c \\) has roots forming arithmetic progression, then:',
    'answers': '\\(2a^3 - 9ab + 27c = 0\\);\\(2a^3 + 9ab + 27c = 0\\);\\(a^2=3b\\);\\(c=0\\)',
    'correct': '\\(2a^3 - 9ab + 27c = 0\\)',
  },
  {
    'name': 'T14P14',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 2,
    'content': 'Solve \\( (x-1)(x-2)(x-3)(x-4) = 120 \\).',
    'answers': '-1, 6;1, 2;0, 5;6, -2',
    'correct': '-1, 6',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T14P15',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 3,
    'content': 'A box with open top is made from 12x12 cardboard by cutting squares size x. Max vol?',
    'answers': '128;144;256;64',
    'correct': '128',
  },
  {
    'name': 'T14P16',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 3,
    'content': 'Find sum of coefficients of \\( (x^2 - 4x + 1)^{10} \\).',
    'answers': '1024;1;-2;0',
    'correct': '1024',
  },
  {
    'name': 'T14P17',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 3,
    'content': 'If \\( P(x) \\) deg 3 satisfies \\( P(1)=1, P(2)=2, P(3)=3, P(4)=5 \\). Find \\( P(5) \\).',
    'answers': '9;10;5;7',
    'correct': '9',
  },
  {
    'name': 'T14P18',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 3,
    'content': 'For what \\( a \\) does \\( x^3 - 3x + a = 0 \\) have 3 distinct real roots?',
    'answers': '-2 < a < 2;a > 2;a < -2;a = 0',
    'correct': '-2 < a < 2',
  },
  {
    'name': 'T14P19',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 3,
    'content': 'Find remainder of \\( x^{1000} \\) divided by \\( x^2 - 1 \\).',
    'answers': '1;0;x;x+1',
    'correct': '1',
  },
  {
    'name': 'T14P20',
    'category': 'Algebra',
    'topic': 14,
    'difficulty': 3,
    'content': 'Let roots of cubic be \\( a, b, c \\). Find value of \\( a^3 + b^3 + c^3 - 3abc \\) if \\( a+b+c = 0 \\).',
    'answers': '0;1;-1;3',
    'correct': '0',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 15: Rational Functions (Graphs)
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T15P1',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 1,
    'content': 'Find vertical asymptote of \\( y = \\frac{1}{x-2} \\).',
    'answers': 'x=2;x=-2;y=0;y=2',
    'correct': 'x=2',
  },
  {
    'name': 'T15P2',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 1,
    'content': 'Find horizontal asymptote of \\( y = \\frac{3x+1}{x-2} \\).',
    'answers': 'y=3;y=2;y=1;x=2',
    'correct': 'y=3',
  },
  {
    'name': 'T15P3',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 1,
    'content': 'Where is the hole in \\( y = \\frac{x^2-1}{x-1} \\)?',
    'answers': '(1, 2);(1, 0);(1, 1);(-1, 0)',
    'correct': '(1, 2)',
  },
  {
    'name': 'T15P4',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 1,
    'content': 'Domain of \\( f(x) = \\frac{1}{x^2-9} \\).',
    'answers': 'All real except 3, -3;All real;x > 3;x != 0',
    'correct': 'All real except 3, -3',
  },
  {
    'name': 'T15P5',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 1,
    'content': 'x-intercept of \\( y = \\frac{x-4}{x+2} \\).',
    'answers': '4;-2;0;2',
    'correct': '4',
  },
  {
    'name': 'T15P6',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 1,
    'content': 'Horizontal asymptote of \\( y = \\frac{1}{x^2+1} \\).',
    'answers': 'y=0;y=1;None;x=0',
    'correct': 'y=0',
  },
  {
    'name': 'T15P7',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 1,
    'content': 'Does \\( y = \\frac{x}{x^2+1} \\) cross its horizontal asymptote?',
    'answers': 'Yes at x=0;No;Yes at x=1;Yes at x=-1',
    'correct': 'Yes at x=0',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T15P8',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 2,
    'content': 'Find oblique asymptote of \\( y = \\frac{x^2+2x}{x-1} \\).',
    'answers': 'y=x+3;y=x-3;y=x+2;y=2x',
    'correct': 'y=x+3',
  },
  {
    'name': 'T15P9',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 2,
    'content': 'Solve inequality \\( \\frac{x+1}{x-2} > 0 \\).',
    'answers': '(-inf, -1) U (2, inf);(-1, 2);(2, inf);(-inf, -1)',
    'correct': '(-inf, -1) U (2, inf)',
  },
  {
    'name': 'T15P10',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 2,
    'content': 'Solve \\( \\frac{1}{x} < x \\).',
    'answers': '(-1, 0) U (1, inf);(1, inf);(-inf, -1) U (0, 1);(0, 1)',
    'correct': '(-1, 0) U (1, inf)',
  },
  {
    'name': 'T15P11',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 2,
    'content': 'Find range of \\( y = \\frac{x}{x^2-1} \\).',
    'answers': 'All real numbers;[-1, 1];(-inf, inf);y != 0',
    'correct': 'All real numbers',
  },
  {
    'name': 'T15P12',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 2,
    'content': 'Graph of \\( \\frac{2x^2+1}{x^2+1} \\) lies between:',
    'answers': 'y=1 and y=2;y=0 and y=2;y=1 and y=3;Unbounded',
    'correct': 'y=1 and y=2',
  },
  {
    'name': 'T15P13',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 2,
    'content': 'How many asymptotes does \\( y = \\frac{x}{x^2(x-1)} \\) have?',
    'answers': '3 (2 vert, 1 horiz);2;1;4',
    'correct': '3 (2 vert, 1 horiz)',
  },
  {
    'name': 'T15P14',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 2,
    'content': 'Inverse of \\( f(x) = \\frac{x+1}{x-1} \\).',
    'answers': '\\(f(x)\\) itself;\\(-\\frac{x+1}{x-1}\\);\\(\\frac{1}{x}\\);\\(\\frac{x-1}{x+1}\\)',
    'correct': '\\(f(x)\\) itself',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T15P15',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 3,
    'content': 'Cost C to remove p% pollutants: \\( C(p) = \\frac{100,000p}{100-p} \\). Cost to remove 50% vs 90%?',
    'answers': '100k vs 900k;50k vs 90k;100k vs 1M;Linear increase',
    'correct': '100k vs 900k',
  },
  {
    'name': 'T15P16',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 3,
    'content': 'Find area of triangle formed by axes and tangent to \\( y = 1/x \\) at any point \\( a > 0 \\).',
    'answers': '2;1;4;Depends on a',
    'correct': '2',
  },
  {
    'name': 'T15P17',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 3,
    'content': 'Solve \\( \\frac{1}{x+1} + \\frac{1}{x+2} + \\frac{1}{x+3} = \\frac{3}{x} \\).',
    'answers': 'No Solution;0;1;approx -1.5',
    'correct': 'No Solution',
  },
  {
    'name': 'T15P18',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 3,
    'content': 'Find min value of \\( x + \\frac{1}{x} \\) for \\( x > 0 \\).',
    'answers': '2;1;0;None',
    'correct': '2',
  },
  {
    'name': 'T15P19',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 3,
    'content': 'Number of integer solutions to \\( y = \\frac{3x+5}{x+2} \\).',
    'answers': '4;2;0;Infinite',
    'correct': '2',
  },
  {
    'name': 'T15P20',
    'category': 'Algebra',
    'topic': 15,
    'difficulty': 3,
    'content': 'Intersection of \\( y = \\frac{1}{x} \\) and \\( y = -x \\).',
    'answers': 'No real intersection;2 points;1 point;4 points',
    'correct': 'No real intersection',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 16: Exponential Functions (e^x)
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T16P1',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 1,
    'content': 'Solve \\( 3^{x+1} = 27^{x-1} \\).',
    'answers': '2;3;1;4',
    'correct': '2',
  },
  {
    'name': 'T16P2',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 1,
    'content': 'If \\( e^x = 5 \\), what is \\( e^{2x} \\)?',
    'answers': '25;10;\\(\\sqrt{5}\\);5e',
    'correct': '25',
  },
  {
    'name': 'T16P3',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 1,
    'content': 'Domain of \\( f(x) = 2^x \\).',
    'answers': 'All real numbers;x > 0;x > 1;x >= 0',
    'correct': 'All real numbers',
  },
  {
    'name': 'T16P4',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 1,
    'content': 'Solve for x: \\( 4^x - 3\\cdot 2^x + 2 = 0 \\).',
    'answers': '1, 0;2, 1;1, 2;0',
    'correct': '1, 0',
  },
  {
    'name': 'T16P5',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 1,
    'content': 'Range of \\( y = -e^x \\).',
    'answers': '\\((-\\infty, 0)\\);\\((0, \\infty)\\);All real;\\([-1, 1]\\)',
    'correct': '\\((-\\infty, 0)\\)',
  },
  {
    'name': 'T16P6',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 1,
    'content': 'Simplify \\( (e^x + e^{-x})^2 - (e^x - e^{-x})^2 \\).',
    'answers': '4;2;0;\\(2e^{2x}\\)',
    'correct': '4',
  },
  {
    'name': 'T16P7',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 1,
    'content': 'Solve \\( 2^{x^2-2x} = 8 \\).',
    'answers': '3, -1;3;1;-1',
    'correct': '3, -1',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T16P8',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 2,
    'content': 'Solve for x: \\( 2^x = 3^{x-1} \\).',
    'answers': '\\(\\frac{\\ln 3}{\\ln 3 - \\ln 2}\\);\\(\\frac{\\ln 2}{\\ln 3}\\);\\(\\ln 1.5\\);\\(\\ln 3\\)',
    'correct': '\\(\\frac{\\ln 3}{\\ln 3 - \\ln 2}\\)',
  },
  {
    'name': 'T16P9',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 2,
    'content': 'Solve \\( e^{2x} - 4e^x - 5 = 0 \\).',
    'answers': '\\(\\ln 5\\);\\(\\ln 5, \\ln(-1)\\);5, -1;0',
    'correct': '\\(\\ln 5\\)',
  },
  {
    'name': 'T16P10',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 2,
    'content': 'If \\( f(x) = \\frac{e^x - e^{-x}}{2} \\) (sinh x), find inverse function.',
    'answers': '\\(\\ln(x + \\sqrt{x^2+1})\\);\\(\\ln(x - \\sqrt{x^2+1})\\);\\(e^x\\);\\(\\ln(2x)\\)',
    'correct': '\\(\\ln(x + \\sqrt{x^2+1})\\)',
  },
  {
    'name': 'T16P11',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 2,
    'content': 'Solve inequality \\( 2^x > 5 \\).',
    'answers': '\\(x > \\log_2 5\\);\\(x < \\log_2 5\\);\\(x > 2.3\\);\\(x > 5\\)',
    'correct': '\\(x > \\log_2 5\\)',
  },
  {
    'name': 'T16P12',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 2,
    'content': 'Which grows faster as \\( x \\to \\infty \\): \\( x^{100} \\) or \\( 1.01^x \\)?',
    'answers': '\\(1.01^x\\);\\(x^{100}\\);Same rate;Depends',
    'correct': '\\(1.01^x\\)',
  },
  {
    'name': 'T16P13',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 2,
    'content': 'Compare \\( e^\\pi \\) and \\( \\pi^e \\).',
    'answers': '\\(e^\\pi (>)\\);\\(\\pi^e (>)\\);Equal;Cannot tell',
    'correct': '\\(e^\\pi (>)\\)',
  },
  {
    'name': 'T16P14',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 2,
    'content': 'Solve \\( x^2 2^x - 2^x = 0 \\).',
    'answers': '1, -1;0, 1;2;1',
    'correct': '1, -1',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T16P15',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 3,
    'content': 'Population P grows logistic: \\( P(t) = \\frac{1000}{1 + 9e^{-rt}} \\). Initial pop? Limit?',
    'answers': '100, 1000;1000, 100;1, 1000;0, Infinite',
    'correct': '100, 1000',
  },
  {
    'name': 'T16P16',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 3,
    'content': 'Sum of infinite series \\( \\sum_{n=0}^{\\infty} \\frac{2^n}{n!} \\).',
    'answers': '\\(e^2\\);\\(2^e\\);\\(e\\);Infinite',
    'correct': '\\(e^2\\)',
  },
  {
    'name': 'T16P17',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 3,
    'content': 'How many solutions to \\( e^x = x^2 \\)?',
    'answers': '1;-1;0;2',
    'correct': '1',
  },
  {
    'name': 'T16P18',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 3,
    'content': 'Solve \\( 4^x + 6^x = 9^x \\).',
    'answers': '\\(\\frac{\\ln(\\frac{1+\\sqrt{5}}{2})}{\\ln(1.5)}\\);0;1;\\(\\ln 2\\)',
    'correct': '\\(\\frac{\\ln(\\frac{1+\\sqrt{5}}{2})}{\\ln(1.5)}\\)',
  },
  {
    'name': 'T16P19',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 3,
    'content': 'Find max of \\( f(x) = x e^{-x} \\) for \\( x \\ge 0 \\).',
    'answers': '\\(1/e\\) at \\(x=1\\);1 at \\(x=0\\);0;e at \\(x=1\\)',
    'correct': '\\(1/e\\) at \\(x=1\\)',
  },
  {
    'name': 'T16P20',
    'category': 'Algebra',
    'topic': 16,
    'difficulty': 3,
    'content': 'If \\( f(x) = a^x \\) and \\( f(x+1) - f(x) = a^x(a-1) \\), prove this is true.',
    'answers': 'True;False;Only for a=e;Only for a=2',
    'correct': 'True',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 17: Logarithms (log)
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T17P1',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 1,
    'content': 'Solve \\( \\log_2(x) + \\log_2(x-2) = 3 \\).',
    'answers': '4;4, -2;-2;2',
    'correct': '4',
  },
  {
    'name': 'T17P2',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 1,
    'content': 'Evaluate \\( \\log_{100} 1000 \\).',
    'answers': '1.5;2/3;3;10',
    'correct': '1.5',
  },
  {
    'name': 'T17P3',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 1,
    'content': 'If \\( \\ln x = 2 \\), find x.',
    'answers': '\\(e^2\\);\\(2e\\);100;\\(2^e\\)',
    'correct': '\\(e^2\\)',
  },
  {
    'name': 'T17P4',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 1,
    'content': 'Solve \\( 2\\log_3 x = \\log_3 16 \\).',
    'answers': '4;16;8;-4',
    'correct': '4',
  },
  {
    'name': 'T17P5',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 1,
    'content': 'Evaluate \\( e^{\\ln 5 - \\ln 2} \\).',
    'answers': '2.5;3;10;0.4',
    'correct': '2.5',
  },
  {
    'name': 'T17P6',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 1,
    'content': 'Which is undefined?',
    'answers': '\\(\\log(-5)\\);\\(\\log(0.1)\\);\\(\\ln(1)\\);\\(\\log(\\pi)\\)',
    'correct': '\\(\\log(-5)\\)',
  },
  {
    'name': 'T17P7',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 1,
    'content': 'Simplify \\( \\log_b(b^x) \\).',
    'answers': 'x;b;1;0',
    'correct': 'x',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T17P8',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 2,
    'content': 'Solve \\( \\log_x 64 = 3/2 \\).',
    'answers': '16;8;4;32',
    'correct': '16',
  },
  {
    'name': 'T17P9',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 2,
    'content': 'Evaluate \\( \\log_2 3 \\cdot \\log_3 4 \\cdot \\log_4 5 \\dots \\log_{31} 32 \\).',
    'answers': '5;32;1;4',
    'correct': '5',
  },
  {
    'name': 'T17P10',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 2,
    'content': 'Solve \\( (\\log_2 x)^2 - 4\\log_2 x + 3 = 0 \\).',
    'answers': '2, 8;1, 3;2, 6;4, 8',
    'correct': '2, 8',
  },
  {
    'name': 'T17P11',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 2,
    'content': 'If \\( a^2 + b^2 = 7ab \\), find \\( \\log(\\frac{a+b}{3}) \\).',
    'answers': '\\(\\frac{1}{2}(\\log a + \\log b)\\);\\(\\log a + \\log b\\);\\(2(\\log a + \\log b)\\);0',
    'correct': '\\(\\frac{1}{2}(\\log a + \\log b)\\)',
  },
  {
    'name': 'T17P12',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 2,
    'content': 'Solve \\( x^{\\log x} = 100x \\) (base 10).',
    'answers': '100, 0.1;10, 0.1;100;10',
    'correct': '100, 0.1',
  },
  {
    'name': 'T17P13',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 2,
    'content': 'Domain of \\( \\log(\\log(\\log x)) \\).',
    'answers': 'x > 10;x > 1;x > 0;x > 100',
    'correct': 'x > 10',
  },
  {
    'name': 'T17P14',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 2,
    'content': 'Simplify \\( 2^{\\log_2 3 + \\log_2 5} \\).',
    'answers': '15;8;35;2',
    'correct': '15',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T17P15',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 3,
    'content': 'Richter scale: Magnitude \\( M = \\log(I/I_0) \\). Earthquake A is 100 times stronger than B. Difference in M?',
    'answers': '2;1;10;100',
    'correct': '2',
  },
  {
    'name': 'T17P16',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 3,
    'content': 'Number of digits in \\( 2^{100} \\). (Use \\(\\log 2 \\approx 0.3010\\)).',
    'answers': '31;30;29;32',
    'correct': '31',
  },
  {
    'name': 'T17P17',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 3,
    'content': 'Solve for x: \\( \\log_5(x) + \\log_x(5) = 2.5 \\).',
    'answers': '25, \\(\\sqrt{5}\\);5, 25;25, 0.2;1, 5',
    'correct': '25, \\(\\sqrt{5}\\)',
  },
  {
    'name': 'T17P18',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 3,
    'content': 'If \\( \\log_a b = c \\), \\( \\log_b c = a \\), \\( \\log_c a = b \\). find abc.',
    'answers': '1;0;-1;e',
    'correct': '1',
  },
  {
    'name': 'T17P19',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 3,
    'content': 'Find \\( x \\) if \\( 4^x - 2^{x+1} - 3 = 0 \\).',
    'answers': '\\(\\log_2 3\\);\\(\\log_2 3, \\log_2(-1)\\);3;1.58',
    'correct': '\\(\\log_2 3\\)',
  },
  {
    'name': 'T17P20',
    'category': 'Algebra',
    'topic': 17,
    'difficulty': 3,
    'content': 'Calculate sum \\( \\sum_{k=2}^{10} \\log(\\frac{k+1}{k}) \\).',
    'answers': '\\(\\log(5.5)\\);\\(\\log 11 - \\log 2\\);1;0',
    'correct': '\\(\\log 11 - \\log 2\\)',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 18: Sequences & Series (Σ aₙ)
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T18P1',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 1,
    'content': 'Find the 10th term of 2, 5, 8, ...',
    'answers': '29;32;26;30',
    'correct': '29',
  },
  {
    'name': 'T18P2',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 1,
    'content': 'Sum of first 20 integers.',
    'answers': '210;200;190;211',
    'correct': '210',
  },
  {
    'name': 'T18P3',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 1,
    'content': 'Find 5th term of Geom Seq: 3, 6, 12, ...',
    'answers': '48;24;96;36',
    'correct': '48',
  },
  {
    'name': 'T18P4',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 1,
    'content': 'Sum of infinite series \\( 1 + 1/2 + 1/4 + \\dots \\).',
    'answers': '2;1.5;1;Infinite',
    'correct': '2',
  },
  {
    'name': 'T18P5',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 1,
    'content': 'Evaluate \\( \\sum_{n=1}^{4} n^2 \\).',
    'answers': '30;20;16;55',
    'correct': '30',
  },
  {
    'name': 'T18P6',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 1,
    'content': 'Recursive seq: \\( a_1=1, a_n = 2a_{n-1}+1 \\). Find \\( a_4 \\).',
    'answers': '15;7;31;8',
    'correct': '15',
  },
  {
    'name': 'T18P7',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 1,
    'content': 'Which is arithmetic? 2,4,8... or 2,4,6...?',
    'answers': '2,4,6;2,4,8;Neither;Both',
    'correct': '2,4,6',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T18P8',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 2,
    'content': 'Sum of Arithmetic Seq with \\( a_1=5, a_n=45, d=5 \\)?',
    'answers': '225;250;200;125',
    'correct': '225',
  },
  {
    'name': 'T18P9',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 2,
    'content': 'Convert \\( 0.333\\dots \\) to fraction using geometric series.',
    'answers': '1/3;3/10;3/9;1/3',
    'correct': '1/3',
  },
  {
    'name': 'T18P10',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 2,
    'content': 'Find \\( x \\) if \\( x, x+2, x+6 \\) is a geometric sequence.',
    'answers': '2;1;-2;4',
    'correct': '2',
  },
  {
    'name': 'T18P11',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 2,
    'content': 'Evaluate \\( \\sum_{k=1}^{20} (2k-1) \\).',
    'answers': '400;200;190;380',
    'correct': '400',
  },
  {
    'name': 'T18P12',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 2,
    'content': 'If \\( a_5 = 10 \\) and \\( a_8 = 4 \\) (arithmetic), find \\( d \\).',
    'answers': '-2;-3;-1;2',
    'correct': '-2',
  },
  {
    'name': 'T18P13',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 2,
    'content': 'Sum of first 10 powers of 2 (starting \\( 2^1 \\)).',
    'answers': '2046;1023;512;1024',
    'correct': '2046',
  },
  {
    'name': 'T18P14',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 2,
    'content': 'Find sum of infinite series \\( \\sum_{n=1}^\\infty \\frac{n}{3^n} \\).',
    'answers': '3/4;1/2;1;3/2',
    'correct': '3/4',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T18P15',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 3,
    'content': 'A ball drops 10m, bounces back 3/4 height. Total distance traveled until stop?',
    'answers': '70m;40m;80m;35m',
    'correct': '70m',
  },
  {
    'name': 'T18P16',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 3,
    'content': 'Sum of \\( 1 \\cdot 2 + 2 \\cdot 3 + \\dots + n(n+1) \\).',
    'answers': '\\( \\frac{n(n+1)(n+2)}{3} \\);\\( \\frac{n(n+1)}{2} \\);\\( n(n+1) \\);\\( n^3 \\)',
    'correct': '\\( \\frac{n(n+1)(n+2)}{3} \\)',
  },
  {
    'name': 'T18P17',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 3,
    'content': 'Find fraction \\( 0.121212\\dots \\).',
    'answers': '4/33;2/15;1/8;12/100',
    'correct': '4/33',
  },
  {
    'name': 'T18P18',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 3,
    'content': 'If \\( S_n = n^2 + 2n \\), find \\( a_n \\).',
    'answers': '2n+1;2n;2n+2;n+1',
    'correct': '2n+1',
  },
  {
    'name': 'T18P19',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 3,
    'content': 'Sum of \\( \\frac{1}{1\\cdot3} + \\frac{1}{3\\cdot5} + \\frac{1}{5\\cdot7} \\dots \\) to infinity.',
    'answers': '1/2;1/3;1;1/4',
    'correct': '1/2',
  },
  {
    'name': 'T18P20',
    'category': 'Algebra',
    'topic': 18,
    'difficulty': 3,
    'content': 'Fibonacci: \\( F_1=1, F_2=1 \\). Find limit \\( F_{n+1}/F_n \\).',
    'answers': '\\(\\phi \\approx 1.618\\);1;2;e',
    'correct': '\\(\\phi \\approx 1.618\\)',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 19: Conic Sections
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T19P1',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 1,
    'content': 'Identify \\( x^2 + y^2 = 9 \\).',
    'answers': 'Circle;Ellipse;Parabola;Hyperbola',
    'correct': 'Circle',
  },
  {
    'name': 'T19P2',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 1,
    'content': 'Center of \\( (x-2)^2 + (y+1)^2 = 16 \\).',
    'answers': '(2, -1);(-2, 1);(2, 1);(-2, -1)',
    'correct': '(2, -1)',
  },
  {
    'name': 'T19P3',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 1,
    'content': 'Identify \\( \\frac{x^2}{4} + \\frac{y^2}{9} = 1 \\).',
    'answers': 'Ellipse;Circle;Hyperbola;Line',
    'correct': 'Ellipse',
  },
  {
    'name': 'T19P4',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 1,
    'content': 'Vertices of \\( x^2/25 - y^2/9 = 1 \\).',
    'answers': '\\((\\pm 5, 0)\\);\\((0, \\pm 3)\\);\\((\\pm 4, 0)\\);\\((0, \\pm 5)\\)',
    'correct': '\\((\\pm 5, 0)\\)',
  },
  {
    'name': 'T19P5',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 1,
    'content': 'Focus of parabola \\( y^2 = 8x \\).',
    'answers': '(2, 0);(0, 2);(4, 0);(8, 0)',
    'correct': '(2, 0)',
  },
  {
    'name': 'T19P6',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 1,
    'content': 'Radius of \\( x^2 + y^2 - 6x + 8y = 0 \\).',
    'answers': '5;10;25;100',
    'correct': '5',
  },
  {
    'name': 'T19P7',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 1,
    'content': 'Identify \\( xy = 1 \\).',
    'answers': 'Hyperbola;Circle;Ellipse;Parabola',
    'correct': 'Hyperbola',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T19P8',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 2,
    'content': 'Eccentricity of \\( \\frac{x^2}{25} + \\frac{y^2}{16} = 1 \\).',
    'answers': '3/5;4/5;5/3;1',
    'correct': '3/5',
  },
  {
    'name': 'T19P9',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 2,
    'content': 'Find asymptotes of \\( x^2 - y^2 = 1 \\).',
    'answers': 'y = ±x;y = ±x/2;y = ±2x;y = x',
    'correct': 'y = ±x',
  },
  {
    'name': 'T19P10',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 2,
    'content': 'Length of latus rectum of \\( y^2 = 4ax \\).',
    'answers': '4a;2a;a;a/4',
    'correct': '4a',
  },
  {
    'name': 'T19P11',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 2,
    'content': 'Area of ellipse \\( \\frac{x^2}{a^2} + \\frac{y^2}{b^2} = 1 \\).',
    'answers': '\\(\\pi ab\\);\\(\\pi (a+b)\\);\\(\\pi a^2\\);\\(ab\\)',
    'correct': '\\(\\pi ab\\)',
  },
  {
    'name': 'T19P12',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 2,
    'content': 'Find intersection of \\( x^2+y^2=4 \\) and \\( x^2-y^2=4 \\).',
    'answers': '\\((\\pm 2, 0)\\);\\((0, \\pm 2)\\);\\((\\pm 1, 1)\\);No intersection',
    'correct': '\\((\\pm 2, 0)\\)',
  },
  {
    'name': 'T19P13',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 2,
    'content': 'Classify \\( 4x^2 - 9y^2 - 16x - 18y - 29 = 0 \\).',
    'answers': 'Hyperbola;Ellipse;Parabola;Circle',
    'correct': 'Hyperbola',
  },
  {
    'name': 'T19P14',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 2,
    'content': 'Directrix of \\( x^2 = -12y \\).',
    'answers': 'y = 3;y = -3;x = 3;y = 12',
    'correct': 'y = 3',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T19P15',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 3,
    'content': 'A Whispering Gallery is semi-elliptical. Foci are 20m apart, width 50m. Height at center?',
    'answers': '22.9m;20m;25m;24m',
    'correct': '22.9m',
  },
  {
    'name': 'T19P16',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 3,
    'content': 'Find max area of rectangle inscribed in ellipse \\( \\frac{x^2}{a^2} + \\frac{y^2}{b^2} = 1 \\).',
    'answers': '2ab;ab;4ab;\\(\\pi ab\\)',
    'correct': '2ab',
  },
  {
    'name': 'T19P17',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 3,
    'content': 'Locus of centers of circles tangent to x-axis and passing through (0, 1).',
    'answers': 'Parabola;Hyperbola;Ellipse;Line',
    'correct': 'Parabola',
  },
  {
    'name': 'T19P18',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 3,
    'content': 'Slope of tangent to \\( y^2 = 4x \\) at (1, 2).',
    'answers': '1;2;0.5;-1',
    'correct': '1',
  },
  {
    'name': 'T19P19',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 3,
    'content': 'Distance from focus to directrix of parabola \\( y = ax^2 \\).',
    'answers': '\\(1/2a\\);\\(1/4a\\);\\(a\\);\\(4a\\)',
    'correct': '\\(1/2a\\)',
  },
  {
    'name': 'T19P20',
    'category': 'Algebra',
    'topic': 19,
    'difficulty': 3,
    'content': 'Number of tangents from (0,0) to \\( (x-3)^2 + y^2 = 4 \\).',
    'answers': '2;1;0;Infinite',
    'correct': '2',
  },

  // ════════════════════════════════════════════════════════════════════════════
  // TOPIC 20: Matrices
  // ════════════════════════════════════════════════════════════════════════════

  // -- Difficulty 1 (Easy -> Old Medium) --
  {
    'name': 'T20P1',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 1,
    'content': 'Determinant of \\( \\begin{pmatrix} 2 & 3 \\\\ 1 & 4 \\end{pmatrix} \\).',
    'answers': '5;11;-5;8',
    'correct': '5',
  },
  {
    'name': 'T20P2',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 1,
    'content': 'Trace of \\( \\begin{pmatrix} 5 & -2 \\\\ 3 & 1 \\end{pmatrix} \\).',
    'answers': '6;4;11;-2',
    'correct': '6',
  },
  {
    'name': 'T20P3',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 1,
    'content': 'Multiply \\( \\begin{pmatrix} 1 & 2 \\end{pmatrix} \\begin{pmatrix} 3 \\\\ 4 \\end{pmatrix} \\).',
    'answers': '11;\\(\\begin{pmatrix} 3 & 8 \\end{pmatrix}\\);7;12',
    'correct': '11',
  },
  {
    'name': 'T20P4',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 1,
    'content': 'Inverse of \\( \\begin{pmatrix} 1 & 0 \\\\ 0 & 2 \\end{pmatrix} \\).',
    'answers': '\\(\\begin{pmatrix} 1 & 0 \\\\ 0 & 0.5 \\end{pmatrix}\\);\\(\\begin{pmatrix} 1 & 0 \\\\ 0 & -2 \\end{pmatrix}\\);Same;Identity',
    'correct': '\\(\\begin{pmatrix} 1 & 0 \\\\ 0 & 0.5 \\end{pmatrix}\\)',
  },
  {
    'name': 'T20P5',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 1,
    'content': 'If \\( A + I = O \\), what is A?',
    'answers': '-I;I;O;Undefined',
    'correct': '-I',
  },
  {
    'name': 'T20P6',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 1,
    'content': 'Transpose of \\( \\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix} \\).',
    'answers': '\\(\\begin{pmatrix} 1 & 3 \\\\ 2 & 4 \\end{pmatrix}\\);\\(\\begin{pmatrix} 4 & 3 \\\\ 2 & 1 \\end{pmatrix}\\);\\(\\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix}\\);Identity',
    'correct': '\\(\\begin{pmatrix} 1 & 3 \\\\ 2 & 4 \\end{pmatrix}\\)',
  },
  {
    'name': 'T20P7',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 1,
    'content': 'Does AB = BA always?',
    'answers': 'No;Yes;Only for square matrices;Only for zero matrix',
    'correct': 'No',
  },

  // -- Difficulty 2 (Medium -> Old Hard) --
  {
    'name': 'T20P8',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 2,
    'content': 'Determinant of 3x3 diagonal matrix diag(1, 2, 3).',
    'answers': '6;5;0;3',
    'correct': '6',
  },
  {
    'name': 'T20P9',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 2,
    'content': 'For what \\( k \\) is \\( \\begin{pmatrix} 1 & 2 \\\\ 3 & k \\end{pmatrix} \\) singular?',
    'answers': '6;0;2;5',
    'correct': '6',
  },
  {
    'name': 'T20P10',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 2,
    'content': 'Eigenvalues of \\( \\begin{pmatrix} 2 & 0 \\\\ 1 & 3 \\end{pmatrix} \\).',
    'answers': '2, 3;1, 0;2, 1;6',
    'correct': '2, 3',
  },
  {
    'name': 'T20P11',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 2,
    'content': 'Inverse of \\( \\begin{pmatrix} 1 & 1 \\\\ 1 & 2 \\end{pmatrix} \\).',
    'answers': '\\(\\begin{pmatrix} 2 & -1 \\\\ -1 & 1 \\end{pmatrix}\\);\\(\\begin{pmatrix} 2 & 1 \\\\ 1 & 1 \\end{pmatrix}\\);\\(\\begin{pmatrix} -1 & 1 \\\\ 1 & -2 \\end{pmatrix}\\);None',
    'correct': '\\(\\begin{pmatrix} 2 & -1 \\\\ -1 & 1 \\end{pmatrix}\\)',
  },
  {
    'name': 'T20P12',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 2,
    'content': 'If \\( A^2 = I \\), then A is:',
    'answers': 'Involutory;Idempotent;Nilpotent;Singular',
    'correct': 'Involutory',
  },
  {
    'name': 'T20P13',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 2,
    'content': 'Solve \\( \\begin{pmatrix} 1 & 2 \\\\ 3 & 4 \\end{pmatrix} \\begin{pmatrix} x \\\\ y \\end{pmatrix} = \\begin{pmatrix} 5 \\\\ 11 \\end{pmatrix} \\).',
    'answers': '(1, 2);(2, 1);(3, 2);(0, 0)',
    'correct': '(1, 2)',
  },
  {
    'name': 'T20P14',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 2,
    'content': 'Rank of \\( \\begin{pmatrix} 1 & 1 & 1 \\\\ 1 & 1 & 1 \\\\ 1 & 1 & 1 \\end{pmatrix} \\).',
    'answers': '1;3;0;2',
    'correct': '1',
  },

  // -- Difficulty 3 (Hard -> Word Problems/Reasoning) --
  {
    'name': 'T20P15',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 3,
    'content': 'If A is 3x3 and det(A) = 5, find det(2A).',
    'answers': '40;10;5;25',
    'correct': '40',
  },
  {
    'name': 'T20P16',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 3,
    'content': 'Rotation matrix for 90 degrees counter-clockwise.',
    'answers': '\\(\\begin{pmatrix} 0 & -1 \\\\ 1 & 0 \\end{pmatrix}\\);\\(\\begin{pmatrix} 0 & 1 \\\\ -1 & 0 \\end{pmatrix}\\);\\(\\begin{pmatrix} 1 & 0 \\\\ 0 & 1 \\end{pmatrix}\\);I',
    'correct': '\\(\\begin{pmatrix} 0 & -1 \\\\ 1 & 0 \\end{pmatrix}\\)',
  },
  {
    'name': 'T20P17',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 3,
    'content': 'Number of 2x2 matrices with entries 0 or 1 having determinant 1.',
    'answers': '3;5;2;6',
    'correct': '3',
  },
  {
    'name': 'T20P18',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 3,
    'content': 'If \\( A^T = -A \\) (skew-symmetric) and A is 3x3 real, then det(A) is:',
    'answers': '0;1;-1;Any real',
    'correct': '0',
  },
  {
    'name': 'T20P19',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 3,
    'content': 'Cayley-Hamilton Theorem says:',
    'answers': 'p(A) = 0 for char poly p;det(A) = trace(A);A is diagonal;Inverse exists',
    'correct': 'p(A) = 0 for char poly p',
  },
  {
    'name': 'T20P20',
    'category': 'Algebra',
    'topic': 20,
    'difficulty': 3,
    'content': 'If \\( M = \\begin{pmatrix} 1 & 1 \\\\ 0 & 1 \\end{pmatrix} \\), find \\( M^{100} \\).',
    'answers': '\\(\\begin{pmatrix} 1 & 100 \\\\ 0 & 1 \\end{pmatrix}\\);\\(\\begin{pmatrix} 1 & 1 \\\\ 0 & 1 \\end{pmatrix}\\);\\(\\begin{pmatrix} 100 & 100 \\\\ 0 & 100 \\end{pmatrix}\\);I',
    'correct': '\\(\\begin{pmatrix} 1 & 100 \\\\ 0 & 1 \\end{pmatrix}\\)',
  }
];

