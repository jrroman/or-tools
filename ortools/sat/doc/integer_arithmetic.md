| [home](README.md) | [boolean logic](boolean_logic.md) | [integer arithmetic](integer_arithmetic.md) | [channeling constraints](channeling.md) | [scheduling](scheduling.md) | [Using the CP-SAT solver](solver.md) | [Reference manual](reference.md) |
| ----------------- | --------------------------------- | ------------------------------------------- | --------------------------------------- | --------------------------- | ------------------------------------ | -------------------------------- |


# Integer arithmetic recipes for the CP-SAT solver.



## Introduction

The CP-SAT solver can express integer variables and constraints.

## Integer variables

Integer variables can take on 64 bit signed integer values. When creating them,
a domain must be given. The format of this domain is not uniform across languages.

In Java, Python, and C#:

-   To represent a interval from 0 to 10, just pass the two bounds (0, 10) as in
    `NewIntVar(0, 10, "x")`. A single value will be represented by twice the
    value as in [5, 5].
-   To create a variable with a single value domain, use the `NewConstant()` API
    (or `newConstant()` in Java).
-   To represent an enumerated list of values, for example {-5, -4, -3, 1, 3, 4,
    6, 6}, you need to rewrite it as a list of intervals [-5, -3] U [1] U [3,
    6], then flatten the list into a single list of integers. This gives `[-5,
    -3, 1, 1, 3, 6]` in python, or `new long[] {-5, -3, 1, 1, 3, 6}` in Java or
    C#.
-   To create a variable with an enumerated domain, use the
    `NewEnumeratedIntVar()` API as in:
    -   Python: `model.NewEnumeratedIntVar([-5, -3, 1, 1, 3, 6], 'x')`
    -   Java: `model.newEnumeratedIntVar(new long[] {-5, -3, 1, 1, 3, 6}, "x")`
    -   C#: `model.NewEnumeratedIntVar(new long[] {-5, -3, 1, 1, 3, 6}, "x")`
-   To exclude a single value, use int64min and int64max values as in [int64min,
    4, 6, int64max]:
    -   Python: `cp_model.INT_MIN` and `cp_model.INT_MAX`
    -   Java: `Long.MIN_VALUE` and `Long.MAX_VALUE`
    -   C#: `Int64.MinValue` and `Int64.MaxValue`

In C++, domains use the Domain class.

-   To represent a interval from 0 to 10, just pass a domain `{0, 10}` or
    `Domain(0, 10)` as in `NewIntVar({0, 10})`.
-   To represent a single value (5), create a domain `{5, 5}` or `Domain(5)`.
-   To create a fixed variable (constant), use the `NewConstant()` API.
-   To represent an enumerated list of values, for instance {-5, -4, -3, 1, 3,
    4, 5, 6}, you can use `Domain::FromValues({-5, -4, -3, 1, 3, 4, 5, 6})` or
    `Domain::FromIntervals({{-5, -3}, {1, 1}, {3, 6}})`.
-   To create a variable with an enumerated domain, build the enumerated domain,
    and use it as in `cp_model.NewIntVar(Domain::FromIntervals({{-5, -3}, {1,
    1}, {3, 6}})).WithName("x")`.
-   To exclude a single value, use `Domain(5).Complement()`.

## Linear constraints

In **C++** and **Java**, the model supports linear constraints as in:

    x <= y + 3 (also ==, !=, <, >=, >).

as well as domain constraints as in:

    sum(ai * xi) in domain

where domain uses the same encoding as integer variables. These are available
through specific methods of the cp_model like `cp_model.AddEquality(x, 3)` in
C++, `cp_model.addGreaterThan(x, 10)` in java.

**Python** and **C\#** CP-SAT APIs support general linear arithmetic (+, *, -,
==, >=, >, <, <=, !=). You need to use the Add method of the cp_model as in
`cp_model.Add(x != 3)`.

