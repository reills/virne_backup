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
  id 936
  arrival_time 20018.455250678304
  lifetime 348.48138551411296
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 12
    gpu 30
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 33
    gpu 0
    rom 8
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 0
    rom 16
  ]
  node [
    id 3
    label "3"
    cpu 4
    gpu 18
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 43
    rom 17
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 39
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
]
