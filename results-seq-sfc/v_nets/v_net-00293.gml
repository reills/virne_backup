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
  id 293
  arrival_time 5680.524780385999
  lifetime 1866.862128988352
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 25
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 47
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 12
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 30
    rom 10
  ]
  node [
    id 4
    label "4"
    cpu 47
    gpu 43
    rom 19
  ]
  edge [
    source 0
    target 1
    bw 35
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 9
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
]