## Rabbits and Pheasants examples

Let's solve a simple children's puzzle: the Rabbits and Pheasants problem.

In a field of rabbits and pheasants, there are 20 heads and 56 legs. How many
rabbits and pheasants are there?

### Python code

```python
"""Rabbits and Pheasants quizz."""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from ortools.sat.python import cp_model


def RabbitsAndPheasantsSat():
  """Solves the rabbits + pheasants problem."""
  model = cp_model.CpModel()

  r = model.NewIntVar(0, 100, 'r')
  p = model.NewIntVar(0, 100, 'p')

  # 20 heads.
  model.Add(r + p == 20)
  # 56 legs.
  model.Add(4 * r + 2 * p == 56)

  # Solves and prints out the solution.
  solver = cp_model.CpSolver()
  status = solver.Solve(model)

  if status == cp_model.FEASIBLE:
    print('%i rabbits and %i pheasants' % (solver.Value(r), solver.Value(p)))


RabbitsAndPheasantsSat()
```

### C++ code

```cpp
#include "ortools/sat/cp_model.h"

namespace operations_research {
namespace sat {

void RabbitsAndPheasantsSat() {
  CpModelBuilder cp_model;

  const Domain all_animals(0, 20);
  const IntVar rabbits = cp_model.NewIntVar(all_animals).WithName("rabbits");
  const IntVar pheasants =
      cp_model.NewIntVar(all_animals).WithName("pheasants");

  cp_model.AddEquality(LinearExpr::Sum({rabbits, pheasants}), 20);
  cp_model.AddEquality(LinearExpr::ScalProd({rabbits, pheasants}, {4, 2}), 56);

  const CpSolverResponse response = Solve(cp_model);

  if (response.status() == CpSolverStatus::FEASIBLE) {
    // Get the value of x in the solution.
    LOG(INFO) << SolutionIntegerValue(response, rabbits) << " rabbits, and "
              << SolutionIntegerValue(response, pheasants) << " pheasants";
  }
}

}  // namespace sat
}  // namespace operations_research

int main() {
  operations_research::sat::RabbitsAndPheasantsSat();

  return EXIT_SUCCESS;
}
```

### Java code

```java
import com.google.ortools.sat.CpSolverStatus;
import com.google.ortools.sat.CpModel;
import com.google.ortools.sat.CpSolver;
import com.google.ortools.sat.IntVar;

/**
 * In a field of rabbits and pheasants, there are 20 heads and 56 legs. How many rabbits and
 * pheasants are there?
 */
public class RabbitsAndPheasantsSat {

  static { System.loadLibrary("jniortools"); }

  public static void main(String[] args) throws Exception {
    // Creates the model.
    CpModel model = new CpModel();
    // Creates the variables.
    IntVar r = model.newIntVar(0, 100, "r");
    IntVar p = model.newIntVar(0, 100, "p");
    // 20 heads.
    model.addLinearSumEqual(new IntVar[] {r, p}, 20);
    // 56 legs.
    model.addScalProdEqual(new IntVar[] {r, p}, new long[] {4, 2}, 56);

    // Creates a solver and solves the model.
    CpSolver solver = new CpSolver();
    CpSolverStatus status = solver.solve(model);

    if (status == CpSolverStatus.FEASIBLE) {
      System.out.println(solver.value(r) + " rabbits, and " + solver.value(p) + " pheasants");
    }
  }
}
```

### C\# code

```cs
using System;
using Google.OrTools.Sat;

public class RabbitsAndPheasantsSat
{
  static void Main()
  {
    // Creates the model.
    CpModel model = new CpModel();
    // Creates the variables.
    IntVar r = model.NewIntVar(0, 100, "r");
    IntVar p = model.NewIntVar(0, 100, "p");
    // 20 heads.
    model.Add(r + p == 20);
    // 56 legs.
    model.Add(4 * r + 2 * p == 56);

    // Creates a solver and solves the model.
    CpSolver solver = new CpSolver();
    CpSolverStatus status = solver.Solve(model);

    if (status == CpSolverStatus.Feasible)
    {
      Console.WriteLine(solver.Value(r) + " rabbits, and " +
                        solver.Value(p) + " pheasants");
    }
  }
}
```

