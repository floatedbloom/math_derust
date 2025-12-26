import 'package:flutter/material.dart';

/// Represents a single skill/topic node in the skill tree
class SkillNode {
  final int id;
  final String name;
  final String shortName;
  final String description;
  final IconData icon;
  final List<int> prerequisites; // IDs of nodes that come before this
  final int problemCount;
  final bool isChallenge; // Challenge nodes are optional and not required to complete the tree
  
  const SkillNode({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
    required this.icon,
    this.prerequisites = const [],
    this.problemCount = 20,
    this.isChallenge = false,
  });
}

/// Challenge color for special challenge nodes
const Color challengeColor = Color(0xFFFFD700); // Gold color for challenges

/// Algebra skill tree - 20 topics (Basic + Intermediate combined)
const List<SkillNode> algebraSkillTree = [
  // ═══════════════════════════════════════════════════════════
  // FOUNDATIONS (Topics 1-3)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 1,
    name: 'Function Notation',
    shortName: 'f(x)',
    description: 'Evaluate functions and use function notation',
    icon: Icons.functions_rounded,
    prerequisites: [],
  ),
  SkillNode(
    id: 2,
    name: 'Linear Systems',
    shortName: 'Systems',
    description: 'Solve linear systems in two variables',
    icon: Icons.grid_on_rounded,
    prerequisites: [1],
  ),
  SkillNode(
    id: 3,
    name: 'Absolute Value',
    shortName: '|x|',
    description: 'Solve absolute value equations and inequalities',
    icon: Icons.straighten_rounded,
    prerequisites: [1],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // POLYNOMIALS & RATIONALS (Topics 4-7)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 4,
    name: 'Polynomials',
    shortName: 'Poly',
    description: 'Work with polynomial expressions',
    icon: Icons.show_chart_rounded,
    prerequisites: [2],
  ),
  SkillNode(
    id: 5,
    name: 'Rational Expressions',
    shortName: 'Rational',
    description: 'Simplify and work with rational expressions',
    icon: Icons.horizontal_split_rounded,
    prerequisites: [4],
  ),
  SkillNode(
    id: 6,
    name: 'Rational Equations',
    shortName: 'Solve',
    description: 'Solve rational equations',
    icon: Icons.balance_rounded,
    prerequisites: [5],
  ),
  SkillNode(
    id: 7,
    name: 'Literal Equations',
    shortName: 'Literal',
    description: 'Solve literal equations for a specific variable',
    icon: Icons.swap_horiz_rounded,
    prerequisites: [2, 3],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // RADICALS & EXPONENTS (Topics 8-10)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 8,
    name: 'Exponents & Radicals',
    shortName: 'xⁿ √x',
    description: 'Work with rational exponents and radicals',
    icon: Icons.superscript_rounded,
    prerequisites: [4],
  ),
  SkillNode(
    id: 9,
    name: 'Simplify Radicals',
    shortName: 'Simplify',
    description: 'Simplify radical expressions',
    icon: Icons.auto_fix_high_rounded,
    prerequisites: [8],
  ),
  SkillNode(
    id: 10,
    name: 'Radical Equations',
    shortName: 'Solve √',
    description: 'Solve radical equations and applications',
    icon: Icons.calculate_rounded,
    prerequisites: [9],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // QUADRATICS (Topics 11-13)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 11,
    name: 'Quadratic Equations',
    shortName: 'x²=0',
    description: 'Solve quadratic equations',
    icon: Icons.trending_up_rounded,
    prerequisites: [6, 10],
  ),
  SkillNode(
    id: 12,
    name: 'Quadratic Graphs',
    shortName: 'Parabola',
    description: 'Graph quadratic functions',
    icon: Icons.ssid_chart_rounded,
    prerequisites: [11],
  ),
  SkillNode(
    id: 13,
    name: 'Complex Numbers',
    shortName: 'i',
    description: 'Introduction to complex numbers',
    icon: Icons.hub_rounded,
    prerequisites: [11],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // ADVANCED FUNCTIONS (Topics 14-17)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 14,
    name: 'Polynomial Functions',
    shortName: 'Poly Fn',
    description: 'Higher degree polynomial functions',
    icon: Icons.insights_rounded,
    prerequisites: [12],
  ),
  SkillNode(
    id: 15,
    name: 'Rational Functions',
    shortName: 'Graphs',
    description: 'Graphs and properties of rational functions',
    icon: Icons.ssid_chart_rounded,
    prerequisites: [14],
  ),
  SkillNode(
    id: 16,
    name: 'Exponential Functions',
    shortName: 'eˣ',
    description: 'Exponential functions and their properties',
    icon: Icons.trending_up_rounded,
    prerequisites: [13],
  ),
  SkillNode(
    id: 17,
    name: 'Logarithms',
    shortName: 'log',
    description: 'Logarithmic functions and equations',
    icon: Icons.analytics_rounded,
    prerequisites: [16],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // ADVANCED TOPICS (Topics 18-20)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 18,
    name: 'Sequences & Series',
    shortName: 'Σ aₙ',
    description: 'Arithmetic and geometric sequences and series',
    icon: Icons.format_list_numbered_rounded,
    prerequisites: [16],
  ),
  SkillNode(
    id: 19,
    name: 'Conic Sections',
    shortName: 'Conics',
    description: 'Circles, ellipses, parabolas, hyperbolas',
    icon: Icons.lens_blur_rounded,
    prerequisites: [15],
  ),
  SkillNode(
    id: 20,
    name: 'Matrices',
    shortName: 'Matrix',
    description: 'Systems of equations and matrices',
    icon: Icons.grid_on_rounded,
    prerequisites: [15, 17],
  ),
  
  // Challenge - Extra hard reasoning problems (optional)
  SkillNode(
    id: 100,
    name: 'Challenge Problems',
    shortName: 'Challenge',
    description: 'Extra-hard reasoning problems for advanced practice',
    icon: Icons.local_fire_department_rounded,
    prerequisites: [],
    isChallenge: true,
  ),
];

