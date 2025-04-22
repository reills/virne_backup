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
  id 1823
  arrival_time 40304.586167740636
  lifetime 1075.9348372358525
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 20
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 38
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 19
    gpu 33
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 5
    rom 24
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 41
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
]