## Earliness-Tardiness cost function.

Let's encode a useful convex piecewise linear function that often appears in
scheduling. You want to encourage a delivery to happen during a time window. If
you deliver early, you pay a linear penalty on waiting time. If you deliver
late, you pay a linear penalty on the delay.

Because the function is convex, you can define all affine functions, and take
the max of them to define the piecewise linear function.

The following samples output:

    x=0 expr=40
    x=1 expr=32
    x=2 expr=24
    x=3 expr=16
    x=4 expr=8
    x=5 expr=0
    x=6 expr=0
    x=7 expr=0
    x=8 expr=0
    x=9 expr=0
    x=10 expr=0
    x=11 expr=0
    x=12 expr=0
    x=13 expr=0
    x=14 expr=0
    x=15 expr=0
    x=16 expr=12
    x=17 expr=24
    x=18 expr=36
    x=19 expr=48
    x=20 expr=60

### Python code

```python
"""Encodes an convex piecewise linear function."""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from ortools.sat.python import cp_model


class VarArraySolutionPrinter(cp_model.CpSolverSolutionCallback):
  """Print intermediate solutions."""

  def __init__(self, variables):
    cp_model.CpSolverSolutionCallback.__init__(self)
    self.__variables = variables
    self.__solution_count = 0

  def on_solution_callback(self):
    self.__solution_count += 1
    for v in self.__variables:
      print('%s=%i' % (v, self.Value(v)), end=' ')
    print()

  def solution_count(self):
    return self.__solution_count


def earliness_tardiness_cost_sample_sat():
  """Encode the piecewise linear expression."""

  earliness_date = 5  # ed.
  earliness_cost = 8
  lateness_date = 15  # ld.
  lateness_cost = 12

  # Model.
  model = cp_model.CpModel()

  # Declare our primary variable.
  x = model.NewIntVar(0, 20, 'x')

  # Create the expression variable and implement the piecewise linear function.
  #
  #  \        /
  #   \______/
  #   ed    ld
  #
  large_constant = 1000
  expr = model.NewIntVar(0, large_constant, 'expr')

  # First segment.
  s1 = model.NewIntVar(-large_constant, large_constant, 's1')
  model.Add(s1 == earliness_cost * (earliness_date - x))

  # Second segment.
  s2 = 0

  # Third segment.
  s3 = model.NewIntVar(-large_constant, large_constant, 's3')
  model.Add(s3 == lateness_cost * (x - lateness_date))

  # Link together expr and x through s1, s2, and s3.
  model.AddMaxEquality(expr, [s1, s2, s3])

  # Search for x values in increasing order.
  model.AddDecisionStrategy([x], cp_model.CHOOSE_FIRST,
                            cp_model.SELECT_MIN_VALUE)

  # Create a solver and solve with a fixed search.
  solver = cp_model.CpSolver()

  # Force the solver to follow the decision strategy exactly.
  solver.parameters.search_branching = cp_model.FIXED_SEARCH

  # Search and print out all solutions.
  solution_printer = VarArraySolutionPrinter([x, expr])
  solver.SearchForAllSolutions(model, solution_printer)


earliness_tardiness_cost_sample_sat()
```

### C++ code