/// Geometry skill tree
const List<SkillNode> geometrySkillTree = [
  SkillNode(
    id: 1,
    name: 'Basic Shapes',
    shortName: 'Shapes',
    description: 'Identify and classify basic shapes',
    icon: Icons.category_rounded,
    prerequisites: [],
  ),
  SkillNode(
    id: 2,
    name: 'Angles',
    shortName: 'Angles',
    description: 'Work with angles and their relationships',
    icon: Icons.architecture_rounded,
    prerequisites: [1],
  ),
  SkillNode(
    id: 3,
    name: 'Triangles',
    shortName: 'Tri',
    description: 'Properties of triangles',
    icon: Icons.change_history_rounded,
    prerequisites: [2],
  ),
  SkillNode(
    id: 4,
    name: 'Quadrilaterals',
    shortName: 'Quad',
    description: 'Properties of quadrilaterals',
    icon: Icons.crop_square_rounded,
    prerequisites: [2],
  ),
  SkillNode(
    id: 5,
    name: 'Circles',
    shortName: 'Circle',
    description: 'Properties of circles',
    icon: Icons.circle_outlined,
    prerequisites: [2],
  ),
  SkillNode(
    id: 6,
    name: 'Area & Perimeter',
    shortName: 'Area',
    description: 'Calculate area and perimeter',
    icon: Icons.square_foot_rounded,
    prerequisites: [3, 4, 5],
  ),
  SkillNode(
    id: 7,
    name: 'Volume',
    shortName: 'Volume',
    description: 'Calculate volume of 3D shapes',
    icon: Icons.view_in_ar_rounded,
    prerequisites: [6],
  ),
  SkillNode(
    id: 8,
    name: 'Transformations',
    shortName: 'Transform',
    description: 'Rotations, reflections, translations',
    icon: Icons.transform_rounded,
    prerequisites: [3, 4],
  ),
  SkillNode(
    id: 9,
    name: 'Similarity',
    shortName: 'Similar',
    description: 'Similar figures and proportions',
    icon: Icons.photo_size_select_large_rounded,
    prerequisites: [3, 6],
  ),
  SkillNode(
    id: 10,
    name: 'Coordinate Geometry',
    shortName: 'Coord',
    description: 'Geometry on the coordinate plane',
    icon: Icons.grid_3x3_rounded,
    prerequisites: [8, 9],
  ),
  
  // Challenge - Extra hard reasoning problems (optional)
  SkillNode(
    id: 100,
    name: 'Challenge Problems',
    shortName: 'Challenge',
    description: 'Extra-hard reasoning problems for advanced practice',
    icon: Icons.local_fire_department_rounded,
    prerequisites: [],
    isChallenge: true,
  ),
];

