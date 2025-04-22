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
  id 34
  arrival_time 603.0812473406521
  lifetime 341.3354896836663
  num_nodes 3
  type "path"
  node [
    id 0
    label "0"
    cpu 14
    gpu 18
    rom 19
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 9
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 49
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 10
  ]
  edge [
    source 1
    target 2
    bw 2
  ]
]