```cpp
#include "ortools/sat/cp_model.h"
#include "ortools/sat/model.h"
#include "ortools/sat/sat_parameters.pb.h"

namespace operations_research {
namespace sat {

void EarlinessTardinessCostSampleSat() {
  const int64 kEarlinessDate = 5;
  const int64 kEarlinessCost = 8;
  const int64 kLatenessDate = 15;
  const int64 kLatenessCost = 12;

  // Create the CP-SAT model.
  CpModelBuilder cp_model;

  // Declare our primary variable.
  const IntVar x = cp_model.NewIntVar({0, 20});

  // Create the expression variable and implement the piecewise linear function.
  //
  //  \        /
  //   \______/
  //   ed    ld
  //
  const int64 kLargeConstant = 1000;
  const IntVar expr = cp_model.NewIntVar({0, kLargeConstant});

  // First segment.
  const IntVar s1 = cp_model.NewIntVar({-kLargeConstant, kLargeConstant});
  cp_model.AddEquality(s1, LinearExpr::ScalProd({x}, {-kEarlinessCost})
                               .AddConstant(kEarlinessCost * kEarlinessDate));

  // Second segment.
  const IntVar s2 = cp_model.NewConstant(0);

  // Third segment.
  const IntVar s3 = cp_model.NewIntVar({-kLargeConstant, kLargeConstant});
  cp_model.AddEquality(s3, LinearExpr::ScalProd({x}, {kLatenessCost})
                               .AddConstant(-kLatenessCost * kLatenessDate));

  // Link together expr and x through s1, s2, and s3.
  cp_model.AddMaxEquality(expr, {s1, s2, s3});

  // Search for x values in increasing order.
  cp_model.AddDecisionStrategy({x}, DecisionStrategyProto::CHOOSE_FIRST,
                               DecisionStrategyProto::SELECT_MIN_VALUE);

  // Create a solver and solve with a fixed search.
  Model model;
  SatParameters parameters;
  parameters.set_search_branching(SatParameters::FIXED_SEARCH);
  parameters.set_enumerate_all_solutions(true);
  model.Add(NewSatParameters(parameters));
  model.Add(NewFeasibleSolutionObserver([&](const CpSolverResponse& r) {
    LOG(INFO) << "x=" << SolutionIntegerValue(r, x) << " expr"
              << SolutionIntegerValue(r, expr);
  }));
  SolveWithModel(cp_model, &model);
}

}  // namespace sat
}  // namespace operations_research

int main() {
  operations_research::sat::EarlinessTardinessCostSampleSat();

  return EXIT_SUCCESS;
}
```

### Java code

```java
import com.google.ortools.sat.DecisionStrategyProto;
import com.google.ortools.sat.SatParameters;
import com.google.ortools.sat.CpModel;
import com.google.ortools.sat.CpSolver;
import com.google.ortools.sat.CpSolverSolutionCallback;
import com.google.ortools.sat.IntVar;

/** Encode the piecewise linear expression. */
public class EarlinessTardinessCostSampleSat {
  static { System.loadLibrary("jniortools"); }

  public static void main(String[] args) throws Exception {
    long earlinessDate = 5;
    long earlinessCost = 8;
    long latenessDate = 15;
    long latenessCost = 12;

    // Create the CP-SAT model.
    CpModel model = new CpModel();

    // Declare our primary variable.
    IntVar x = model.newIntVar(0, 20, "x");

    // Create the expression variable and implement the piecewise linear function.
    //
    //  \        /
    //   \______/
    //   ed    ld
    //
    long largeConstant = 1000;
    IntVar expr = model.newIntVar(0, largeConstant, "expr");

    // First segment: s1 == earlinessCost * (earlinessDate - x).
    IntVar s1 = model.newIntVar(-largeConstant, largeConstant, "s1");
    model.addScalProdEqual(
        new IntVar[] {s1, x}, new long[] {1, earlinessCost}, earlinessCost * earlinessDate);

    // Second segment.
    IntVar s2 = model.newConstant(0);

    // Third segment: s3 == latenessCost * (x - latenessDate).
    IntVar s3 = model.newIntVar(-largeConstant, largeConstant, "s3");
    model.addScalProdEqual(
        new IntVar[] {s3, x}, new long[] {1, -latenessCost}, -latenessCost * latenessDate);

    // Link together expr and x through s1, s2, and s3.
    model.addMaxEquality(expr, new IntVar[] {s1, s2, s3});

    // Search for x values in increasing order.
    model.addDecisionStrategy(
        new IntVar[] {x},
        DecisionStrategyProto.VariableSelectionStrategy.CHOOSE_FIRST,
        DecisionStrategyProto.DomainReductionStrategy.SELECT_MIN_VALUE);

    // Create the solver.
    CpSolver solver = new CpSolver();

    // Force the solver to follow the decision strategy exactly.
    solver.getParameters().setSearchBranching(SatParameters.SearchBranching.FIXED_SEARCH);

    // Solve the problem with the printer callback.
    solver.searchAllSolutions(
        model,
        new CpSolverSolutionCallback() {
          public CpSolverSolutionCallback init(IntVar[] variables) {
            variableArray = variables;
            return this;
          }

          @Override
          public void onSolutionCallback() {
            for (IntVar v : variableArray) {
              System.out.printf("%s=%d ", v.getName(), value(v));
            }
            System.out.println();
          }

          private IntVar[] variableArray;
        }.init(new IntVar[] {x, expr}));
  }
}
```