/// Trigonometry skill tree
const List<SkillNode> trigSkillTree = [
  SkillNode(
    id: 1,
    name: 'Right Triangles',
    shortName: 'Right △',
    description: 'Introduction to right triangle ratios',
    icon: Icons.change_history_rounded,
    prerequisites: [],
  ),
  SkillNode(
    id: 2,
    name: 'Trig Ratios',
    shortName: 'SOH-CAH',
    description: 'Sine, cosine, and tangent ratios',
    icon: Icons.architecture_rounded,
    prerequisites: [1],
  ),
  SkillNode(
    id: 3,
    name: 'Unit Circle',
    shortName: 'Unit ○',
    description: 'The unit circle and radian measure',
    icon: Icons.circle_outlined,
    prerequisites: [2],
  ),
  SkillNode(
    id: 4,
    name: 'Trig Functions',
    shortName: 'sin(x)',
    description: 'Trigonometric functions and their graphs',
    icon: Icons.show_chart_rounded,
    prerequisites: [3],
  ),
  SkillNode(
    id: 5,
    name: 'Inverse Trig',
    shortName: 'arcsin',
    description: 'Inverse trigonometric functions',
    icon: Icons.undo_rounded,
    prerequisites: [4],
  ),
  SkillNode(
    id: 6,
    name: 'Trig Identities',
    shortName: 'Identity',
    description: 'Fundamental trigonometric identities',
    icon: Icons.swap_horiz_rounded,
    prerequisites: [4],
  ),
  SkillNode(
    id: 7,
    name: 'Trig Equations',
    shortName: 'Solve',
    description: 'Solve trigonometric equations',
    icon: Icons.calculate_rounded,
    prerequisites: [5, 6],
  ),
  SkillNode(
    id: 8,
    name: 'Law of Sines',
    shortName: 'Sines',
    description: 'Apply the law of sines',
    icon: Icons.straighten_rounded,
    prerequisites: [2],
  ),
  SkillNode(
    id: 9,
    name: 'Law of Cosines',
    shortName: 'Cosines',
    description: 'Apply the law of cosines',
    icon: Icons.straighten_rounded,
    prerequisites: [8],
  ),
  SkillNode(
    id: 10,
    name: 'Applications',
    shortName: 'Apply',
    description: 'Real-world trig applications',
    icon: Icons.rocket_launch_rounded,
    prerequisites: [7, 9],
  ),
  
  // Challenge - Extra hard reasoning problems (optional)
  SkillNode(
    id: 100,
    name: 'Challenge Problems',
    shortName: 'Challenge',
    description: 'Extra-hard reasoning problems for advanced practice',
    icon: Icons.local_fire_department_rounded,
    prerequisites: [],
    isChallenge: true,
  ),
];

