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
  id 1099
  arrival_time 22862.513505245875
  lifetime 382.6938497287084
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 47
    gpu 33
    rom 16
  ]
  node [
    id 1
    label "1"
    cpu 42
    gpu 4
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 37
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 41
    gpu 40
    rom 24
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 34
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
]