### C\# code

```cs
using System;
using Google.OrTools.Sat;

public class VarArraySolutionPrinter : CpSolverSolutionCallback
{
  public VarArraySolutionPrinter(IntVar[] variables)
  {
    variables_ = variables;
  }

  public override void OnSolutionCallback()
  {
    {
      foreach (IntVar v in variables_)
      {
        Console.Write(String.Format("{0}={1} ", v.ShortString(), Value(v)));
      }
      Console.WriteLine();
    }
  }

  private IntVar[] variables_;
}

public class EarlinessTardinessCostSampleSat
{
  static void Main()
  {
    long earliness_date = 5;
    long earliness_cost = 8;
    long lateness_date = 15;
    long lateness_cost = 12;

    // Create the CP-SAT model.
    CpModel model = new CpModel();

    // Declare our primary variable.
    IntVar x = model.NewIntVar(0, 20, "x");

    // Create the expression variable and implement the piecewise linear
    // function.
    //
    //  \        /
    //   \______/
    //   ed    ld
    //
    long large_constant = 1000;
    IntVar expr = model.NewIntVar(0, large_constant, "expr");

    // First segment.
    IntVar s1 = model.NewIntVar(-large_constant, large_constant, "s1");
    model.Add(s1 == earliness_cost * (earliness_date - x));

    // Second segment.
    IntVar s2 = model.NewConstant(0);

    // Third segment.
    IntVar s3 = model.NewIntVar(-large_constant, large_constant, "s3");
    model.Add(s3 == lateness_cost * (x - lateness_date));

    // Link together expr and x through s1, s2, and s3.
    model.AddMaxEquality(expr, new IntVar[] {s1, s2, s3});

    // Search for x values in increasing order.
    model.AddDecisionStrategy(
        new IntVar[] {x},
        DecisionStrategyProto.Types.VariableSelectionStrategy.ChooseFirst,
        DecisionStrategyProto.Types.DomainReductionStrategy.SelectMinValue);

    // Create the solver.
    CpSolver solver = new CpSolver();

    // Force solver to follow the decision strategy exactly.
    solver.StringParameters = "search_branching:FIXED_SEARCH";

    VarArraySolutionPrinter cb =
        new VarArraySolutionPrinter(new IntVar[] {x, expr});
    solver.SearchAllSolutions(model, cb);
  }
}
```

## Step function.

Let's encode a step function. We will use one Boolean variable per step value,
and filter the admissible domain of the input variable with this variable.