/// Calculus skill tree (Calc 1, 2, 3 combined) - 25 topics
const List<SkillNode> calculusSkillTree = [
  // ═══════════════════════════════════════════════════════════
  // CALC 1 - Differential Calculus Foundation (Topics 1-9)
  // ═══════════════════════════════════════════════════════════
  
  // Foundation tier
  SkillNode(
    id: 1,
    name: 'Limits',
    shortName: 'lim',
    description: 'Evaluate limits algebraically and graphically',
    icon: Icons.trending_flat_rounded,
    prerequisites: [],
  ),
  SkillNode(
    id: 2,
    name: 'Continuity',
    shortName: 'Cont.',
    description: 'Determine continuity and identify discontinuities',
    icon: Icons.linear_scale_rounded,
    prerequisites: [1],
  ),
  
  // Derivative foundation
  SkillNode(
    id: 3,
    name: 'Derivative Definition',
    shortName: 'Def.',
    description: 'Derivatives from the limit definition',
    icon: Icons.functions_rounded,
    prerequisites: [1],
  ),
  SkillNode(
    id: 4,
    name: 'Basic Derivatives',
    shortName: 'd/dx',
    description: 'Power, exponential, and logarithmic rules',
    icon: Icons.trending_up_rounded,
    prerequisites: [3],
  ),
  SkillNode(
    id: 5,
    name: 'Product & Quotient',
    shortName: 'f·g',
    description: 'Product and quotient rules',
    icon: Icons.call_split_rounded,
    prerequisites: [4],
  ),
  SkillNode(
    id: 6,
    name: 'Chain Rule',
    shortName: 'f∘g',
    description: 'Derivatives of composite functions',
    icon: Icons.link_rounded,
    prerequisites: [5],
  ),
  
  // Applications of derivatives
  SkillNode(
    id: 7,
    name: 'Implicit Differentiation',
    shortName: 'Impl.',
    description: 'Differentiate implicit equations',
    icon: Icons.gesture_rounded,
    prerequisites: [6],
  ),
  SkillNode(
    id: 8,
    name: 'Related Rates',
    shortName: 'Rates',
    description: 'Solve related rates problems',
    icon: Icons.speed_rounded,
    prerequisites: [7],
  ),
  SkillNode(
    id: 9,
    name: 'Optimization',
    shortName: 'Max/Min',
    description: 'Find extrema and optimize functions',
    icon: Icons.auto_graph_rounded,
    prerequisites: [6],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // CALC 1/2 - Integral Calculus (Topics 10-16)
  // ═══════════════════════════════════════════════════════════
  
  SkillNode(
    id: 10,
    name: 'Antiderivatives',
    shortName: '∫dx',
    description: 'Find basic antiderivatives',
    icon: Icons.vertical_align_center_rounded,
    prerequisites: [4],
  ),
  SkillNode(
    id: 11,
    name: 'Definite Integrals',
    shortName: '∫[a,b]',
    description: 'Evaluate definite integrals using FTC',
    icon: Icons.stacked_bar_chart_rounded,
    prerequisites: [10],
  ),
  SkillNode(
    id: 12,
    name: 'U-Substitution',
    shortName: 'u-sub',
    description: 'Integration by substitution',
    icon: Icons.find_replace_rounded,
    prerequisites: [11],
  ),
  SkillNode(
    id: 13,
    name: 'Integration by Parts',
    shortName: 'Parts',
    description: 'Integration by parts technique',
    icon: Icons.call_merge_rounded,
    prerequisites: [12],
  ),
  SkillNode(
    id: 14,
    name: 'Trig Integrals',
    shortName: 'Trig ∫',
    description: 'Integrate trigonometric functions',
    icon: Icons.waves_rounded,
    prerequisites: [12],
  ),
  SkillNode(
    id: 15,
    name: 'Partial Fractions',
    shortName: 'PFD',
    description: 'Partial fraction decomposition',
    icon: Icons.horizontal_split_rounded,
    prerequisites: [12],
  ),
  SkillNode(
    id: 16,
    name: 'Improper Integrals',
    shortName: '∫→∞',
    description: 'Evaluate improper integrals',
    icon: Icons.all_inclusive_rounded,
    prerequisites: [11],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // CALC 2 - Sequences & Series (Topics 17-20)
  // ═══════════════════════════════════════════════════════════
  
  SkillNode(
    id: 17,
    name: 'Sequences',
    shortName: 'aₙ',
    description: 'Analyze sequences and their limits',
    icon: Icons.format_list_numbered_rounded,
    prerequisites: [1],
  ),
  SkillNode(
    id: 18,
    name: 'Series Convergence',
    shortName: 'Σ conv',
    description: 'Tests for series convergence',
    icon: Icons.stacked_line_chart_rounded,
    prerequisites: [16, 17],
  ),
  SkillNode(
    id: 19,
    name: 'Power Series',
    shortName: 'Σxⁿ',
    description: 'Power series and radius of convergence',
    icon: Icons.electric_bolt_rounded,
    prerequisites: [18],
  ),
  SkillNode(
    id: 20,
    name: 'Taylor Series',
    shortName: 'Taylor',
    description: 'Taylor and Maclaurin series',
    icon: Icons.precision_manufacturing_rounded,
    prerequisites: [19],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // CALC 3 - Multivariable Calculus (Topics 21-25)
  // ═══════════════════════════════════════════════════════════
  
  SkillNode(
    id: 21,
    name: 'Partial Derivatives',
    shortName: '∂/∂x',
    description: 'Partial derivatives and gradients',
    icon: Icons.grid_3x3_rounded,
    prerequisites: [6],
  ),
  SkillNode(
    id: 22,
    name: 'Multiple Integrals',
    shortName: '∫∫',
    description: 'Double and triple integrals',
    icon: Icons.view_in_ar_rounded,
    prerequisites: [11, 21],
  ),
  SkillNode(
    id: 23,
    name: 'Vector Calculus',
    shortName: 'Vectors',
    description: 'Vector fields and operations',
    icon: Icons.arrow_outward_rounded,
    prerequisites: [21],
  ),
  SkillNode(
    id: 24,
    name: 'Line Integrals',
    shortName: '∮',
    description: 'Line integrals and path independence',
    icon: Icons.route_rounded,
    prerequisites: [22, 23],
  ),
  SkillNode(
    id: 25,
    name: 'Surface Integrals',
    shortName: '∬S',
    description: 'Stokes and Divergence theorems',
    icon: Icons.layers_rounded,
    prerequisites: [24],
  ),
  
  // Challenge - Extra hard reasoning problems (optional)
  SkillNode(
    id: 100,
    name: 'Challenge Problems',
    shortName: 'Challenge',
    description: 'Extra-hard reasoning problems for advanced practice',
    icon: Icons.local_fire_department_rounded,
    prerequisites: [],
    isChallenge: true,
  ),
];

/// Combinatorics & Probability skill tree - 18 topics
const List<SkillNode> combinatoricsSkillTree = [
  // ═══════════════════════════════════════════════════════════
  // COUNTING FOUNDATIONS (Topics 1-4)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 1,
    name: 'Counting Lists',
    shortName: 'Lists',
    description: 'Counting numbers in lists and sequences',
    icon: Icons.format_list_numbered_rounded,
    prerequisites: [],
  ),
  SkillNode(
    id: 2,
    name: 'Venn Diagrams',
    shortName: 'Venn',
    description: 'Counting with overlapping sets',
    icon: Icons.join_inner_rounded,
    prerequisites: [1],
  ),
  SkillNode(
    id: 3,
    name: 'Factorials',
    shortName: 'n!',
    description: 'Factorials and counting arrangements',
    icon: Icons.numbers_rounded,
    prerequisites: [1],
  ),
  SkillNode(
    id: 4,
    name: 'Permutations',
    shortName: 'nPr',
    description: 'Ordered arrangements of objects',
    icon: Icons.swap_vert_rounded,
    prerequisites: [3],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // COUNTING TECHNIQUES (Topics 5-9)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 5,
    name: 'Casework Counting',
    shortName: 'Cases',
    description: 'Breaking problems into separate cases',
    icon: Icons.account_tree_rounded,
    prerequisites: [4],
  ),
  SkillNode(
    id: 6,
    name: 'Complementary Counting',
    shortName: 'Compl.',
    description: 'Count what you don\'t want, then subtract',
    icon: Icons.remove_circle_outline_rounded,
    prerequisites: [5],
  ),
  SkillNode(
    id: 7,
    name: 'Constructive Counting',
    shortName: 'Build',
    description: 'Build arrangements step by step',
    icon: Icons.construction_rounded,
    prerequisites: [5],
  ),
  SkillNode(
    id: 8,
    name: 'Counting with Restrictions',
    shortName: 'Restrict',
    description: 'Counting when rules limit choices',
    icon: Icons.block_rounded,
    prerequisites: [6, 7],
  ),
  SkillNode(
    id: 9,
    name: 'Overcounting & Division',
    shortName: 'Divide',
    description: 'Correcting for counting things twice',
    icon: Icons.functions_rounded,
    prerequisites: [8],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // COMBINATIONS (Topics 10-12)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 10,
    name: 'Basic Combinations',
    shortName: 'nCr',
    description: 'Selections where order doesn\'t matter',
    icon: Icons.group_work_rounded,
    prerequisites: [9],
  ),
  SkillNode(
    id: 11,
    name: 'Combinations w/ Restrictions',
    shortName: 'Comb+',
    description: 'Combinations with additional constraints',
    icon: Icons.filter_list_rounded,
    prerequisites: [10],
  ),
  SkillNode(
    id: 12,
    name: 'Distinguishability',
    shortName: 'Distinct',
    description: 'When objects are identical or distinct',
    icon: Icons.difference_rounded,
    prerequisites: [10],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // PROBABILITY (Topics 13-16)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 13,
    name: 'Probability as Counting',
    shortName: 'P(A)',
    description: 'Probability through counting outcomes',
    icon: Icons.casino_rounded,
    prerequisites: [10],
  ),
  SkillNode(
    id: 14,
    name: 'Probability with Casework',
    shortName: 'P+Cases',
    description: 'Using casework in probability problems',
    icon: Icons.call_split_rounded,
    prerequisites: [13],
  ),
  SkillNode(
    id: 15,
    name: 'Complementary Probability',
    shortName: '1-P',
    description: 'Find P(not A) and subtract from 1',
    icon: Icons.flip_rounded,
    prerequisites: [14],
  ),
  SkillNode(
    id: 16,
    name: 'Geometric Probability',
    shortName: 'Geom P',
    description: 'Using geometry in probability problems',
    icon: Icons.square_foot_rounded,
    prerequisites: [14],
  ),
  
  // ═══════════════════════════════════════════════════════════
  // ADVANCED TOPICS (Topics 17-18)
  // ═══════════════════════════════════════════════════════════
  SkillNode(
    id: 17,
    name: 'Expected Value',
    shortName: 'E[X]',
    description: 'Calculate expected outcomes',
    icon: Icons.trending_flat_rounded,
    prerequisites: [15],
  ),
  SkillNode(
    id: 18,
    name: 'Binomial Theorem',
    shortName: '(a+b)ⁿ',
    description: 'Pascal\'s triangle and binomial expansion',
    icon: Icons.change_history_rounded,
    prerequisites: [11, 12],
  ),
  
  // Challenge - Extra hard reasoning problems (optional)
  SkillNode(
    id: 100,
    name: 'Challenge Problems',
    shortName: 'Challenge',
    description: 'Extra-hard reasoning problems for advanced practice',
    icon: Icons.local_fire_department_rounded,
    prerequisites: [],
    isChallenge: true,
  ),
];

/// Get skill tree for a subject
List<SkillNode> getSkillTree(String subject) {
  switch (subject.toLowerCase()) {
    case 'algebra':
      return algebraSkillTree;
    case 'geometry':
      return geometrySkillTree;
    case 'trigonometry':
      return trigSkillTree;
    case 'calculus':
      return calculusSkillTree;
    case 'combinatorics':
      return combinatoricsSkillTree;
    default:
      return algebraSkillTree;
  }
}

