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
  id 1604
  arrival_time 35923.33571916085
  lifetime 730.2583862820314
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 45
    rom 47
  ]
  node [
    id 1
    label "1"
    cpu 50
    gpu 18
    rom 47
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 27
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 50
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 28
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 17
  ]
]
