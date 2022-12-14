---
title: openInterfaces
theme: black
revealOptions:
  transition: 'slide'
  controls: true
  slideNumber: true
---

# `Towards Foundations for Open Interfaces for Scientific Computing`

<small>René Fritze</small>

<small>rene.fritze@wwu.de</small>

<small>Mathematics Münster</small>

<small>October 28, 2022</small>

<small>*1st MaRDI Workshop on Scientific Computing*</small>

---

# `openInterfaces`

<small>René Fritze</small>

<small>rene.fritze@wwu.de</small>

<small>Mathematics Münster</small>

<small>October 28, 2022</small>

<small>*1st MaRDI Workshop on Scientific Computing*</small>

---

<div class="container">

<div>

## Get the slides

[https://rene.fritze.me/22-10-mardi-workshop](https://rene.fritze.me/22-10-mardi-workshop)

</div>

<div>
<img src="qr_self.png" />
</div>
</div>

---

<img height="300px" src="WWUMuenster_Logo_2021_negativ.png" alt="MaRDI" />
<img height="300px" src="MaRDI_Logo_L_5_rgba.png" alt="MaRDI TA2" style="background-color:white"/>

---

# Outline

1. A story
1. Goals
2. Prototype
3. The future

---

# A story

---

<img src="alice.png" width="20%" >

## Meet Alice

- Alice has a new project: implement model order reduction for a
  complex PDE with specifically structured input data

<div class="footnote">

[Portrait illustration vector created by freepik - www.freepik.com](https://www.freepik.com/vectors/portrait-illustration)

</div>
---

## Meet Alice

- She inherited a C++ solver for the PDE
- She found a Julia package that can generate vector fields that
  exactly fit her model
- She discovered that pyMOR already implements all the MOR methods she'll need

---

## Option 1

- Reimplement the data field generation in her C++ code
- Reimplement all the MOR methods in her C++ code

---

## Option 2

- Learn the internals of calling Julia and Python Code
from C++
- Write custom bindings for her C++ solver

---

## Downsides

- Lots of code to rewrite.
- Translation needs expertise in 3 languages to get right.
- Writing bindings very different from usual workload
- Portability + Maintainability

---

## Option 3?

What if she could structure her code in a way
that enabled her to plug in a tool that does the bindings for her?

---

# `openInterfaces` Goals

- develop and establish open interface standards
- interconnect disparate numerical softwares
- lower the "I" barrier in FAIR

---

## interface standards

- data abstraction specifications
- API requirements for algorithms

---

## disparate software

Two packages adhering to `openInterface` standards
should be able to call into one another, no matter
their implementation language.

---

<div class="container">

<div>

# Prototype

[https://github.com/MaRDI4NFDI/open-interfaces/](https://github.com/MaRDI4NFDI/open-interfaces/)

</div>

<div>
<img src="qr_oif.png" />
</div>
</div>

---

## Prototype Project Setup

```mermaid
graph LR;
   Driver ==== Connector ==== Implementor;
```

---

## Prototype Project Setup

- Connector is a C library
- Driver isolated from Implementor
- Drivers can dynamically load or statically link against Connector
- Connector dynamically loads Implementor

---

## Runtime flow

```mermaid
sequenceDiagram
  autonumber
  participant Driver
  participant Connector
  participant Implementor

  Driver -->>+ Connector: (loads shared object)
  Driver ->>+ Connector: initialize language X
  Connector ->>+ Implementor: loads shared object
  Connector ->>+ Implementor: initialize
  Driver ->>+ Connector: call interface Function
  Connector ->>+ Implementor: call implementation
```

---

## Algorithm test cases

1. String expression evaluation
2. Linear system solve

   $Ax=b$

---

## API Design

```C
// Connector's interface (What the Drivers, aka Alice, see)
int oif_connector_init(const char *lang);
int oif_connector_eval_expression(const char *str);
int oif_connector_solve(int N, double* A,
                        double* b, double *x);
void oif_connector_deinit();
```

---

## API Design

```C
// Implementor's interface (What the Connector sees)
int oif_lang_init();
int oif_lang_eval_expression(const char *str);
int oif_lang_solve(int N, double* A,
                   double* b, double *x);
void oif_lang_deinit();
```

---

## Python -> Julia Example

```mermaid
sequenceDiagram
  autonumber
  participant Driver
  participant Connector
  participant Implementor

  Driver ->>+ Connector: ctypes.CDLL("liboif_connector.so")
  Driver ->>+ Connector: oif_connector_init("julia")
  Connector ->>+ Implementor: dlopen("liboif_julia.so")
  Connector ->>+ Implementor: oif_lang_init()
  Driver ->>+ Connector: oif_connector_eval_expression("print(6*7)")
  Connector ->>+ Implementor: oif_lang_eval_expression("print(6*7)")
```

---

## Available Drivers and Implementors

- C
- C++
- Python
- Julia
- (R)

---
<!--
## Misc

- Testing all Driver -> Implementor Combinations (with pytest)
- Documentation Setup (Sphinx + Doxygen via breathe) -->

---

# The near future

- Learn more from existing interopability projects like xSDK,
  FlexiBLAS, preCICE, FitBenchmarking
- Complete native, parametrized test suites for all drivers

---

# The future

- Evolve the prototype with pyMOR as an incubator.
- Reach out to other potential pilot users.
- Provide abstractions for the benchmark framework (MaRDI TA2).

---

# The far future

- Community created, machine readable, composable, API specifications.

---

# The far future

- Code generator for multiple languages that consumes these specs.

---

# The far future

- Multiple "backends" for data transfer

---

# The far future

- Implementing openInterfaces becomes community-wide best practice

---

<div class="container">

<div>

## Questions?

[https://rene.fritze.me/22-10-mardi-workshop](https://rene.fritze.me/22-10-mardi-workshop)

</div>

<div>
<img src="qr_self.png" />
</div>
</div>
