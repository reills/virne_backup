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
  id 1586
  arrival_time 35765.31749037446
  lifetime 92.14607992604058
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 20
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 39
    gpu 20
    rom 5
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 6
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 2
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 16
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
]