The following samples output:

    x=0 expr=2
    x=1 expr=2
    x=3 expr=2
    x=4 expr=2
    x=5 expr=0
    x=6 expr=0
    x=7 expr=3
    x=8 expr=0
    x=9 expr=0
    x=10 expr=0
    x=11 expr=2
    x=12 expr=2
    x=13 expr=2
    x=14 expr=2
    x=15 expr=2
    x=16 expr=2
    x=17 expr=2
    x=18 expr=2
    x=19 expr=2
    x=20 expr=2

### Python code

```python
"""Implements a step function."""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

from ortools.sat.python import cp_model


class VarArraySolutionPrinter(cp_model.CpSolverSolutionCallback):
  """Print intermediate solutions."""

  def __init__(self, variables):
    cp_model.CpSolverSolutionCallback.__init__(self)
    self.__variables = variables
    self.__solution_count = 0

  def on_solution_callback(self):
    self.__solution_count += 1
    for v in self.__variables:
      print('%s=%i' % (v, self.Value(v)), end=' ')
    print()

  def solution_count(self):
    return self.__solution_count


def step_function_sample_sat():
  """Encode the step function."""

  # Model.
  model = cp_model.CpModel()

  # Declare our primary variable.
  x = model.NewIntVar(0, 20, 'x')

  # Create the expression variable and implement the step function
  # Note it is not defined for x == 2.
  #
  #        -               3
  # -- --      ---------   2
  #                        1
  #      -- ---            0
  # 0 ================ 20
  #
  expr = model.NewIntVar(0, 3, 'expr')

  # expr == 0 on [5, 6] U [8, 10]
  b0 = model.NewBoolVar('b0')
  model.AddLinearConstraintWithBounds([(x, 1)], [5, 6, 8, 10]).OnlyEnforceIf(b0)
  model.Add(expr == 0).OnlyEnforceIf(b0)

  # expr == 2 on [0, 1] U [3, 4] U [11, 20]
  b2 = model.NewBoolVar('b2')
  model.AddLinearConstraintWithBounds([(x, 1)],
                                      [0, 1, 3, 4, 11, 20]).OnlyEnforceIf(b2)
  model.Add(expr == 2).OnlyEnforceIf(b2)

  # expr == 3 when x == 7
  b3 = model.NewBoolVar('b3')
  model.Add(x == 7).OnlyEnforceIf(b3)
  model.Add(expr == 3).OnlyEnforceIf(b3)

  # At least one bi is true. (we could use a sum == 1).
  model.AddBoolOr([b0, b2, b3])

  # Search for x values in increasing order.
  model.AddDecisionStrategy([x], cp_model.CHOOSE_FIRST,
                            cp_model.SELECT_MIN_VALUE)

  # Create a solver and solve with a fixed search.
  solver = cp_model.CpSolver()

  # Force the solver to follow the decision strategy exactly.
  solver.parameters.search_branching = cp_model.FIXED_SEARCH

  # Search and print out all solutions.
  solution_printer = VarArraySolutionPrinter([x, expr])
  solver.SearchForAllSolutions(model, solution_printer)


step_function_sample_sat()
```

### C++ code

