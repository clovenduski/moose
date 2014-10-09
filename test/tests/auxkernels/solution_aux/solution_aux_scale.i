[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 2
  ny = 2
  xmin = 1
  xmax = 4
  ymin = 1
  ymax = 3
  # This test uses SolutionUserObject which doesn't work with ParallelMesh.
  distribution = serial
[]

[Variables]
  [./u]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[AuxVariables]
  [./u_aux]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./diff]
    type = Diffusion
    variable = u
  [../]
[]

[AuxKernels]
  [./initial_cond_aux]
    type = SolutionAux
    solution = xda_soln
    execute_on = initial
    variable = u_aux
  [../]
[]

[UserObjects]
  [./xda_soln]
    type = SolutionUserObject
    mesh = solution_aux_scale_build_out_0001_mesh.xda
    es = solution_aux_scale_build_out_0001.xda
    system_variables = u
    scale = '3 2 1'
    translation = '1 1 0'
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = u
    boundary = left
    value = 0
  [../]
  [./right]
    type = DirichletBC
    variable = u
    boundary = right
    value = 1
  [../]
[]

[Executioner]
  type = Steady
  solve_type = 'PJFNK'
  nl_rel_tol = 1e-10
[]

[Outputs]
  output_initial = true
  exodus = true
  xda = true
  [./console]
    type = Console
    perf_log = true
  [../]
[]
