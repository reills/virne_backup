graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1976
  arrival_time 43151.55149845829
  lifetime 720.2337609375287
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 32
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 41
    gpu 28
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 43
    gpu 50
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
]
