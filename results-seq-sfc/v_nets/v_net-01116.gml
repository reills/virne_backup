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
  id 1116
  arrival_time 23240.202878093856
  lifetime 930.2319180311623
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 35
    rom 45
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 11
    rom 29
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 21
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 40
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 8
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
]