```cpp
#include "ortools/sat/cp_model.h"
#include "ortools/sat/model.h"
#include "ortools/sat/sat_parameters.pb.h"

namespace operations_research {
namespace sat {

void StepFunctionSampleSat() {
  // Create the CP-SAT model.
  CpModelBuilder cp_model;

  // Declare our primary variable.
  const IntVar x = cp_model.NewIntVar({0, 20});

  // Create the expression variable and implement the step function
  // Note it is not defined for var == 2.
  //
  //        -               3
  // -- --      ---------   2
  //                        1
  //      -- ---            0
  // 0 ================ 20
  //
  IntVar expr = cp_model.NewIntVar({0, 3});

  // expr == 0 on [5, 6] U [8, 10]
  BoolVar b0 = cp_model.NewBoolVar();
  cp_model.AddLinearConstraint(x, Domain::FromValues({5, 6, 8, 9, 10}))
      .OnlyEnforceIf(b0);
  cp_model.AddEquality(expr, 0).OnlyEnforceIf(b0);

  // expr == 2 on [0, 1] U [3, 4] U [11, 20]
  BoolVar b2 = cp_model.NewBoolVar();
  cp_model
      .AddLinearConstraint(x, Domain::FromIntervals({{0, 1}, {3, 4}, {11, 20}}))
      .OnlyEnforceIf(b2);
  cp_model.AddEquality(expr, 2).OnlyEnforceIf(b2);

  // expr == 3 when x = 7
  BoolVar b3 = cp_model.NewBoolVar();
  cp_model.AddEquality(x, 7).OnlyEnforceIf(b3);
  cp_model.AddEquality(expr, 3).OnlyEnforceIf(b3);

  // At least one bi is true. (we could use a sum == 1).
  cp_model.AddBoolOr({b0, b2, b3});

  // Search for x values in increasing order.
  cp_model.AddDecisionStrategy({x}, DecisionStrategyProto::CHOOSE_FIRST,
                               DecisionStrategyProto::SELECT_MIN_VALUE);

  // Create a solver and solve with a fixed search.
  Model model;
  SatParameters parameters;
  parameters.set_search_branching(SatParameters::FIXED_SEARCH);
  parameters.set_enumerate_all_solutions(true);
  model.Add(NewSatParameters(parameters));
  model.Add(NewFeasibleSolutionObserver([&](const CpSolverResponse& r) {
    LOG(INFO) << "x=" << SolutionIntegerValue(r, x) << " expr"
              << SolutionIntegerValue(r, expr);
  }));
  SolveWithModel(cp_model, &model);
}

}  // namespace sat
}  // namespace operations_research

int main() {
  operations_research::sat::StepFunctionSampleSat();

  return EXIT_SUCCESS;
}
```

### Java code

```java
import com.google.ortools.sat.DecisionStrategyProto;
import com.google.ortools.sat.SatParameters;
import com.google.ortools.sat.CpModel;
import com.google.ortools.sat.CpSolver;
import com.google.ortools.sat.CpSolverSolutionCallback;
import com.google.ortools.sat.IntVar;
import com.google.ortools.sat.Literal;

/** Link integer constraints together. */
public class StepFunctionSampleSat {

  static { System.loadLibrary("jniortools"); }

  public static void main(String[] args) throws Exception {
    // Create the CP-SAT model.
    CpModel model = new CpModel();

    // Declare our primary variable.
    IntVar x = model.newIntVar(0, 20, "x");

    // Create the expression variable and implement the step function
    // Note it is not defined for var == 2.
    //
    //        -               3
    // -- --      ---------   2
    //                        1
    //      -- ---            0
    // 0 ================ 20
    //
    IntVar expr = model.newIntVar(0, 3, "expr");

    // expr == 0 on [5, 6] U [8, 10]
    Literal b0 = model.newBoolVar("b0");
    model.addLinearSumWithBounds(new IntVar[] {x}, new long[] {5, 6, 8, 10}).onlyEnforceIf(b0);
    model.addEquality(expr, 0).onlyEnforceIf(b0);

    // expr == 2 on [0, 1] U [3, 4] U [11, 20]
    Literal b2 = model.newBoolVar("b2");
    model
        .addLinearSumWithBounds(new IntVar[] {x}, new long[] {0, 1, 3, 4, 11, 20})
        .onlyEnforceIf(b2);
    model.addEquality(expr, 2).onlyEnforceIf(b2);

    // expr == 3 when x = 7
    Literal b3 = model.newBoolVar("b3");
    model.addEquality(x, 7).onlyEnforceIf(b3);
    model.addEquality(expr, 3).onlyEnforceIf(b3);

    // At least one bi is true. (we could use a sum == 1).
    model.addBoolOr(new Literal[] {b0, b2, b3});

    // Search for x values in increasing order.
    model.addDecisionStrategy(
        new IntVar[] {x},
        DecisionStrategyProto.VariableSelectionStrategy.CHOOSE_FIRST,
        DecisionStrategyProto.DomainReductionStrategy.SELECT_MIN_VALUE);

    // Create the solver.
    CpSolver solver = new CpSolver();

    // Force the solver to follow the decision strategy exactly.
    solver.getParameters().setSearchBranching(SatParameters.SearchBranching.FIXED_SEARCH);

    // Solve the problem with the printer callback.
    solver.searchAllSolutions(
        model,
        new CpSolverSolutionCallback() {
          public CpSolverSolutionCallback init(IntVar[] variables) {
            variableArray = variables;
            return this;
          }

          @Override
          public void onSolutionCallback() {
            for (IntVar v : variableArray) {
              System.out.printf("%s=%d ", v.getName(), value(v));
            }
            System.out.println();
          }

          private IntVar[] variableArray;
        }.init(new IntVar[] {x, expr}));
  }
}
```

