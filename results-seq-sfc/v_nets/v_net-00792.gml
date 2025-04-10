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
  id 792
  arrival_time 16617.607577442144
  lifetime 607.5823709920995
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 9
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 44
    rom 44
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 21
    rom 33
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 18
    rom 34
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 6
    rom 27
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 21
    rom 2
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
]