### C\# code

```cs
using System;
using Google.OrTools.Sat;

public class VarArraySolutionPrinter : CpSolverSolutionCallback
{
  public VarArraySolutionPrinter(IntVar[] variables)
  {
    variables_ = variables;
  }

  public override void OnSolutionCallback()
  {
    {
      foreach (IntVar v in variables_)
      {
        Console.Write(String.Format("{0}={1} ", v.ShortString(), Value(v)));
      }
      Console.WriteLine();
    }
  }

  private IntVar[] variables_;
}

public class StepFunctionSampleSat
{
  static void Main()
  {
    // Create the CP-SAT model.
    CpModel model = new CpModel();

    // Declare our primary variable.
    IntVar x = model.NewIntVar(0, 20, "x");

    // Create the expression variable and implement the step function
    // Note it is not defined for var == 2.
    //
    //        -               3
    // -- --      ---------   2
    //                        1
    //      -- ---            0
    // 0 ================ 20
    //
    IntVar expr = model.NewIntVar(0, 3, "expr");

    // expr == 0 on [5, 6] U [8, 10]
    ILiteral b0 = model.NewBoolVar("b0");
    model.AddLinearConstraintWithBounds(
        new IntVar[] {x},
        new long[] {1},
        new long[] {5, 6, 8, 10}).OnlyEnforceIf(b0);
    model.Add(expr == 0).OnlyEnforceIf(b0);

    // expr == 2 on [0, 1] U [3, 4] U [11, 20]
    ILiteral b2 = model.NewBoolVar("b2");
    model.AddLinearConstraintWithBounds(
        new IntVar[] {x},
        new long[] {1},
        new long[] {0, 1, 3, 4, 11, 20}).OnlyEnforceIf(b2);
    model.Add(expr == 2).OnlyEnforceIf(b2);

    // expr == 3 when x == 7
    ILiteral b3 = model.NewBoolVar("b3");
    model.Add(x == 7).OnlyEnforceIf(b3);
    model.Add(expr == 3).OnlyEnforceIf(b3);

    // At least one bi is true. (we could use a sum == 1).
    model.AddBoolOr(new ILiteral[] {b0, b2, b3});

    // Search for x values in increasing order.
    model.AddDecisionStrategy(
        new IntVar[] {x},
        DecisionStrategyProto.Types.VariableSelectionStrategy.ChooseFirst,
        DecisionStrategyProto.Types.DomainReductionStrategy.SelectMinValue);

    // Create the solver.
    CpSolver solver = new CpSolver();

    // Force solver to follow the decision strategy exactly.
    solver.StringParameters = "search_branching:FIXED_SEARCH";

    VarArraySolutionPrinter cb =
        new VarArraySolutionPrinter(new IntVar[] {x, expr});
    solver.SearchAllSolutions(model, cb);
  }
}
```
